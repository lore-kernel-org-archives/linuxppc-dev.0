Message-ID: <38BC0705.93C1D390@mandrakesoft.com>
Date: Tue, 29 Feb 2000 12:51:01 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Paul Mackerras <paulus@linuxcare.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC should not use -fno-builtin (was Re: 2.3.47 imac build?)
References: <Pine.LNX.4.10.10002291744130.4907-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
> Patch appended (adbmouse.o is only built if CONFIG_BUSMOUSE is set and
> make complained about getting busmouse.o twice in the target line, so
> there).

Ignore the complaint, this patch is wrong.

With the "new-style" makefiles, adding busmouse.o to the end of the line
is the correct way to specify dependencies.  If your patch is applied, I
cannot build adbmouse into my kernel, as busmouse.o is never referenced
nor built.



> --- 2.3.48-devel/drivers/char/Makefile.org      Tue Feb 29 17:52:59 2000
> +++ 2.3.48-devel/drivers/char/Makefile  Tue Feb 29 16:42:32 2000
> @@ -154,7 +154,7 @@
>  obj-$(CONFIG_MIXCOMWD) += mixcomwd.o
>  obj-$(CONFIG_AMIGAMOUSE) += amigamouse.o
>  obj-$(CONFIG_ATARIMOUSE) += atarimouse.o
> -obj-$(CONFIG_ADBMOUSE) += adbmouse.o busmouse.o
> +obj-$(CONFIG_ADBMOUSE) += adbmouse.o
>  obj-$(CONFIG_PC110_PAD) += pc110pad.o
>  obj-$(CONFIG_WDT) += wdt.o
>  obj-$(CONFIG_RTC) += rtc.o

--
Jeff Garzik              | "Are you the police?"
Building 1024            |
MandrakeSoft, Inc.       | "No ma'am.  We're musicians."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
