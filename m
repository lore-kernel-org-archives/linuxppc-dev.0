Return-Path: <benh@kernel.crashing.org>
Message-ID: <1396908466.3671.56.camel@pasglop>
Subject: Re: [PATCH] powerpc/opal: Add missing include
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Apr 2014 08:07:46 +1000
In-Reply-To: <CAMuHMdV7BuSMu5gyhBcxY_8v+u3KnVStDgvC-JSN=hX3VZw3+g@mail.gmail.com>
References: <13762.1395708188@ale.ozlabs.ibm.com>
 <CAMuHMdV7BuSMu5gyhBcxY_8v+u3KnVStDgvC-JSN=hX3VZw3+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, Linux-Next <linux-next@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-07 at 23:03 +0200, Geert Uytterhoeven wrote:
> On Tue, Mar 25, 2014 at 1:43 AM, Michael Neuling <mikey@neuling.org> wrote:
> > next-20140324 currently fails compiling celleb_defconfig with:
> >
> > arch/powerpc/include/asm/opal.h:894:42: error: 'struct notifier_block' declared inside parameter list [-Werror]
> > arch/powerpc/include/asm/opal.h:894:42: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]
> > arch/powerpc/include/asm/opal.h:896:14: error: 'struct notifier_block' declared inside parameter list [-Werror]
> >
> > This is due to a missing include which is added here.
> 
> This build issue has now been in mainline since a few days.

It's in my tree, I will send the patch upstream in the next couple of
days (having a medical procedure today).

Ben.

> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> >
> > diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> > index fe2aa0b..f57fb58 100644
> > --- a/arch/powerpc/include/asm/opal.h
> > +++ b/arch/powerpc/include/asm/opal.h
> > @@ -177,6 +177,8 @@ extern int opal_enter_rtas(struct rtas_args *args,
> >
> >  #ifndef __ASSEMBLY__
> >
> > +#include <linux/notifier.h>
> > +
> >  /* Other enums */
> >  enum OpalVendorApiTokens {
> >         OPAL_START_VENDOR_API_RANGE = 1000, OPAL_END_VENDOR_API_RANGE = 1999
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
