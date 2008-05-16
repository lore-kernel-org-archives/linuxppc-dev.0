Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 38A20DDF38
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 07:58:08 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so320949anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 14:58:07 -0700 (PDT)
Message-ID: <fa686aa40805161458j6c940247j23de839b2e5ba48@mail.gmail.com>
Date: Fri, 16 May 2008 15:58:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [RFC PATCH 0/4] Describe SPI devices in the OF device tree and
	add mpc5200-spi driver
In-Reply-To: <9e4733910805161442s7c457a6ekc8236d947613a386@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<9e4733910805161327u4c42fd1dg5b09319d89db447c@mail.gmail.com>
	<fa686aa40805161348t52b94956w112ef6926ff30892@mail.gmail.com>
	<9e4733910805161425i2d6cc034y3377af053a4198b5@mail.gmail.com>
	<fa686aa40805161432w6b5243f9nb0d0c32a87d86d02@mail.gmail.com>
	<9e4733910805161442s7c457a6ekc8236d947613a386@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(dropping spi and linux-kernel mailing lists as this is a mpc5200
specific discussion; everyone else probably doesn't care).

On Fri, May 16, 2008 at 3:42 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> I need to talk to my hardware guy.  He is using PSC3 for the boot
> console with the assumption that once booted it is ok to retask it to
> SPI. Serial console is only needed for software debugging.  SSH works
> after boot and can replace the serial console.
>
> I'll trying changing my device tree entry from UART to SPI and boot.
> Hopefully I'll see the console until the SPI driver loads.

Ummm... I'm getting the feeling that we're misunderstanding each
other.  Look at your schematic and tell me what PSC3 pins the SPI bus
wired to and what pins the UART is wired to.

If the SPI bus is attached to pins PSC3_6 (C05), PSC3_7 (B05), PSC3_8
(A05) and PSC3_9 (C04), then they are *not* attached to the PSC3
device and you can have both your serial console and SPI bus active at
the same time (because the SPI bus is wired to the SPI device).

If instead the SPI bus is wired to PSC3_1, PSC3_2, PSC3_3 and PSC3_4
then... ick.  That leads to some messy pin multiplexing.  Does your
board have hardware to reroute the pins between the serial driver and
the SPI bus?  If so, it's not enough to reconfigure the PSC for SPI
mode, you'll also need to fiddle with the board level multiplexing.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
