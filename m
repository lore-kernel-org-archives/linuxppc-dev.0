To: "ByungGiBaek" <weapon100@hanmail.net>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ppcboot & kernel upgrade problem(2.4.x kernel does not work) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Jan 2002 15:50:01 +0900."
             <20020115155001.HM.60000000003dHZi@www7.hanmail.net>
Date: Tue, 15 Jan 2002 08:33:42 +0100
Message-Id: <20020115073347.8802310B6C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear ByungGi Baek,

in message <20020115155001.HM.60000000003dHZi@www7.hanmail.net> you wrote:
>
> Now I'm trying to upgrade linux kernel from 2.2.14 to 2.4.x on our own MPC860T board(50MHz).
> I successfully download and boot linux-2.2.14 kernel with ppcboot-0.9.3.

You must update PPCBoot to a newer version:

    Q:

        I am using PPCBoot version X (X >= 1.0.5) with a Linux kernel
        version Y (Y < 2.4.5-pre5), but the last message I see is

         Uncompressing Kernel Image ... OK

        Then the system hangs.

    A:

        Most probably you pass bad parameters to the Linux kernel.
	There are several possible reasons:

            Bad definition of the bd_info structure

            You must make sure that your machine specific header file
            (for instance include/asm-ppc/tqm8xx.h) includes the same
            definition of the Board Information structure as we
            define in include/ppcboot.h, and make sure that your
            definition of IMAP_ADDR uses the same value as your
            PPCBoot configuration in CFG_IMMR.

            Bad clock information

            Before kernel version 2.4.5-pre5 (BitKeeper Patch
            1.1.1.6, 22MAY2001) the kernel expected the clock
            information in MHz, but recent kernels expect it in Hz
            instead. Starting with version 1.0.5, PPCBoot passes the
            clock information in MHz by default. To switch to the old
            behaviour, you can set the environment variable
            "clocks_in_mhz" in PPCBoot:

                     => setenv clocks_in_mhz 1
                     => saveenv



In your case it's most  probably  the  clock  frequency:  the  kernel
expects Hz, but the old PPCBoot passes MHz.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
He'd heard her use that sweet, innocent  tone  of  voice  before.  It
meant that, pretty soon, there was going to be trouble.
                                        - Terry Pratchett, _Truckers_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
