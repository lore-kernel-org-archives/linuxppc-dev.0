Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id B57BADDF45
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 00:28:10 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: ioctl32 unknown cmds with 2.6.24-rc1
Date: Wed, 24 Oct 2007 16:27:17 +0200
References: <1193229045.4510.35.camel@johannes.berg>
In-Reply-To: <1193229045.4510.35.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200710241627.18284.arnd@arndb.de>
Cc: Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 24 October 2007, Johannes Berg wrote:
>   Show Details
>   I've been getting these warnings (many more of them but this is a list
> of unique ones) on my quad G5 with 32-bit userspace:
> 
> ioctl32(cdrom_id:1078): Unknown cmd fd(3) cmd(00005331){t:'S';sz:0} arg(00000000) on /dev/.tmp-3-0
> ioctl32(ata_id:1095): Unknown cmd fd(3) cmd(0000030d){t:03;sz:0} arg(ff863970) on /dev/.tmp-3-0
> ioctl32(smartd:3563): Unknown cmd fd(3) cmd(0000031f){t:03;sz:0} arg(ffeb5480) on /dev/sda
> ioctl32(hald-probe-stor:3761): Unknown cmd fd(4) cmd(00005320){t:'S';sz:0} arg(00000004) on /dev/hda
> ioctl32(gnome-terminal:4187): Unknown cmd fd(19) cmd(0000530b){t:'S';sz:0} arg(0fd8e400) on /dev/pts/0
> 
> Does anybody know whether this is expected?

It's probably my fault, since I changed the compat ioctl handling for
block devices. Geert already reported the same, but I haven't had
a chance to reproduce it on my system to look into what went wrong.
Probably a trivial bug I introduced in block/compat_ioctl.c

	Arnd <><
