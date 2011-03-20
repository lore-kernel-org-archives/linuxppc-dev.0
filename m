Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E60F5B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Mar 2011 14:41:26 +1100 (EST)
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com
	[172.25.149.1]) by smtp-out.google.com with ESMTP id p2K3fJY9023288
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2011 20:41:19 -0700
Received: from iwn34 (iwn34.prod.google.com [10.241.68.98])
	by hpaq1.eem.corp.google.com with ESMTP id p2K3fB8s001232
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2011 20:41:18 -0700
Received: by iwn34 with SMTP id 34so6643920iwn.33
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 20:41:18 -0700 (PDT)
Date: Sat, 19 Mar 2011 20:41:02 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: powerpc/pci sysdata batch hangs G5 boot
Message-ID: <alpine.LSU.2.00.1103192023140.1592@sister.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

I've been unable to boot mmotm on the G5 for a few weeks; and now that
the problem has reached Linus, I've bisected and it converges on your:

commit b5d937de0367d26f65b9af1aef5f2c34c1939be0
    powerpc/pci: Make both ppc32 and ppc64 use sysdata for pci_controller
   
    Currently, ppc32 uses sysdata for the pci_controller pointer, and
    ppc64 uses it to hold the device_node pointer.  This patch moves the
    of_node pointer into (struct pci_bus*)->dev.of_node and
    (struct pci_dev*)->dev.of_node so that sysdata can be converted to always
    use the pci_controller pointer instead.  It also fixes up the
    allocating of pci devices so that the of_node pointer gets assigned
    consistently and increments the ref count.

The last message I see on screen when booting is
mpic: ISU size: 124, shift: 7, mask: 7f

Usually that would be followed by
mpic: Initializing for 124 sources

but with your commit it just hangs; revert that commit,
from mmotm or from Linus's current git, and all is fine.

Config available privately on request.  Noticing that patch is a
PPC OF PCI thing, and that I have CONFIG_PPC_OF_PLATFORM_PCI off,
I did try switching that on, but it made no difference.

Thanks,
Hugh
