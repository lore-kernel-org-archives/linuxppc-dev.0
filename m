Return-Path: <g.jaeger@sysgo.com>
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	by ozlabs.org (Postfix) with ESMTP id 3ABC92BF07
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Dec 2004 22:35:42 +1100 (EST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 3 Dec 2004 11:46:55 +0100
References: <200412020907.44778.g.jaeger@sysgo.com>
	<349C6BAC-443A-11D9-ADCD-000393DBC2E8@freescale.com>
	<200412020925.35851.g.jaeger@sysgo.com>
In-Reply-To: <200412020925.35851.g.jaeger@sysgo.com>
MIME-Version: 1.0
Message-Id: <200412031146.55364.g.jaeger@sysgo.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH][PPC32] Fix gianfar netdriver oops when using bootp...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Thursday 02 December 2004 09:25, Gerhard Jaeger wrote:
> On Thursday 02 December 2004 09:14, Kumar Gala wrote:
> > Fun with mailers.  Try this url:
> >
> > http://tinyurl.com/6skww
>
> Thanks that works (I mean the URL ;)
> I have not tested, but this might will work, as I noticed, that when
> addidionally CONFIG_RARP is enabled, there are also no problems.
>
> Anyway, I'll test ASAP and will tell you the results.

I've now applied this ipconfig patch and removed my piece of code and:
it works - so ignore my patch ;)

Thanx,
Gerhard

>
> Thanx so far,
> Gerhard
>
> > - kumar
> >
> > On Dec 2, 2004, at 2:07 AM, Gerhard Jaeger wrote:
> > > Hi,
> > >
> > > On Wednesday 01 December 2004 23:19, Kumar Gala wrote:
> > >  > There is some belief that the following patch should fix the iss=
ue:
> > > >
> > > > http://linux.bkbits.net:8080/linux-2.5/cset@1.2249.2.2?
> > >
> > > nav=3Dindex.html|ChangeSet@-3d
> > >
> > > > I would be interested to know if this helps w/o your patch.
> > >
> > > I'd like to cross-check this, but are you sure, you're referencing =
the
> > > correct
> > >  changeset? Currently I only got:
> > >  Error 500
> > >  Unable to find revision 1.2249.2.2
> > >
> > > Gerhard
> > >
> > > > - kumar
> > > >
> > > > On Dec 1, 2004, at 10:07 AM, Gerhard Jaeger wrote:
> > > > > Hi,
> > > > >
> > >  > > this patch fixes an issue, that occurs on my MPC8541CDS, when
> > >
> > > trying to
> > >
> > >  > >  use bootp to get the IP parameters. It seems, that the patch
> > >
> > > only=20
> > >
> > >  > > cures
> > >  > >  the symptom but obviously not the cause ;)
> > >  > >
> > >  > > Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>
> > >  > >
> > >  > > --- linux-2.6.10-rc2-mm4/drivers/net/gianfar.c.orig   =20
> > >
> > > 2004-11-15=20
> > >
> > > > > 02:26:34.000000000 +0100
> > > > >
> > >  > >  +++ linux-2.6.10-rc2-mm4/drivers/net/gianfar.c  2004-12-01=20
> > > > >
> > > > > 17:00:19.000000000 +0100
> > > > >
> > >  > >  @@ -1477,6 +1477,9 @@ static void gfar_phy_change(void *data)
> > >  > >          struct gfar_private *priv =3D netdev_priv(dev);
> > > > >
> > > > >         int result =3D 0;
> > > > >
> > >  > >  =20
> > >  > >  +       if( !priv->mii_info->phyinfo )
> > >  > >  +               return;
> > >  > >  +
> > >  > >          /* Delay to give the PHY a chance to change the
> > >  > >           * register state */
> > > > >
> > > > >          msleep(1);

--=20
Gerhard Jaeger                             g.jaeger@sysgo.com
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
