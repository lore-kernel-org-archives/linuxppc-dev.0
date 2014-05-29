Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews01.kpnxchange.com (cpsmtpb-ews01.kpnxchange.com
 [213.75.39.4])
 by lists.ozlabs.org (Postfix) with ESMTP id 3F0A01A024E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 04:39:09 +1000 (EST)
Message-ID: <1401388744.25908.16.camel@x220>
Subject: Re: [PATCH] pcmcia: m8xx: remove checks for four macros
From: Paul Bolle <pebolle@tiscali.nl>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 29 May 2014 20:39:04 +0200
In-Reply-To: <1401387624.6603.161.camel@snotra.buserror.net>
References: <1400916970.31526.78.camel@x220>
 <1401387624.6603.161.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-pcmcia@lists.infradead.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-29 at 13:20 -0500, Scott Wood wrote:
> On Sat, 2014-05-24 at 09:36 +0200, Paul Bolle wrote:
> > This driver contains checks for four Kconfig macros. But the related
> > Kconfig symbols have never been part of the tree. Remove these checks
> > and the code they hide.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Untested.
> > 
> > This has been an issue ever since this driver was added in v2.6.15. Note
> > that there is no header named "*/cpld.h", so setting PRxK can't possibly
> > work.
> > 
> >  drivers/pcmcia/m8xx_pcmcia.c | 75 --------------------------------------------
> >  1 file changed, 75 deletions(-)
> 
> Does anything in this driver still work?  It looks like bitrot from the
> arch/ppc days, that sort of got updated to use the device tree -- but
> even after this patch there are lots of instances of CONFIG symbols
> being used to assert the exact hardware being used, rather than what
> hardware is supported.

I'm not sure I get what you're pointing at. Can you give one example?

> Is anyone actively maintaining/testing this code?

Related observation: doing
    scripts/get_maintainer.pl -f drivers/pcmcia/m8xx_pcmcia.c --no-git-fallback --no-keywords

just gave me
    linux-pcmcia@lists.infradead.org (open list:PCMCIA SUBSYSTEM)
    linux-kernel@vger.kernel.org (open list)

Note that there's no person responsible for PCMCIA. That's why I
included the people (and lists) maintaining PPC8XX and PPC.


Paul Bolle
