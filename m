Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rM1rp1LQlzDq8G
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jun 2016 10:23:05 +1000 (AEST)
Message-ID: <1464999780.22191.53.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Marwa Hamza <marwahamza63@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 03 Jun 2016 19:23:00 -0500
In-Reply-To: <CAGF64GXnJ-qPHo6xoueE5hPmuNFDG+n+oNWr-O1J1kaUD0zyDg@mail.gmail.com>
References: <CAGF64GXnJ-qPHo6xoueE5hPmuNFDG+n+oNWr-O1J1kaUD0zyDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: running qemu for powerpc (32bits) architecture
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-30 at 10:04 +0100, Marwa Hamza wrote:
> hello everyone
> I'm trying to run qemu for powerpc architecture but either
> 1/ i got a black screen with this sentence " QEMU 2.4.0.1 monitor - type
> help for more information"
>                        (QEMU)
> if i run this command ./ppc-softmmu/qemu-system-ppc -M ppce500 -kernel
> ../linux-4.4.1/arch/powerpc/boot/zImage -initrd powerpc/busybox
> -1.21.0/rootfs.img.gz -append "root=/dev/ram rdinit=/bin/sh"

I can't help with the other platforms, but for ppce500, make sure you have
CONFIG_PPC_QEMU_E500 enabled in the kernel (and that it's an e500 build, of
course), pass either uImage or vmlinux (not zImage) to -kernel, and specify
the desired cpu type on the QEMU command line (using -cpu) to match the type
of kernel you built.  I recommend using e500mc rather than older e500 because
then you get standard floating point which your RFS may depend on.

Also note that this target will have a serial port for output, not a display,
so configure QEMU appropriately with -serial for how you want to access that.

If you need more help (especially with other PPC platforms) I suggest the 
qemu-ppc@nongnu.org mailing list.

-Scott
