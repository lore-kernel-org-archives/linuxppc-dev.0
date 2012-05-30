Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 20EACB707F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 06:07:50 +1000 (EST)
To: Li Yang <leoli@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Anthony Foiani <tkil@scrye.com>
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com> <4FC5546A.4090506@freescale.com>
 <CADRPPNQ9Dk2OJuQQZm0WdSskW3D1mAqPq21d=h=JEf1nHszDDQ@mail.gmail.com>
Date: Wed, 30 May 2012 14:07:44 -0600
In-Reply-To: <CADRPPNQ9Dk2OJuQQZm0WdSskW3D1mAqPq21d=h=JEf1nHszDDQ@mail.gmail.com> (Li
 Yang's message of "Wed, 30 May 2012 18:59:05 +0800")
Message-ID: <gipfdbffz.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>, Scott Wood <scottwood@freescale.com>,
 "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Li Yang <leoli@freescale.com> writes:

> The original code was there before I touched the driver.  So
> unfortunately I also don't know the history of the problem.

Alas.

> Judging from the comment in code and current test result I guess it
> is a board related issue.

I wonder if anyone on the 8315_DS project knows where the limitation
came from, since that's the origin of the workaround...

Regardless, it's recommended by at least one vendor who based their
design on the 8315 RDB.  If it's board-related, then that seems a
reasonable conditional.

> I agree with Anthony that the best action for now is to remove the
> workaround completely.

Eeek.

I'm pretty sure that it needs to stay.  (I can't guarantee that it has
fixed my problem, but it's been a week or two without the hang, so I'm
becoming more confident).

I think the question is how to best conditionalize it.  The options
seem to be:

  1. at compile time, via kconfig bits;
  2. at runtime via probing / discovery; or
  3. at runtime via device tree.

Given that this is a relatively old platform, and only 2-3 of us have
run into this issue in 5 years, I'm inclined to just go with option 1.

That's exactly what Adrian's patch (from 2008!) does:

  http://old.nabble.com/-2.6-patch--sata_fsl.c%3A-fix-8315DS-workaround-td18807647.html

Using CONFIG_831x_RDB seems like a reasonable choice.

Anyway.  To be clear, my project is currently in good shape (by
adopting Adrian's patch) so I don't have any actual urgency for fixing
this.

I was hoping that someone might know the "correct" answer offhand, but
I honestly think that this isn't worth spending too much time on.
(But I do think that Adrian's patch is an improvement over the current
state of affairs.)

Thanks again to everyone that's chimed in.

Best regards,
Anthony Foiani
