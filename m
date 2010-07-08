Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 6486BB6EED
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jul 2010 14:56:33 +1000 (EST)
Received: by eyh6 with SMTP id 6so63924eyh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jul 2010 21:56:31 -0700 (PDT)
Date: Thu, 8 Jul 2010 08:56:27 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] edac: mpc85xx: Fix MPC85xx dependency
Message-ID: <20100708045627.GA32489@oksana.dev.rtsoft.ru>
References: <20100702124111.GA23320@oksana.dev.rtsoft.ru>
	<20100707144502.22b91374.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100707144502.22b91374.akpm@linux-foundation.org>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, linuxppc-dev@ozlabs.org,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 07, 2010 at 02:45:02PM -0700, Andrew Morton wrote:
> On Fri, 2 Jul 2010 16:41:11 +0400
> Anton Vorontsov <avorontsov@mvista.com> wrote:
> 
> > Since commit 5753c082f66eca5be81f6bda85c1718c5eea6ada ("powerpc/85xx:
> > Kconfig cleanup"), there is no MPC85xx Kconfig symbol anymore, so the
> > driver became non-selectable.
> 
> hm.  5753c082f66eca5be81f6bda85c1718c5eea6ada got merged into mainline
> six months ago.  How come nobody noticed?

Dunno. Well, it's hard to notice these sorts of things until
somebody actually needs this driver on MPC85xx platform. :-)

> > This patch fixes the issue by switching to PPC_85xx symbol.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> > ---
[...]
> > -	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || MPC85xx)
> > +	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || PPC_85xx)
> >  	help
> >  	  Support for error detection and correction on the Freescale
> >  	  MPC8349, MPC8560, MPC8540, MPC8548
> 
> I suppose we shold scoot this into 2.6.35 and mark it for -stable
> backporting.  All very odd.

Yeah, -stable 2.6.{33,34} sounds good.

Thanks.
