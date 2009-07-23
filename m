Return-Path: <stef.simoens@scarlet.be>
Received: from fb2.tech.numericable.fr (fb2.tech.numericable.fr
	[82.216.111.50])
	by bilbo.ozlabs.org (Postfix) with ESMTP id EF14EB70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 08:39:08 +1000 (EST)
Received: from smtp1.tech.numericable.fr (smtp1.nc.sdv.fr [10.0.0.24])
	by fb2.tech.numericable.fr (Postfix) with ESMTP id B3B931BCC6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:19:07 +0200 (CEST)
Received: from robin.bunderbos (cable-83.217.136.59.coditel.net
	[83.217.136.59])
	by smtp1.tech.numericable.fr (Postfix) with ESMTP id A1157E0805
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:19:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by robin.bunderbos (Postfix) with ESMTP id 65D142089081
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:19:03 +0200 (CEST)
Received: from robin.bunderbos ([127.0.0.1])
	by localhost (robin.bunderbos [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p14pUXv3vHHq for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:18:55 +0200 (CEST)
Received: from [192.168.0.188] (gnarl.bunderbos [192.168.0.188])
	by robin.bunderbos (Postfix) with ESMTP id 08D4C2089080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:18:54 +0200 (CEST)
Message-ID: <4A68E1CE.4040307@scarlet.be>
Date: Fri, 24 Jul 2009 00:18:54 +0200
From: Stef Simoens <stef.simoens@scarlet.be>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: BUG in dma-mapping.h:218 // MESH SCSI driver not working
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello list,

I'm running Gentoo Linux with kernel 2.6.29 on a PPC9600 with a G3 
processor upgrade.
My boot drive is on the internal "mesh" SCSI-controller. Self-compiled 
kernel 2.6.29 is running fine for quite some time.

However, after compiling 2.6.30 (with more or less the same 
configuration), I get this BUG (typed over from a picture, sorry for 
possible typos):
kernel BUG at 
/usr/src/linux-2.6.30-gentoo-r3/arch/powerpc/include/asm/dma-mapping.h:218!
Oops: Exception in kernel mode, sig: 5 [#1]
PowerMac
Modules linked in:
NIP: c01bb4cc LR: c01c01cc CTR: c01c01
REGS: ...
MSR: ...
TASK = c030f500[0] 'swapper' THREAD: ...
GPR00: ...
GPR08: ...
GPR16: ...
GPR24: ...
NIP [c01bb4cc] scsi_dma_map+0x4c/0x7c
LR [c01c01cc] start_phase+0x3a0/0x5c8

I found on the list a patch by Benjamin : 
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073468.html
I applied this patch to the 2.6.30 source-tree.
After applying this patch, the BUG dissapears, but the mesh controller 
still is not able to read any data from disk. The screen output is:
mesh: performing initial bus reset...
ADB mouse at 3, handler set to 2
input: ADB mouse as /devices/virtual/input/input2
adb: finished probe task...
scsi0: MESH
mesh: target 0 synchronous at 10MB/s
scsi 0:0:0:0: Direct-Access ...
mesh: target 1 synchronous at 10 MB/s
scsi 0:0:1:0: Direct-Access ...
mesh: target 3 synchronous at 10 MB/s
scsi 0:0:3:0: CD-ROM ...
mice: PS/2 mouse device common for all mice
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
[there's a long time-out here]
mesh_abort(ef8501e0)
mesh: state at ef868a4c, regs at f1010000, dma at
    ct=   1 seq=5a bs=4023 fc= 0 exc= 0 err= 0 in=
    dma stat=e0 cmdptr=2f8d4010
    phase=6 msgphase=4 conn_tgt=0 data_ptr=0
    dma_st=0 dma_ct=0 n_msgout=0
    target 0: req=ef8501e0 goes_out=0 saved_ptr=0
mesh_abort(ef850280)
(continues some times, to finally panic because the root-device cannot 
be found)

I tried the latest 2.6.31-rc3-git3 (without any other patch).
However, I have the same behaviour as the patched 2.6.30 (so: no BUG, 
but the mesh_abort messages).

Anybody knows what's going wrong, and how to fix it? I've read the 
history of this list of June and July ... but I didn't find any other 
reports of the problem I'm encountering...

Thank you for your help.

Kind regards

Stef Simoens
