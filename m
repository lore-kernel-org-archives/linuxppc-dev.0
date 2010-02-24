Return-Path: <meissner@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 867D3B7CEF
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 00:44:00 +1100 (EST)
Date: Wed, 24 Feb 2010 14:43:55 +0100
From: Marcus Meissner <meissner@suse.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Fixed statement without effect by using a correct empty
	instruction
Message-ID: <20100224134355.GA1024@suse.de>
References: <20100224085137.GA25801@suse.de>
	<fa686aa41002240540s2044ecaaj3ce04021719a51ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa41002240540s2044ecaaj3ce04021719a51ef@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, albrecht.dress@arcor.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 24, 2010 at 06:40:37AM -0700, Grant Likely wrote:
> On Wed, Feb 24, 2010 at 1:51 AM, Marcus Meissner <meissner@suse.de> wrote:
> > This fixes this build failure:
> > cc1: warnings being treated as errors
> > /usr/src/packages/BUILD/kernel-default-2.6.33/linux-2.6.32/arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_gpt_probe':
> > /usr/src/packages/BUILD/kernel-default-2.6.33/linux-2.6.32/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:761:3: error: statement with no effect
> >
> > Signed-off-by: Marcus Meissner <meissner@suse.de>
> 
> Hi Marcus, thanks for the patch.  One comment below...
> 
> > ---
> >  arch/powerpc/platforms/52xx/mpc52xx_gpt.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> > index 6f8ebe1..88231d8 100644
> > --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> > +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> > @@ -711,7 +711,7 @@ static int __devinit mpc52xx_gpt_wdt_init(void)
> >        return 0;
> >  }
> >
> > -#define mpc52xx_gpt_wdt_setup(x, y)            (0)
> > +#define mpc52xx_gpt_wdt_setup(x, y)            do { } while (0)
> 
> As Andrew likes to say, we should be programming in C instead of preprocessor.
> 
> -#define mpc52xx_gpt_wdt_setup(x, y)            (0)
> +static inline void mpc52xx_gpt_wdt_setup(struct mpc52xx_gpt_priv
> *gpt, const u32 *period) { }

Sounds good to me too. :)

Ciao, Marcus
