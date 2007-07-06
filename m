Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1BC7DDFF7
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 03:04:15 +1000 (EST)
Message-ID: <468E6E33.3040000@zytor.com>
Date: Fri, 06 Jul 2007 09:30:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Too verbose compat_ioctl messages?
References: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> 
> Fuse-san discovered that running the umount that's part of busybox on a PS3
> with a recent kernel causes an error message to be printed on the console:
> 
> | ioctl32(busybox:1340): Unknown cmd fd(3) cmd(00004c01){t:'L';sz:0} arg(00000000) on /dev/sda1 
> 
> On older kernels (e.g. 2.6.16), this doesn't happen.
> 
> It can easily be reproduced by installing busybox and running
> 
> | busybox umount /mountpoint
> 
> on a mounted filesystem (except when using the loop device).
> 
> Apparently Busybox uses the LOOP_CLR_FD ioctl when unmounting a file system,
> which is supported by the loop device only.
> On other block device types, this ioctl is not supported:
>   - With a 64-bit application, the block layer returns ENOTTY (Inappropriate
>     ioctl for device), while the SCSI layer returns EINVAL (Invalid argument)
>   - With a 32-bit application, the compat_ioctl code returns EINVAL (Invalid
>     argument) and prints an error on the console (for the first 50
>     occurrencies, cfr. fs/compat_ioctl.c:compat_sys_ioctl())
> 
> As I understand, compat_ioctl_error() is used to inform the user about ioctl
> values that are not yet handled by the compat_ioctl layer. However, LOOP_CLR_FD
> doesn't need to be handled (no data to convert between 32-bit and 64-bit), and
> it's perfectly valid for a block device to not implement it.
> So it's confusing to print this error message.
> 
> Is there anything we can do about this?
> 

For one thing, it looks like we're returning the wrong thing (EINVAL
rather than ENOTTY) across the board.  This was unfortunately a common
misunderstanding with non-tty-related ioctls in the early days of Linux.

	-hpa
