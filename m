Message-ID: <389C6ABF.1138CC1B@mandrakesoft.com>
Date: Sat, 05 Feb 2000 13:23:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Chas Williams <chas@cmf.nrl.navy.mil>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
References: <200002051456.JAA34961@borg.cmf.nrl.navy.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chas Williams wrote:
>
> >In message <Pine.LNX.3.96.1000204232520.15802L-100000@mandrakesoft.mandrakesoft.com>,Jeff Garzik writes:
> >This patch is wrong.  I fixed nvram to use initcalls.
> >If nvram doesn't load you have other problems.
>
> ok, i see the problem, with __initcall, which is missing in
> drivers/macintosh/nvram.c, so this patch is more correct, however it still
> doesnt work after making this change.  i believe the reason is ld related,
> when vmlinux is linked, __initcall_nvram_init resides in macintosh.a along
> with another initcall function, __initcall_adb_init.  after linking
> vmlinux only contains __initcall_adb_init:

Ah!  The solution:  follow the example in other makefiles, and create
'macintosh.o' not 'macintosh.a'.  That is the only problem...

initcall gets removed during link if you use an 'ar' library.  This is
why some of the core subsystems have been changed from 'ar' to 'ld
-r'...  As this change stops the elimination of dead code, you must
ensure that no dead code exists by virtue of a bug-free Makefile and
Config.in system.

--
Jeff Garzik         | See you at Linux Expo in Paris!
Building 1024       |
MandrakeSoft, Inc.  |

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
