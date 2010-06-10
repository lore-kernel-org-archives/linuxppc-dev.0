Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 36983B7D88
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 08:08:03 +1000 (EST)
Received: by gwaa18 with SMTP id a18so369778gwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 15:08:02 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100609103046.GC5618@opensource.wolfsonmicro.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
	<20100609103046.GC5618@opensource.wolfsonmicro.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 16:07:37 -0600
Message-ID: <AANLkTinascmPq38PptPH3tRJS-P8IqO9tdLbVb5erLRY@mail.gmail.com>
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 9, 2010 at 4:30 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 09, 2010 at 08:13:30AM +0200, Wolfgang Denk wrote:
>> In message <AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com=
> you wrote:
>
>> > Would making a change in uboot be a better solution? Eric, can you
>> > verify if changing uboot also fixes the problem?
>
>> To me it seems better if the driver itself does what needs to be done
>> instead of relying on specific settings that may or may not be done in
>> U-Boot. Keep in mind that drivers may be loaded as modules, and that
>> we even see cases where the same port serves multiple purposes by
>> loading different driver modules (yes, this is not exactly a clever
>> idea, but hardware designers come up with such solutions).
>
> I do tend to agree that having the driver be able to cope with things is
> a bit more robust - it's not terribly discoverable for users and people
> are often justifiably nervous about updating their bootloader.
>
> It might, however, be sensible to make the GPIO based reset be optional
> based on having the OF data for the GPIOs. =A0That way existing DTs will
> work without changes and systems that can use the reset implementation
> in the controller will be able to do so.

To me, this seems firmly in the realm of silicon bug workaround.
Considering that the pins aren't relocatable (ie, the GPIO numbers
never change), I've got no problem having the GPIO reset logic added
to arch/powerpc/platforms/52xx and hard coding the GPIO numbers.

I completely agree that it should not require a firmware update to get
the hardware to work correctly.

g.
