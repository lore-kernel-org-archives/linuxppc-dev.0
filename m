Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F413AB6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 22:04:24 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p2MB4F1S027695
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2011 12:04:16 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Booting with ramdisk in kernel
Date: Tue, 22 Mar 2011 12:04:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201103221204.12376.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
I already posted this on the buildroot mailing list, so apologies for the dupe, but maybe it's more relevant here.

I'm trying to do something very classic, but it doesn't seem to work and the more I read about it the more I'm confused 
by the amount of antiquated info and nearly-but-not-quite-so relevant info (like doing a temporary ramdisk before the 
'real' OS loads).

So I have a kernel and a buildroot-generated OS, currently on an NFS server. I boot with the following kernel parameters 
and everything goes fine:
console=ttyUL0,115200 rw root=/dev/nfs ip=bootp

Now I want to embed that OS in the kernel (no need for a network anymore as the kernel is on a flash mem and I wrote my 
own bootloader). So I did the following:
- add ROOTFS CPIO to the buildroot options and make a new version
- point CONFIG_INITRAMFS_SOURCE to the resulting rootfs.cpio file
- change the kernel parameters to "console=ttyUL0,115200 root=/dev/ram" (that's in a dts file)
- some documentation talks about CONFIG_BLK_DEV_RAM but I can't find that option in the menuconfig, so maybe that's the 
problem.

When my bootloader jumps to 0x400000, the kernel stops instantly without even a blip on the console. A debugger reveals 
that it stops at 0x401718... I have no idea what's going on at this stage.

What am I doing wrong ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
