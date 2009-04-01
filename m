Return-Path: <jt.conklin@xorp.net>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 08CB8DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 05:52:41 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so152742rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Apr 2009 11:52:39 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Apr 2009 11:52:39 -0700
Message-ID: <6c5c8a400904011152n1dadb9bdoa244004595dbd95e@mail.gmail.com>
Subject: Support for kernels with large (10MB+) initramfs images
From: "J.T. Conklin" <jt.conklin@xorp.net>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to embed the open source XORP routing stack in 85xx based
embedded system.  XORP's original design didn't consider the
possibility of an embedded deployment, so just getting it all to fit
within the 32MB flash of our target has been a challenge all by
itself.

The BSP/SDK from the ODM that used a separate kernel and initrd, with
a 2MB region reserved for the kernel and a 16MB region reserved for
the initrd.  However, I'm investigating whether it would be possible
to use a kernel with everything in a initramfs.  This currently gives
us a 12MB image, and I'd be able to have two complete firmware images
on the system (the remaining space would be used for a small jffs2
filesystem and u-boot itself).

Unfortunately, I haven't been able to get this large kernel booting.

The first problem I ran into was that the zImage wrapper was linked
with a load address of 4MB, so the image couldn't be relocated without
overwriting itself.  Changing zImage.lds.S to use a 32MB load address
fixed this problem.

I had hoped that that would be enough, but the kernel still does not
start.  I have not yet attempted to trace kernel bring up (with a
BDI3000), so I'm not quite sure what's gone wrong.

I've done a bit of web browsing this morning, and saw some suggestions
to change u-boot's CFG_BOOTMAPSZ from 8<<20 to 16<<20; but that hasn't
helped either.

I'll continue to poke at this on my own, but I'd appreciate if anyone
can point me in the right direction.

Many thanks,

    --jtc
