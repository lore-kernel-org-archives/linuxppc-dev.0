Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9A8D2B71B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 08:26:44 +1100 (EST)
Message-ID: <1328217997.5776.8.camel@pasglop>
Subject: Re: [PATCH] powerpc: dont include 8250 pre-setup if 8250 driver
 isn't enabled.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@gmail.com>
Date: Fri, 03 Feb 2012 08:26:37 +1100
In-Reply-To: <CAP=VYLrPMwfEe09uW0=4NKNDPHkNEFcGjGBfDVa_rEFT3kMkZw@mail.gmail.com>
References: <1327117828-27085-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLrPMwfEe09uW0=4NKNDPHkNEFcGjGBfDVa_rEFT3kMkZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-02-02 at 12:56 -0500, Paul Gortmaker wrote:
> On Fri, Jan 20, 2012 at 10:50 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > The legacy_serial code was setting things up based on the assumption
> > that the main 8250 driver would be loaded shortly after.  But some
> > randconfigs exposed an issue where early debug (UDB) UART support was
> > enabled, yet the core UART 8250 support was disabled.
> 
> Hi Ben,
> 
> Can you mark this in patchworks as Superseded?  It is at:
> 
> http://patchwork.ozlabs.org/patch/137142/
> 
> You fixed it independently with this:
> 
> http://git.kernel.org/?p=linux/kernel/git/benh/powerpc.git;a=commit;h=3493c85366ba09c9d0972c919e7123367a39982a

No worries, thanks.

Cheers,
Ben.

> Thanks,
> Paul.
> 
> 
> >
> > In theory a person could care about _really_ early UART output for
> > early debug, but not care about generic console output via UART on
> > embedded devices, so fix things so it is a valid combination.
> >
> > While this might seem like a pointless randconfig change, there are
> > some existing default configs that actually reflect the above setup.
> >
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> >
> > diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
> > index 3fea368..9a82a49 100644
> > --- a/arch/powerpc/kernel/legacy_serial.c
> > +++ b/arch/powerpc/kernel/legacy_serial.c
> > @@ -413,6 +413,14 @@ void __init find_legacy_serial_ports(void)
> >        DBG(" <- find_legacy_serial_port()\n");
> >  }
> >
> > +/*
> > + * In theory, one could have the early debugging enabled, but yet not care
> > + * about 8250 after that, i.e. PPC_UDBG_16550=y but "SERIAL_8250 is not set".
> > + * Mostly appears in randconfig builds, but some defconfigs have this.
> > + */
> > +
> > +#ifdef CONFIG_SERIAL_8250
> > +
> >  static struct platform_device serial_device = {
> >        .name   = "serial8250",
> >        .id     = PLAT8250_DEV_PLATFORM,
> > @@ -523,6 +531,7 @@ static int __init serial_dev_init(void)
> >  }
> >  device_initcall(serial_dev_init);
> >
> > +#endif /* CONFIG_SERIAL_8250 */
> >
> >  #ifdef CONFIG_SERIAL_8250_CONSOLE
> >  /*
> > --
> > 1.7.7.2
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
