Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 71D37DDF78
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 03:37:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: pci_dev start/stop addresses
Date: Mon, 5 Mar 2007 11:37:13 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90106BF2D19@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am trying to port/debug a driver on a 32bit MPC8548E platform=20
that is reading the resource start address in the PCI Device=20
structure (struct pci_dev). I should mention this driver was
original developed on an X86 platform and works flawlessly...

But, when this driver reads the start value in this struct=20
into a local unsigned long value - it comes up as '0x0' (and=20
prints out the same via %lx).

Looking closer, it seems that this value is a size - resource_size_t=20
- that resolves into a u32 value (and I have printed the physical=20
size sizeof(resource_size_t)) and it seems to be the correct size(4).

I am also looking into the sysfs and it appears that for=20
this device on the pci bus - it is being 'stored' in this=20
resource file as a 64bit value?

I am confused as to what is actually in this PCI device=20
structure and/or what is actually returned. I do know that
the even though the start address is coming back as '0',=20
the length being calculated is correct (end-start=3Dlength)?

It seems to be me, I have some type of mismatch in the=20
device tree types and/or an endian problem.

Any insight would be appreciated here!

Tom Morrison
Principal Software Engineer

EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com=20
www.empirix.com
