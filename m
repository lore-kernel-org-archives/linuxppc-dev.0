Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A0F21B704F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 03:47:49 +1100 (EST)
Message-ID: <4EEF6AAA.3030806@freescale.com>
Date: Mon, 19 Dec 2011 10:47:38 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE66EFE.1050608@freescale.com> <1323724784.2297.20.camel@koala>
 <4EE6725C.3050706@freescale.com> <4EE6BC9B.4000602@freescale.com>
 <4EE8612C.9050104@freescale.com> <4EE903CE.1010903@freescale.com>
 <4EEAB076.30000@freescale.com> <4EEB8704.8030201@freescale.com>
 <CADRPPNT-akj5KBQKdRaFrA2XpLU6-xtuRduzDYEWjv_dzVmTAA@mail.gmail.com>
In-Reply-To: <CADRPPNT-akj5KBQKdRaFrA2XpLU6-xtuRduzDYEWjv_dzVmTAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem.Bityutskiy@nokia.com, dedekind1@gmail.com, dwmw2@infradead.org,
 LiuShuo <b35362@freescale.com>, linux-kernel@vger.kernel.org,
 shuo.liu@freescale.com, linux-mtd@lists.infradead.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2011 05:05 AM, Li Yang wrote:
> On Sat, Dec 17, 2011 at 1:59 AM, Scott Wood <scottwood@freescale.com> wrote:
>> On 12/15/2011 08:44 PM, LiuShuo wrote:
>>> hi Artem,
>>> Could this patch be applied now and we make a independent patch for  bad
>>> block information
>>> migration later?
>>
>> This patch is not safe to use without migration.
> 
> Hi Scott,
> 
> We agree it's not entirely safe without migrating the bad block flag.
> But let's consider two sides of the situation.
> 
> Firstly, it's only unsafe when there is a need to re-built the Bad
> Block Table from scratch(old BBT broken).

No, it's unsafe in the presence of bad blocks.

The BBT erasure issue relates to how me mark the flash as migrated, not
whether we migrate in the first place.

>  But currently there is no
> easy way to do that(re-build BBT on demand),

You scrub the blocks with U-Boot.  It's not supposed to be *easy*, it's
a developer recovery mechanism.

> Secondly, even if the previous said problem happens(BBT broken).  We
> can still recover all the data if we overrule the bad block flag.

How so?  The bad block markers -- including ones legitimately written to
the BBT after the fact -- are used for block skipping with certain types
of writes.  Without the knowledge of which blocks were marked bad, how
do we know which blocks were skipped?

> Only the card is not so good to be used again,

That's a pretty crappy thing to happen every time you hit a bug during
development.

But again, that's irrelevant to whether this patch should be applied
as-is, because we currently don't have any bad block migration at all.

> however, it can be used
> if we take the risk of losing data from errors that ECC can't
> notice(low possibility too).

Can you quantify "low possibility" here?

Note that any block that *was* marked bad will have a multi-bit error
from the marker itself, since it will be embedded in the main data area.

> Finally, I don't think this is a blocker issue but a better to have enhancement.

No, it is not an enhancement.  Processing bad block markers correctly is
a fundamental requirement.  And if anyone *does* start using it right
away, then we'll have to deal with their complaints if we start checking
for a migration marker later.

Why is it so critical that it be merged now, and not in a few weeks (or
next merge window) when I have a chance to do the migration code
(assuming nobody else does it first) and add a suitable check for the
migration marker in the Linux driver?

-Scott
