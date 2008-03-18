Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.247])
	by ozlabs.org (Postfix) with ESMTP id A7036DDFFC
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 01:47:57 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so9547938agc.0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:47:56 -0700 (PDT)
Message-ID: <fa686aa40803180747u532f6a0bq1e64e01662bdb6bd@mail.gmail.com>
Date: Tue, 18 Mar 2008 08:47:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <47DF7D6F.8010808@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47DF7D6F.8010808@semihalf.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, rpurdie@rpsys.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2008 at 2:29 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
>  Grant,
>
>  Yes, the Motion-PRO LED driver has been reworked and posted:
>  http://patchwork.ozlabs.org/linuxppc/patch?q=Motion-pro&id=16617
>
>
>
>   > I need to look at it again,
>  > but it is a lot of code for a very simple thing and I wasn't sure if I
>  > should be the one to pick it up because it is in drivers/leds which
>  > has a different maintainer.
>
>  I'm copying Richard Purdie who's listed as LED SUBSYSTEM maintainer.
>
>  Richard -- could pick up the above mentioned Motion-PRO LED driver for
>  upstream inclusion? It started as a MPC5200-specific thing posted to
>  linuxppc-dev and got reviewed there, with the intent to go upstream via
>  Grant (MPC52XX maintainer). However, it seems that it should be merged
>  through your subsystem.

Okay, I've taken another look at the driver and I've figured out what
has been bothering me about it.  It seems to me that the motion pro
led driver is just the first of many that we will see (seeing as some
many people find the blinking lights rather soothing) and it's a non
trivial amount of code.

(Note: I'm not actually opposed to this driver if Richard is okay with
it; but I do think that in the long term we should move towards a more
generic approach)

In essence, this driver sets up two GPIO pins to drive LEDs.  A pretty
common approach for putting LEDs on a board.  In this case each GPIO
bank only contains 1 pin; but I imagine that on other boards there
will be multiple pins in a GPIO bank, only some of which actually used
for blinking LEDs.

I've started thinking that it would be better to split things up in
the device tree to have one node for each GPIO block and a single LED
node that maps LEDs to gpio pins.  That would allow a common driver to
be written for all GPIO driven LEDs with a single block of device tree
parsing code.  Plus, it allows other devices to use GPIO pins within
the same block (not an issue for the motion pro board; but when other
boards start coming on-line it would allow us to reduce the amount of
board specific code).  Finally, it means that the timer pin GPIO
driver can be used for more than just flashing an attached LED.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
