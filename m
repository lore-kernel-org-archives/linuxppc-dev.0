Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A1A52C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 07:30:36 +1000 (EST)
Date: Wed, 15 May 2013 16:30:26 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/book3e: introduce external_input_edge
 exception handler for 64bit kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130514020317.GB21564@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Mon May 13 21:03:17 2013)
Message-ID: <1368653426.8202.34@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/13/2013 09:03:17 PM, Kevin Hao wrote:
> On Mon, May 13, 2013 at 10:47:17AM -0500, Scott Wood wrote:
> > On 05/11/2013 06:26:21 PM, Kevin Hao wrote:
> > >In the external proxy facility mode, the interrupt is automatically
> > >acknowledged with the same effect as reading the IACK register. So
> > >this makes external input interrupt more like edge sensitive. That
> > >means we can leave the irq hard enabled when it occurs with irq =20
> soft
> > >disabled just like the dec and doorbell interrupt. But the External
> > >Proxy Register(EPR) is only considered valid from the time that the
> > >external interrupt occurs until MSR[EE] is set to 1. So we have to
> > >save the EPR before irq hard enabled.
> >
> > Is it really worth it?
>=20
> Maybe. :-)
> Compare with the current kernel:
>   * The overhead is that we need additional load & store the contents =20
> of
>     the EPR from/to PACA.

There's also mental overhead of the extra complexity.  The lazy EE =20
stuff is already fiddly enough (e.g. the recent KVM patches).

>   * The bonus is we keep the irq hard enabled when a external =20
> interrupt occurs
>     with irq soft-disabled. As I know we should leave the irq hard =20
> enabled as
>     much as possible. This is also the primary reason that we =20
> introduce the
>     Lazy EE.

I don't think "as much as possible" is a good way to look at it, so =20
much as "as much as is practical", balanced by also wanting to keep the =20
code as simple as is practical.

-Scott=
