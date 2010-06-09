Return-Path: <jonsmirl@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 7D025B7D4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 10:24:07 +1000 (EST)
Received: by vws6 with SMTP id 6so3748772vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Jun 2010 17:24:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
Date: Tue, 8 Jun 2010 20:24:05 -0400
Message-ID: <AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
From: Jon Smirl <jonsmirl@gmail.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 8, 2010 at 12:46 PM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> These patches reimplement the reset fuction in the ac97 to use gpio pins
> instead of using the mpc5200 ac97 reset functionality in the psc. =A0This
> avoids a problem in which attached ac97 devices go into "test" mode appea=
r
> unresponsive.

I'm aware of this problem but I was unable to solve it when I first
wrote the driver. I didn't have access to a scope so I wasn't able to
figure out what was causing the lock up.  I worked around it by
looping in reset until the chip did actually reset, but Mark wouldn't
let me submit that code.

A while ago Maximilian Mueth <maximilian.mueth@mp-ndt.de> sent me a
note saying another solution was to configure the PSC into AC97 mode
in uboot. His impression was that uboot was setting PSC into its
default mode. Then Linux booted and set the PSC into AC97 mode. The
transition from default mode into AC97 mode caused glitches on the
AC97 reset pins and triggered test mode.

Would making a change in uboot be a better solution? Eric, can you
verify if changing uboot also fixes the problem?

I'm glad were finally getting to the root cause of the problem.


>
> These patches were tested on a pcm030 baseboard and on custom hardware wi=
th
> a wm9715 audio codec/touchscreen controller.
>
> Eric Millbrandt
>
> ---
>
> Eric Millbrandt (2):
> =A0 =A0powerpc/5200: Export port-config
> =A0 =A0sound/soc: mpc5200_psc_ac97: Use gpio pins for cold reset.
>
> =A0arch/powerpc/boot/dts/lite5200.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/powerpc/boot/dts/lite5200b.dts =A0 =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0arch/powerpc/boot/dts/pcm030.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/powerpc/boot/dts/pcm032.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0arch/powerpc/platforms/52xx/mpc52xx_common.c | =A0 61 ++++++++++++++++=
+++
> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A05 ++
> =A0sound/soc/fsl/mpc5200_psc_ac97.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 83 ++++=
++++++++++++++++++++-
> =A08 files changed, 159 insertions(+), 4 deletions(-)
>
> -DISCLAIMER: an automatically appended disclaimer may follow. By posting-
> -to a public e-mail mailing list I hereby grant permission to distribute-
> -and copy this message.-
>
>
> This e-mail and the information, including any attachments, it contains a=
re intended to be a confidential communication only to the person or entity=
 to whom it is addressed and may contain information that is privileged. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that any dissemination, distribution or copying of this communicati=
on is strictly prohibited. If you have received this communication in error=
, please immediately notify the sender and destroy the original message.
>
> Thank you.
>
> Please consider the environment before printing this email.
>



--=20
Jon Smirl
jonsmirl@gmail.com
