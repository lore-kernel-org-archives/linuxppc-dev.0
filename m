Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 34BB0DE08B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 01:05:18 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so782353anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Apr 2008 07:05:17 -0700 (PDT)
Message-ID: <fa686aa40804030705n39dd163aqd18159be31964e60@mail.gmail.com>
Date: Thu, 3 Apr 2008 08:05:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: [PATCH 3/3][POWERPC][V2] Xilinx: boot support for Xilinx uart
	16550.
In-Reply-To: <20080403132901.B50D1194805D@mail96-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12071551351007-git-send-email-john.linn@xilinx.com>
	<20080402165216.C835D1CF8088@mail12-sin.bigfish.com>
	<7e0dd21a0804030623s3571716fk8585b517c9aac1ed@mail.gmail.com>
	<20080403132901.B50D1194805D@mail96-sin.bigfish.com>
Cc: Johann Baudy <johaahn@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 3, 2008 at 7:28 AM, John Linn <John.Linn@xilinx.com> wrote:
> Hi Johann,
>
> You're right about it being missing. I have another patch for virtex
> specific initialization that handles that.  I have not submitted it yet as I
> was trying to get these patches thru the system.
>
> I have been told in this forum that the bootstrap loader should not be
> setting up the baud rate and that normally the boot loader does it.
>
> In the case of FPGAs, we don't always use a boot loader so we need this to
> happen in the bootstrap loader.  I can forward that patch to you if you're
> interested before it goes to this group.
>

Yes, the reason for not fiddling with the clock rate divisor at this
point is that it increases the chance of getting at least *something*
out the serial port if the boot goes bad.  For example, if the device
tree has the clock rate listed incorrectly and the wrapper sets the
serial port baud rate then the serial port will become unusable for
bootwrapper debug.

So, in the FPGA case or other no-firmware situations there needs to be
a place to do this.  Thinking on it further, I suppose it really does
belong in the serial driver, but it needs to be protected so that only
board ports that explicitly request it will do baud rate setup.
Perhaps ns16550_console_init() should call a __weak function that can
be overridden by a board port with a version that returns 1 instead of
0.  (off the top of my head; there may be better approaches).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
