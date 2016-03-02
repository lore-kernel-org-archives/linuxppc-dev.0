Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C1DE1A0BA9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 20:06:12 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Kyle McMartin <kyle@mcmartin.ca>,
 RTCLINUX <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] rtc: generic: allow building on all architectures
Date: Wed, 02 Mar 2016 10:05:18 +0100
Message-ID: <1620536.OtjnSSLgCT@wuerfel>
In-Reply-To: <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-2-git-send-email-arnd@arndb.de>
 <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
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

On Wednesday 02 March 2016 09:57:27 Geert Uytterhoeven wrote:
> > @@ -33,13 +35,21 @@ static const struct rtc_class_ops generic_rtc_ops = {
> >         .read_time = generic_get_time,
> >         .set_time = generic_set_time,
> >  };
> > +#else
> > +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
> > +#endif
> >
> >  static int __init generic_rtc_probe(struct platform_device *dev)
> >  {
> >         struct rtc_device *rtc;
> > +       const struct rtc_class_ops *ops;
> > +
> > +       ops = dev_get_platdata(&dev->dev);
> > +       if (!ops)
> > +               ops = &generic_rtc_ops;
> 
> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
> undefined behavior?

It's a bit odd, but I think it's syntactically correct C, and not
much too different from 

#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)

is it? My last patch gets rid of it again.

	Arnd
