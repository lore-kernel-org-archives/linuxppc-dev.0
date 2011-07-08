Return-Path: <B08248@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBB871007D1
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jul 2011 04:43:57 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Gala Kumar-B11780 <B11780@freescale.com>
Subject: RFC:  top level compatibles for virtual platforms
Date: Fri, 8 Jul 2011 18:43:47 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With KVM on Freescale booke parts we have currently two general types of
virtual platforms-- 1) an 85xx-like platform with e500v2 cpus,
etc, and 2) a P4080-like platform with a corenet based bus.

Today QEMU passes through to the guest a device tree with
a top level compatible of either "MPC8544DS", or "fsl,P4080DS".
These work but neither is quite accurate this is used on all targets
regardless of the underlying physical hardware.  Also, the guest
device tree represents virtual devices as well as a subset of the
cpus, memory, and devices on the hardware platform.

So continuing to use "MPC8544DS" or "fsl,P4080DS" compatible for all QEMU/K=
VM
created virtual machines is misleading and seems hackish.  They are
compatible to a degree, but the virtual platform would typically
be quite different.

What do you all think about creating some new somewhat generic=20
machine types in Linux to represent these 2 types of virtual
platforms.  Perhaps:

   "MPC85xxDS" - for a virtual machine for the e500v2 type platforms
                 and would support 85xx targets, plus P2020, P1022,etc

   "corenet-32-ds" - for a virtual machine similar to the 32-bit P4080
                     platforms

   "corenet-64-ds" - for a virtual machine based on a 64-bit corenet
                     platform


Thoughts?

Thanks,
Stuart Yoder
