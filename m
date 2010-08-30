Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 3063BB70EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 03:46:39 +1000 (EST)
Received: by gyh4 with SMTP id 4so2278148gyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 10:46:37 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
References: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
	<20100830132914.GA32266@oksana.dev.rtsoft.ru>
	<AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 30 Aug 2010 11:46:17 -0600
Message-ID: <AANLkTinhctfE_BTF3xtACMoqrtRiSNApQ3+qCaOJ=w7m@mail.gmail.com>
Subject: Re: [PATCH] of_mmc_spi: add card detect irq support
To: Esben Haabendal <esbenhaabendal@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>, linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 30, 2010 at 10:04 AM, Esben Haabendal
<esbenhaabendal@gmail.com> wrote:
> On Mon, Aug 30, 2010 at 3:29 PM, Anton Vorontsov <cbouatmailru@gmail.com>=
 wrote:
>>> @@ -121,8 +136,14 @@ struct mmc_spi_platform_data
>>> *mmc_spi_get_pdata(struct spi_device *spi)
>>> =A0 =A0 =A0 =A0 if (gpio_is_valid(oms->gpios[WP_GPIO]))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oms->pdata.get_ro =3D of_mmc_spi_get_ro=
;
>>>
>>> - =A0 =A0 =A0 /* We don't support interrupts yet, let's poll. */
>>> - =A0 =A0 =A0 oms->pdata.caps |=3D MMC_CAP_NEEDS_POLL;
>>> + =A0 =A0 =A0 oms->detect_irq =3D irq_of_parse_and_map(np, 0);
>>> + =A0 =A0 =A0 if (oms->detect_irq !=3D NO_IRQ) {
>>
>> I'd write "if (oms->detect_irq)", which is a bit more natural
>> (and still correct, 0 is the only invalid VIRQ number).
>
> Most other architectures has NO_IRQ defined to -1, so I will stick
> with the NO_IRQ comparsion.

Not true.  NO_IRQ is only defined as -1 on ARM, microblaze, mn10300
and parisc, and I've got a patch pending to remove microblaze from
that list.  ARM just happens to be a really big user.

$ git grep NO_IRQ arch/*/include  (I've trimmed the irrelevant matches)
arch/arm/include/asm/irq.h:#ifndef NO_IRQ
arch/arm/include/asm/irq.h:#define NO_IRQ       ((unsigned int)(-1))
arch/microblaze/include/asm/irq.h:#define NO_IRQ (-1)
arch/mn10300/include/asm/irq.h:#define NO_IRQ           INT_MAX
arch/parisc/include/asm/irq.h:#define NO_IRQ            (-1)
arch/powerpc/include/asm/irq.h:#define NO_IRQ                   (0)

> Hopefully, arm users will soon enjoy this driver/wrapper soon also.

My hope is that even on ARM when the device tree is used I'll be able
eliminate IRQs mapped to 0 (but I need to do a lot more research on
how best to do that though).  Are you actually using this on ARM?

I'm okay with you keeping the NO_IRQ test for the short term though.

g.
