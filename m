Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9ZCr4cZHzDr1r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:07:04 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7C64aaI096327
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 02:07:02 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rmj7sbcf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 02:07:02 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 12 Aug 2016 16:07:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D14CE3578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:06:57 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7C66vZg31195170
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:06:57 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7C66vdN007297
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:06:57 +1000
Subject: Re: [PATCH v4] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com
References: <1470947140-16366-1-git-send-email-mauricfo@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 12 Aug 2016 16:06:56 +1000
MIME-Version: 1.0
In-Reply-To: <1470947140-16366-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <42f3e4a5-32bd-5c49-0bd9-7db5d779655c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/16 06:25, Mauricio Faria de Oliveira wrote:
> This patch leverages 'struct pci_host_bridge' from the PCI subsystem
> in order to free the pci_controller only after the last reference to
> its devices is dropped (avoiding an oops in pcibios_release_device()
> if the last reference is dropped after pcibios_free_controller()).
>
> The patch relies on pci_host_bridge.release_fn() (and .release_data),
> which is called automatically by the PCI subsystem when the root bus
> is released (i.e., the last reference is dropped).  Those fields are
> set via pci_set_host_bridge_release() (e.g. in the platform-specific
> implementation of pcibios_root_bridge_prepare()).
>
> It introduces the 'pcibios_free_controller_deferred()' .release_fn()
> and it expects .release_data to hold a pointer to the pci_controller.
>
> The function implictly calls 'pcibios_free_controller()', so an user
> must *NOT* explicitly call it if using the new _deferred() callback.
>
> The functionality is enabled for pseries (although it isn't platform
> specific, and may be used by cxl).
>
> Details on not-so-elegant design choices:
>
>  - Use 'pci_host_bridge.release_data' field as pointer to associated
>    'struct pci_controller' so *not* to 'pci_bus_to_host(bridge->bus)'
>    in pcibios_free_controller_deferred().
>
>    That's because pci_remove_root_bus() sets 'host_bridge->bus = NULL'
>    (so, if the last reference is released after pci_remove_root_bus()
>    runs, which eventually reaches pcibios_free_controller_deferred(),
>    that would hit a null pointer dereference).
>
>    The cxl/vphb.c code calls pci_remove_root_bus(), and the cxl folks
>    are interested in this fix.
>
> Test-case #1 (hold references)
>
>   # ls -ld /sys/block/sd* | grep -m1 0021:01:00.0
>   <...> /sys/block/sdaa -> ../devices/pci0021:01/0021:01:00.0/<...>
>
>   # ls -ld /sys/block/sd* | grep -m1 0021:01:00.1
>   <...> /sys/block/sdab -> ../devices/pci0021:01/0021:01:00.1/<...>
>
>   # cat >/dev/sdaa & pid1=$!
>   # cat >/dev/sdab & pid2=$!
>
>   # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
>   Validating PHB DLPAR capability...yes.
>   [  594.306719] pci_hp_remove_devices: PCI: Removing devices on bus 0021:01
>   [  594.306738] pci_hp_remove_devices:    Removing 0021:01:00.0...
>   ...
>   [  598.236381] pci_hp_remove_devices:    Removing 0021:01:00.1...
>   ...
>   [  611.972077] pci_bus 0021:01: busn_res: [bus 01-ff] is released
>   [  611.972140] rpadlpar_io: slot PHB 33 removed
>
>   # kill -9 $pid1
>   # kill -9 $pid2
>   [  632.918088] pcibios_free_controller_deferred: domain 33, dynamic 1
>
> Test-case #2 (don't hold references)
>
>   # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
>   Validating PHB DLPAR capability...yes.
>   [  916.357363] pci_hp_remove_devices: PCI: Removing devices on bus 0021:01
>   [  916.357386] pci_hp_remove_devices:    Removing 0021:01:00.0...
>   ...
>   [  920.566527] pci_hp_remove_devices:    Removing 0021:01:00.1...
>   ...
>   [  933.955873] pci_bus 0021:01: busn_res: [bus 01-ff] is released
>   [  933.955977] pcibios_free_controller_deferred: domain 33, dynamic 1
>   [  933.955999] rpadlpar_io: slot PHB 33 removed
>
> Suggested-By: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com> # cxl

Does this justify a Cc: stable?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
