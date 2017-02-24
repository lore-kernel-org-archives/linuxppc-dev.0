Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTwBV1ykhzDqPG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:33:06 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTwBT49hmz9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:33:05 +1100 (AEDT)
Message-ID: <1487903570.23576.252.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/12] drm/ast: Handle configuration without P2A bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>, eich@suse.come
Date: Fri, 24 Feb 2017 13:32:50 +1100
In-Reply-To: <CACPK8XfqnCm7ufoXQhvpx3tbhcoJtrtEzxJFrhmY-Q4Oif5Q_Q@mail.gmail.com>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-2-benh@kernel.crashing.org>
 <CACPK8XfqnCm7ufoXQhvpx3tbhcoJtrtEzxJFrhmY-Q4Oif5Q_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-24 at 12:51 +1030, Joel Stanley wrote:
> 
> Are these properties supposed to repeat the prefix "ast,ast"?
> 
> We've chosen aspeed as the vendor prefix for Aspeed stuff.

Sent my reply too early ... so yes, I can change that, our FW hasn't
merge the FW side yet. I'll respin now.

> > +       if (mcr_scu_strap & 0x2000)
> 
> This bit confused me. Bit 13 of the strap (SCU70) is the SPI mode.

The register is actually "MCR170: AST2000 Backward Compatible SCU
Hardware Strapping Value"

> > +               ref_pll = 14318;
> > +       else
> > +               ref_pll = 12000;
> > +
> > +       denum = mcr_scu_mpll & 0x1f;
> > +       num = (mcr_scu_mpll & 0x3fe0) >> 5;
> > +       dsel = (mcr_scu_mpll & 0xc000) >> 14;
> 
> These calculations don't make sense for the ast2400 or ast2500.

They do if you look at this:

MCR120: AST2000 Backward Compatible SCU MPLL Parameter

It's not the SCU version of the register it's the MCU "copy" of it
that maintains some kind of legacy layout. Hence "mcr_scu" prefix
not "scu".

> > +       switch (dsel) {
> > +       case 3:
> > +               div = 0x4;
> > +               break;
> > +       case 2:
> > +       case 1:
> > +               div = 0x2;
> > +               break;
> > +       default:
> > +               div = 0x1;
> > +               break;
> >         }
> > +       ast->mclk = ref_pll * (num + 2) / (denum + 2) * (div *
> > 1000);
> >         return 0;
> >  }
