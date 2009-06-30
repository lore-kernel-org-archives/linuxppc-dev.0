Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by bilbo.ozlabs.org (Postfix) with ESMTP id CA71BB70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 14:36:47 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so235844rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 21:36:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <97dd5fd20906300911k7b1e72banf61bcb9ff500787@mail.gmail.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
	<4A4901A8.5010402@mlbassoc.com>
	<97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
	<4A490AE4.7000509@freescale.com>
	<97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
	<4A49249C.5080101@freescale.com>
	<97dd5fd20906291346s3ee60edbr1863c27280ae373c@mail.gmail.com>
	<4A492C1A.6020302@freescale.com>
	<97dd5fd20906300911k7b1e72banf61bcb9ff500787@mail.gmail.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Tue, 30 Jun 2009 12:48:58 -0500
Message-ID: <97dd5fd20906301048o30354271haf603a9bae29b0fe@mail.gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I'll still try to figure out how to get u-boot to fill all this in.
Got it... thanks to
"http://www.mail-archive.com/u-boot-users@lists.sourceforge.net/msg05111.html"

I made sure that CONFIG_OF_LIBFDT and CONFIG_OF_BOARD_SETUP were both
present in "u-boot-2009.03/include/configs/EP88x.h". Then added the
following to the very end of "u-boot-2009.03/board/ep88x/ep88x.c":

#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
void ft_board_setup(void *blob, bd_t *bd)
{
         ft_cpu_setup(blob, bd);
}
#endif /* defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP) */

I suppose I could have put this code in w/o the "#if defined..." and
forget about the "CONFIG_OF_BOARD_SETUP" flag since I'm not really
using the "fdt boardsetup" command, but whatever.

As for my device tree, I reverted back to the original version with
nothing filled in and just replaced 0xfa20xxxx with 0xf000xxxx as Gary
suggested earlier.

Once again, thanks to all those who offered suggestions!
