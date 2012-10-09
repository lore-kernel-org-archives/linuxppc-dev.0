Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8694C2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 05:18:36 +1100 (EST)
Date: Tue, 9 Oct 2012 13:18:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: =?UTF-8?b?562U5aSNOg==?= [RFC PATCH] powerpc/fsl: add timer
 wakeup source
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <ABB05CD9C9F68C46A5CEDC7F15439259DF1A14@039-SN2MPN1-021.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259DF3F7F@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259DF3F7F@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Oct  9 08:56:53 2012)
Message-ID: <1349806700.26044.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Wang Dongsheng <dongsheng.wds@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/09/2012 08:56:53 AM, Wang Dongsheng-B40534 wrote:
>=20
> > > > > I'm pretty sure /proc/ is NOT where we want this exposed.
> > > >
> > > > Should probably go under the sysfs directory of the mpic =20
> device.  Or
> > > > better, make a generic interface for timer-based suspend wakeup =20
> (if
> > > there
> > > > isn't one already).  This current approach sits in an unpleasant
> > middle
> > > > ground between generic and device-specific.
> > > >
> > > /sys/power/wakeup_timer_seconds how about this?
> > > I think it is a freescale generic interface, this interface =20
> control by
> > > FSL_SOC && SUSPEND.
>=20
> > There's no such thing as a "Freescale generic interface".  Linux =20
> APIs
> > are not organized by hardware vendor.  Either make a truly generic
> > interface, reuse an existing one, or do something that is attached =20
> to
> > the specific driver.
> Thanks, I think i can change mpic timer registration, i will use =20
> platform_driver_register.
> I will merge "mpic timer" and "timer wakeup". In "mpic timer" the =20
> wakeup function
> controls by SUSPEND. The sys path is =20
> "/sys/devices/soc8572.4/ffe41100.timer/wakeup_seconds".
> do you have any suggestions for this? or have a better idea about the =20
> sys path?

I'm not sure what you mean by the merging, but the path looks OK (I'd =20
prefer a dash rather than underscore, but I'm not sure what the usual =20
practice is in sysfs).

That said, this seems like something that could use a truly generic =20
interface.

-Scott=
