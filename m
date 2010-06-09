Return-Path: <jonsmirl@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 2F6481007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 22:21:43 +1000 (EST)
Received: by vws6 with SMTP id 6so4487437vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Jun 2010 05:21:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100609061330.620AC14E867@gemini.denx.de>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
Date: Wed, 9 Jun 2010 08:21:41 -0400
Message-ID: <AANLkTikDE14Y_r7nMpj5lNMy5anAyU3cuLjk_uxStHvo@mail.gmail.com>
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
From: Jon Smirl <jonsmirl@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 9, 2010 at 2:13 AM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Jon Smirl,
>
> In message <AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>=
 you wrote:
>>
>> Would making a change in uboot be a better solution? Eric, can you
>> verify if changing uboot also fixes the problem?
>
> To me it seems better if the driver itself does what needs to be done
> instead of relying on specific settings that may or may not be done in
> U-Boot. Keep in mind that drivers may be loaded as modules, and that
> we even see cases where the same port serves multiple purposes by
> loading different driver modules (yes, this is not exactly a clever
> idea, but hardware designers come up with such solutions).


Someone with a scope can verify this, but my understanding of what
happens is that uboot by default puts the pins into GPIO mode. Linux
boots and reprograms the pins into AC97 mode. When the pins are
reprogrammed it generates glitches on the reset line. About half of
the time these glitches put the attached codec into test mode. Once
the chip is in test mode it won't respond to normal commands.

Does the opposite happen? What if uboot has the pins in AC97 mode and
Linux reprograms them into GPIO mode. Will it also put the chip into
test mode? The piece of information I've been missing is an
understanding of what is making the glitches that trigger test mode.

Another strategy would be to leave reset as is. If the chip is
unresponsive send it the commands to get it out of test mode. That
could be made part of the reset logic in the Linux driver.


>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> The typical page layout program is nothing more =A0than =A0an =A0electron=
ic
> light table for cutting and pasting documents.
>



--=20
Jon Smirl
jonsmirl@gmail.com
