Message-ID: <399D00D4.EBB750A4@wanadoo.fr>
Date: Fri, 18 Aug 2000 11:24:36 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mberglund <matt@realestatesafari.com>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel compile errors in latest snap
References: <Pine.LNX.4.21.0008180131200.1723-100000@europa.rcinfo.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

both of the bugs you show have been mentioned here in the last couple of
days, and both are, despite heroic efforts by Paul and Cort to update
the bitkeeper tree to a working state, still present in the bitkeeper
tree (as is this annoying ifdef CONFIG_PPC_RTC bug in
arch/ppc/kernel/ppc_ksyms.c!)

mberglund wrote:
>
> Howdy guys, writing from sunny central florida.
>
> I'm trying to use the development kernel linuxppc_2_3.snap.tar.gz from
> fsmlabs from Aug 17 (the time stamp was about 6:59am our time). This is on
> a pmac 7200 which is running linuxppc 2000 and has had no real problems.
>
> The issue: Upon compiling the kernel we found some errors, one of which
> Chris (guy I work with) patched. The other is way outta my league. Where
> should mac_keyb.c be compiled from within the build?

It isn't. According to drivers/macintosh/Makefile, it is compiled in if
you have CONFIG_ADB_KEYBOARD=y or =m, but since the changes for the new
input layer on 2000/07/27, you cannot choose this config option any
more. The new input layer has not yet been accepted by Linus, so it is
probably better to keep the old files around, too.

> These are the errors and from where that function is referenced.
>
> drivers/input/inputdrv.o: In function `keyboard_input':
> drivers/input/inputdrv.o(.text+0x6c): undefined reference to
> `input_keycode'
[]
> drivers/input/adbhid.c:static void adbhid_input_keycode(int, int, int);
> drivers/input/adbhid.c: input_keycode(id, data[1], 0);
> drivers/input/adbhid.c:         input_keycode(id, data[2], 0);
> drivers/input/adbhid.c:adbhid_input_keycode(int id, int keycode, int

This has been mentioned before. Until someone fixes it on bitkeeper,
just change the 2 occurrencies of input_keycode in
drivers/input/adbhid.c to adbhid_input_keycode.

> diff:
>
> -ur linuxppc_2_3.orig/drivers/macintosh/via-cuda.c linuxppc_2_3/drivers/macintosh/via-cuda.c
> --- linuxppc_2_3.orig/drivers/macintosh/via-cuda.c      Thu Aug 17 02:46:34 2000
> +++ linuxppc_2_3/drivers/macintosh/via-cuda.c   Thu Aug 17 10:57:10 2000
> @@ -121,7 +121,7 @@
>  };
>
>  #ifdef CONFIG_PPC
> -void
> +int
>  find_via_cuda()
[]

Seems that Paul and Cort disagreed whether this should be void or int.
For a while it was int in include/linux/cuda.h and void in
drivers/macintosh/via-cuda.c, right now it is the other way round :-). I
guess it should be int in both cases, and you have to add int (0 or 1)
returns at four places, not only one.

On the other hand, even if it compiles, it will probably not boot (see
the recent discussion here). It might boot with yesterday's and today's
merging of test7-pre4, in particular changes to fs/exec.c, but this has
to be seen.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
