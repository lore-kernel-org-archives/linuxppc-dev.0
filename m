Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59vS4kY0zDr8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:37:23 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mips@linux-mips.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, a.seppala@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Felipe Balbi <balbi@ti.com>,
 Douglas Anderson <dianders@chromium.org>,
 Gregory Herrero <gregory.herrero@intel.com>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] usb: dwc2: fix regression on big-endian PowerPC/ARM
 systems
Date: Thu, 12 May 2016 13:36:40 +0200
Message-ID: <2809110.sWekaCNVxS@wuerfel>
In-Reply-To: <8760ujecw2.fsf@linux.intel.com>
References: <1463050104-2788693-1-git-send-email-arnd@arndb.de>
 <8760ujecw2.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 12 May 2016 14:25:49 Felipe Balbi wrote:
> >  {
> >       u32 value = __raw_readl(addr);
> >  
> > -     /* In order to preserve endianness __raw_* operation is used. Therefore
> > -      * a barrier is needed to ensure IO access is not re-ordered across
> > +     /* in order to preserve endianness __raw_* operation is used. therefore
> > +      * a barrier is needed to ensure io access is not re-ordered across
> >        * reads or writes
> >        */
> >       mb();
> > @@ -81,15 +93,32 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
> >       __raw_writel(value, addr);
> >  
> >       /*
> > -      * In order to preserve endianness __raw_* operation is used. Therefore
> > -      * a barrier is needed to ensure IO access is not re-ordered across
> > +      * in order to preserve endianness __raw_* operation is used. therefore
> > +      * a barrier is needed to ensure io access is not re-ordered across
> >        * reads or writes
> >        */
> >       mb();
> > -#ifdef DWC2_LOG_WRITES
> > -     pr_info("INFO:: wrote %08x to %p\n", value, addr);
> > +#ifdef dwc2_log_writes
> > +     pr_info("info:: wrote %08x to %p\n", value, addr);
> >  #endif
> >  }
> > +#else

Oops, the accidental lowercase conversion is still in here, I'll fix it
up once we agree on the approach.

> I still think this is something that should be handled at MIPS side, no ?

As I explained, there isn't really anything we can do in MIPS code
because of the way they have to handle PCI.

> How many more drivers will we have to 'fix' like this ?

Endianess problems will keep coming up, and we have hundreds or thousands
of drivers that are written with a particular design in mind that could
be wrong as soon as someone chooses to build an SoC that does things
differently. Once that happens, we'll fix them.

Also, Christian has already posted a better version of the patch
that fixes this driver in an architecture independent way, but we still
need a workaround for the stable backports.

	Arnd
