Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8C8J0cwbzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:44:15 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A0hQ6p094041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 20:44:13 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9puwbv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 20:44:13 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 21:44:11 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 5AD0F352006E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:43:48 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A0i8g616253334
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 21:44:08 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A0i8UZ006312
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 21:44:08 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] powerpc: fix oops in pcibios_release_device() after
 pcibios_free_controller()
Date: Tue,  9 Aug 2016 21:44:02 -0300
Message-Id: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset addresses the problem/suggestion discussed previously [1],
by adding a kref reference counting to the PHB (struct pci_controller):

> It's possible to hit an oops/crash if pcibios_release_device() accesses the
> phb struct and it had been freed earlier -- by pcibios_free_controller() --
> as the memory it pointed to can be reused.

> If after reuse 'phb->controller_ops.release_device' is non-NULL it will be
> called, but it points to an invalid location (that function pointer is not
> set anywhere in the code, so if it's non-NULL, that's not correct), and so
> it hits an oops and the system crashes.

> That problem can happen with the pSeries platform's DLPAR remove operation
> if references to devices are held until after the pcibios_free_controller()
> function runs, and then released - exercising pcibios_release_device() path.

More problem details/call trace are described in the original submission [1].

With the patch applied (tested on 4.8-rc1), the test-case demonstrates that
the PHB is only released/freed after the last reference to the PCI device(s)
is dropped:

  Enable debugging messages:

  # echo 'file pci-common.c +pf; file pci-hotplug.c +pf' > /sys/kernel/debug/dynamic_debug/control
  # echo 8 > /proc/sys/kernel/printk

  Hold references to both PCI devices in the PHB:

  # ls -ld /sys/block/sd* | grep -m1 0021:01:00.0
  <...> /sys/block/sdaa -> ../devices/pci0021:01/0021:01:00.0/<...>
  
  # ls -ld /sys/block/sd* | grep -m1 0021:01:00.1
  <...> /sys/block/sdab -> ../devices/pci0021:01/0021:01:00.1/<...>
  
  # cat > /dev/sdaa & pid1=$!
  # cat > /dev/sdab & pid2=$!
  
  Perform DLPAR remove of the PHB:

  # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
  Validating PHB DLPAR capability...yes.
  [  888.776964] pci_hp_remove_devices: PCI: Removing devices on bus 0021:01
  [  888.776983] pci_hp_remove_devices:    Removing 0021:01:00.0...
  ...
  [  893.696431] pci_hp_remove_devices:    Removing 0021:01:00.1...
  ...
  [  908.352717] pci_bus 0021:01: busn_res: [bus 01-ff] is released
  [  908.352744] pcibios_remove_bus: PCI 0021:01, pci_bus c0000001e7d59400, phb c0000001e7d57400
  [  908.352753] controller_put: PCI domain 33, phb c0000001e7d57400
  [  908.352811] pcibios_free_controller: PCI domain 33, phb c0000001e7d57400, phb->is_dynamic 1
  [  908.352820] controller_put: PCI domain 33, phb c0000001e7d57400
  [  908.352832] rpadlpar_io: slot PHB 33 removed
  
  Notice the PHB was not freed yet (controller_free() was not called)

  Drop the last references to the PCI devices:

  # kill -9 $pid1
  [  991.221998] pcibios_release_device: PCI 0021:01:00.0, pci_dev c0000001ee0b7000, phb c0000001e7d57400
  [  991.222005] controller_put: PCI domain 33, phb c0000001e7d57400
  
  # kill -9 $pid2
  [  996.076293] pcibios_release_device: PCI 0021:01:00.1, pci_dev c0000001ee0b3800, phb c0000001e7d57400
  [  996.076299] controller_put: PCI domain 33, phb c0000001e7d57400
  [  996.076303] controller_free: PCI domain: 33, phb c0000001e7d57400, phb->is_dynamic 1

  Notice that only now the PHB was freed.

Note: this patchset currently covers references from struct pci_dev/pci_bus,
which _is_ enough to resolve this particular problem; it does not yet cover
references from struct pci_dn/eeh_pe/eeh_dev (but since those are unchanged
by/unrelated to this patchset, they remain working in the very same manner).

I have gone to great lengths in time studying the relevant code for EEH in
order to implement those too, but am not yet sure of all the details (e.g.,
lifetime of eeh_dev, removal of pci_dn, etc) that need to be considered to
kfree() them - will likely ask Gavin & maintainers for RFC after some time.

Links:
  [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-July/145264.html 

Changelog:
  v2: change approach to use krefs (suggestion by benh & mpe).

Mauricio Faria de Oliveira (2):
  powerpc: add refcount to struct pci_controller
  powerpc: update pci_controller.refcount for PCI devices and buses

 arch/powerpc/include/asm/pci-bridge.h | 15 ++++++++
 arch/powerpc/kernel/pci-common.c      | 72 +++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/pci-hotplug.c     | 29 ++++++++++++++
 arch/powerpc/kernel/pci_of_scan.c     |  1 +
 4 files changed, 114 insertions(+), 3 deletions(-)

-- 
1.8.3.1
