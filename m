Date: Fri, 24 May 2002 16:40:39 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: Dan Kegel <dkegel@ixiacom.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: in_ntoa built error
Message-ID: <20020524164039.A21633@home.com>
References: <9A9C83C019F35D47A570460E87D5D8AB0125EAC0@racerx.ixiacom.com> <20020524230359.33739.qmail@web11507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020524230359.33739.qmail@web11507.mail.yahoo.com>; from kqtrinh@yahoo.com on Fri, May 24, 2002 at 04:03:59PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 24, 2002 at 04:03:59PM -0700, Khai Trinh wrote:
>
> By the way, the snippet of the failing log of the
> kernel when it was downloading are captured below:

<snip>

> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>
> kmod: failed to exec /sbin/modprobe -s -k
> block-major-22, errno = 2
>
> VFS: Cannot open root device "" or 16:01
>
> Please append a correct "root=" boot option
>
> Kernel panic: VFS: Unable to mount root fs on 16:01

This is normal behavior for your configuration.  On the ebony
port, the default ROOT_DEV is 16:01 (/dev/hda1) if you
don't have CONFIG_BLK_DEV_INITRD or CONFIG_ROOT_NFS
configured.  You can even see kmod trying to load
an ide driver for you.

With CONFIG_ROOT_NFS enabled, it will attempt to root from 00:ff,
the nfs pseudo root device.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
