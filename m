Return-Path: <John.Linn@xilinx.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 16048DDF2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 00:08:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
Date: Wed, 28 May 2008 08:07:59 -0600
In-Reply-To: <17482754.post@talk.nabble.com>
References: <17222725.post@talk.nabble.com><20080514150139.E258D8D006F@mail70-va3.bigfish.com><17276753.post@talk.nabble.com><20080516162807.2132E181804D@mail89-sin.bigfish.com><17454696.post@talk.nabble.com>
	<17482754.post@talk.nabble.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "swamydp" <swamydp@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080528140800.9ACE756007F@mail97-wa4.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Swamy,

Sorry for the long delay. Sounds like the console is not setup
correctly.

I notice in your command line it appears that you have 2 console
statements.  I have not tested this ever and I would change it to only
have the console=3DttyS0,9600.  I have seen other mailings, no Xilinx
specific, related to this causing problems.

This console setup assumes you're using the Xilinx 16550 UART.  It could
be an issue with the xparameters*.h file with the address of the UART.

Have you compared your arch/ppc/platforms/4xx/xparameters/xparameters*.h
file, whichever one it's setup to use, to the ones that we provided in
the Git tree?

I'm assuming you have the kernel configured correctly to use the
UART16550 driver and the console is turned on, both are needed.  The
16550 is 8250 compatible (mostly) and works with it's driver from Linux.

CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy

Thanks,
John

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of swamydp
Sent: Monday, May 26, 2008 10:12 PM
To: linuxppc-embedded@ozlabs.org
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board


Hi John

Please ignore my previous message. The kernel boots until initializing
the
root files system and then hangs. Thats expected since I do not have
root
file system set up yet. I dumped the __log_buf and found it. =


I don't understand why no message is printed by printk after "Now
booting".
Does console init occur after root file system init ?

Thanks
swamy



swamydp wrote:
> =

> Hi John
> =

> Sorry for getting back late. =

> =

> I have been debugging further using the UART to send output directly
to
> serial post. Now I see that just after entering start_kernel, a ITLB
miss
> exception occurs and linux hangs at that point. =

> =

> Looks like the kernel is probably not running at all yet, may stuck in
> early initialization.
> =

>>> Yes
> =

> 1. Has the kernel ever ran on this board or is this development to get
> it running?
> =

>>> No. This is a new board and I am trying to build a simple EDK system
>>> with only
> PPC, UART, PIC as the devices.
>  =

> 2. Not sure on the tools you are using to build it.  You mention the
> EDK, but you must not be using it's compiler as it's not configured in
> the EDK to build Linux. =

> =

>>> EDK 9.2 version, XMD for debug. Kernel 2.6 version is built in linux
>>> machine and zImage.elf is downloaded
> to the board.
> =

> Thanks for the UART suggestion, works well. Any suggestions as to what
> might be wrong in start_kernel function ? I will continue debugging
> meanwhile.
> =

> Thanks
> swamy
> =

> =

> =

> =


-- =

View this message in context:
http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-bo
ard-tp17222725p17482754.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
