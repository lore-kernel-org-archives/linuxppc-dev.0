Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id 60465B7D59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 00:20:37 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: 'Jon Smirl' <jonsmirl@gmail.com>, Wolfgang Denk <wd@denx.de>
Date: Wed, 9 Jun 2010 10:21:40 -0400
Subject: RE: [PATCH 0/2] mpc5200 ac97 gpio reset
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3253ECB8C84@dekaexchange07.deka.local>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
	<20100609061330.620AC14E867@gemini.denx.de>
	<AANLkTikDE14Y_r7nMpj5lNMy5anAyU3cuLjk_uxStHvo@mail.gmail.com>
In-Reply-To: <AANLkTikDE14Y_r7nMpj5lNMy5anAyU3cuLjk_uxStHvo@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Jon Smirl [mailto:jonsmirl@gmail.com]
> Sent: Wednesday, June 09, 2010 08:22
> To: Wolfgang Denk
> Cc: Eric Millbrandt; Mark Brown; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
>
> On Wed, Jun 9, 2010 at 2:13 AM, Wolfgang Denk <wd@denx.de> wrote:
> > Dear Jon Smirl,
> >
> > In message <AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-
> @mail.gmail.com> you wrote:
> >>
> >> Would making a change in uboot be a better solution? Eric, can you
> >> verify if changing uboot also fixes the problem?
> >
> > To me it seems better if the driver itself does what needs to be done
> > instead of relying on specific settings that may or may not be done in
> > U-Boot. Keep in mind that drivers may be loaded as modules, and that
> > we even see cases where the same port serves multiple purposes by
> > loading different driver modules (yes, this is not exactly a clever
> > idea, but hardware designers come up with such solutions).
>
>
> Someone with a scope can verify this, but my understanding of what
> happens is that uboot by default puts the pins into GPIO mode. Linux
> boots and reprograms the pins into AC97 mode. When the pins are
> reprogrammed it generates glitches on the reset line. About half of
> the time these glitches put the attached codec into test mode. Once
> the chip is in test mode it won't respond to normal commands.
>

Most of the pins on the 5200 default to gpio when the chip comes out of res=
et.  U-Boot then sets the pin muxing by writing to the port configuration r=
egister.  This value is defined as CONFIG_SYS_GPS_PORT_CONFIG in the U-Boot=
 board header file.

The implementation of ac97 gives the codec control of the bus clock.  This =
means that the codec is usually be clocking BITCLK when the 5200 pulls the =
reset line low, which is the cause of the problem.  Freescale should have h=
andled this on the silicon by having the ac97 cold reset function pull the =
SYNC and SDATAOUT lines low during cold reset, but instead they just docume=
nted the problem.

>From the MPC5200B user manual:
"Some AC97 devices goes to a test mode, if the Sync line is high during the=
 Res line is low (reset phase). To avoid this behavior the Sync line must b=
e also forced to zero during the reset phase. To do that, the pin muxing sh=
ould switch to GPIO mode and the GPIO control register should be used to co=
ntrol the output lines."

> Another strategy would be to leave reset as is. If the chip is
> unresponsive send it the commands to get it out of test mode. That
> could be made part of the reset logic in the Linux driver.

This is what we used to do when we were using the out-of-tree ac97 driver f=
rom Sylvain Munaut.  We would generate a cold reset/warm reset sequence in =
U-Boot.  We modified the Linux ac97 driver so that the cold reset functions=
 was a no-op.  It did avoid the problem, but it caused other problems.  Som=
etimes it is necessary to cold reset the codec in Linux to resync the ac97 =
bus.

>
>
> >
> >
> > Best regards,
> >
> > Wolfgang Denk
> >
> > --
> > DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> > The typical page layout program is nothing more  than  an  electronic
> > light table for cutting and pasting documents.
> >
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com

Eric Millbrandt

-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-


This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
