Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 725D9DDE28
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 04:23:00 +1100 (EST)
Date: Tue, 23 Dec 2008 20:22:58 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/qe: Select QE_USB with USB_GADGET_FSL_QE
Message-ID: <20081223172258.GA25526@oksana.dev.rtsoft.ru>
References: <20081108175254.GA6444@oksana.dev.rtsoft.ru>
	<20081203193327.GA13807@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081203193327.GA13807@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2008 at 10:33:27PM +0300, Anton Vorontsov wrote:
> On Sat, Nov 08, 2008 at 08:52:54PM +0300, Anton Vorontsov wrote:
> > Boards should know when QE_USB is used, so that they can configure USB
> > clocks and pins.
> > 
> > Another option would be to add 'select QE_USB' into USB_GADGET_FSL_QE,
> > but selects are evil since they don't support dependencies.
> > 
> > While at it, also remove 'host' from the symbol description, since the
> > QE_USB code is used to support the gadget driver as well.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> 
> Anything wrong with this one?

Without this patch QE UDC won't work (board file won't configure the
USB clocks and pins).

Thanks,

> >  arch/powerpc/sysdev/qe_lib/Kconfig |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
> > index 76ffbc4..41ac3df 100644
> > --- a/arch/powerpc/sysdev/qe_lib/Kconfig
> > +++ b/arch/powerpc/sysdev/qe_lib/Kconfig
> > @@ -22,5 +22,6 @@ config UCC
> >  
> >  config QE_USB
> >  	bool
> > +	default y if USB_GADGET_FSL_QE
> >  	help
> > -	  QE USB Host Controller support
> > +	  QE USB Controller support
> > -- 
> > 1.5.6.3

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
