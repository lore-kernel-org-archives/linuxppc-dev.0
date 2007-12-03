Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 206B7DDDD6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 07:05:58 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so755349anc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Dec 2007 12:05:57 -0800 (PST)
Message-ID: <fa686aa40712031205v6c85f563g22b6486c76a0c7c6@mail.gmail.com>
Date: Mon, 3 Dec 2007 13:05:56 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Clemens Koller" <clemens.koller@anagramm.de>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
In-Reply-To: <47545A81.90804@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <474DB27C.7020909@anagramm.de>
	<20071129211912.46da8f5b@i1501.lan.towertech.it>
	<474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de> <47542A50.1030208@anagramm.de>
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/3/07, Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hello, Scott!
>
> Scott Wood schrieb:
>  >> Here, the next idea which comes to my mind:
>  >> Maybe we should think about a kernel-config -> dts compiler for
>  >> the future where the enabled drivers generate their default dts
>  >> entries automagically?
>  >
>  > Sorry, there's just not enough information in .config for that.
>
> If there is really the need to put more information (which I don't
> see in the case of the RTCs) to .config, it might be an idea to
> extend the current structure for this use instead of duplicating
> and maintaining a second repository.
>
> And regarding the DS1337 (or the PCF8563 and similar RTCs):
> It's address (0x68) is immutable fixed by the manufacturer
> of that device. So, why do we include it in the DT, when we
> already told the kernel what driver we want to use?

I2C is an odd bus in that it is only partially probeable; you can
probe for presence, but you can't trust that you know what is there.
The device tree approach sidesteps that uncertainty by just mandating
that you specify that address and type of each device.  This is
neither hard or onerous on the developer to do.

If we *could* trust the i2c probing (like we can on PCI), then i2c
devices would *not* need to be in the device tree.

> Even if I have an eeprom which can have varying addresses,
> I can simply tell the driver/the kernel .config what address
> it should use... If I want to be able to alter that address
> for whatever reason by OF, I still don't want to touch a
> separate file in the kernel tree.

Kconfig was never designed for that type of board level detail and it
would be awkward to shoehorn that in (not to mention that it doesn't
solve the problem of one kernel running on many boards.)

Historically we solved the config problem with board specific code in
.c files.  A solution I'm sure you'll agree might work, but it's not
sustainable in the long run.

As for modifying the device tree; you've got many choices; choose what
works best for you.

For example, you could:
a. write a separate .dts file per board varient, or
b. write single .dts files which only contains the common properties
and the bootloader populates the board specific ones, or
c. write a single .dts file which contains all possible nodes and the
bootloader deletes the nodes which are irrelevant.

Regardless of what method you choose, you just need to make sure that
the device tree that the kernel receives is an accurate representation
of the hardware (ie. no nodes for non-present devices)

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
