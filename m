Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 682EE1A1803
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 17:04:50 +1100 (AEDT)
Message-ID: <1452837889.25634.38.camel@neuling.org>
Subject: Re: [PATCH V2 4/8] powerpc: Explicitly disable math features when
 copying thread
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Date: Fri, 15 Jan 2016 17:04:49 +1100
In-Reply-To: <20160115165416.2f7328ae@camb691>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
 <1452834254-22078-5-git-send-email-cyrilbur@gmail.com>
 <1452836542.25634.33.camel@neuling.org> <20160115165416.2f7328ae@camb691>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-01-15 at 16:54 +1100, Cyril Bur wrote:
> On Fri, 15 Jan 2016 16:42:22 +1100
> Michael Neuling <mikey@neuling.org> wrote:
>=20
> > On Fri, 2016-01-15 at 16:04 +1100, Cyril Bur wrote:
> > > With threads leaving the math bits enabled in their saved MSR to
> > > indicate
> > > that the hardware is hot and a restore is not needed, children
> > > need to turn
> > > it off as when they do get scheduled, there's no way their
> > > registers could
> > > have been hot. =20
> >=20
> > Is this a bug in the current code?
> >=20
>=20
> You're very consistent:
>=20
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-November/136469.
> html

Fix the comment to explain why it's not a bug now.

Mikey

> ;)
>=20
> > Mikey
> >=20
> > > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > > ---
> > >  arch/powerpc/kernel/process.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/arch/powerpc/kernel/process.c
> > > b/arch/powerpc/kernel/process.c
> > > index dccc87e..e0c3d2d 100644
> > > --- a/arch/powerpc/kernel/process.c
> > > +++ b/arch/powerpc/kernel/process.c
> > > @@ -1307,6 +1307,7 @@ int copy_thread(unsigned long clone_flags,
> > > unsigned long usp,
> > > =20
> > >  		f =3D ret_from_fork;
> > >  	}
> > > +	childregs->msr &=3D ~(MSR_FP|MSR_VEC|MSR_VSX);
> > >  	sp -=3D STACK_FRAME_OVERHEAD;
> > > =20
> > >  	/* =20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
