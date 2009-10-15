Return-Path: <paul.gibson2074@gmail.com>
Received: from mail-vw0-f204.google.com (mail-vw0-f204.google.com
	[209.85.212.204]) by ozlabs.org (Postfix) with ESMTP id 68708B7B92
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 10:03:26 +1100 (EST)
Received: by vws42 with SMTP id 42so703143vws.17
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 16:03:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091015183039.A577EECA6BE@gemini.denx.de>
References: <4AD5ADC9.30503@embedded-sol.com> <4AD6F172.6030407@aimvalley.nl>
	<4AD6FD4E.9060507@marel.com> <4AD70585.40302@gmail.com>
	<4AD70927.3030401@marel.com>
	<20091015183039.A577EECA6BE@gemini.denx.de>
Date: Fri, 16 Oct 2009 09:03:24 +1000
Message-ID: <26b052040910151603y8fc9b00g678d6a873083f1e7@mail.gmail.com>
Subject: Re: MPC5121 CAN and USB
From: Paul Gibson <paul.gibson2074@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> The kernel from the BSP on Freescale site is crashing on the CAN in my c=
ase
>> =A0(might be a hardware bug).
>
> I don;t think so. There are some problems in this code, for example
> the clocks seem to be wrong. Not toi menthin that the whole code is
> hoplessly old and without chance of ever being merged into mainline.

The clocks are definitely wrong, but should not cause the crashing.
The only fix I needed for the ADS512101 board was to set the clock to
66MHz, instead of 100MHz in drivers/can/mscan/mscan.c:
clk->rate =3D 66000000;

Its a hack I know.

> The "ltib-mpc5121ads-20090602" branch reflects the exact state of the
> kernel contained in the LTIB with this name (dated July 2009, despite
> the name; based at 2.6.24.6, i. e. 7+ kernel versions behind).

I have diff'ed this and it is very similar to the ltib in the BSP.
The MBX patches may be missing though.  These patches can be obtained
via the Freescale SDK for the OpenGL on the MPC5121e webpage.

Paul
