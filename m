Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0ACE4B6F77
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2011 13:25:56 +1000 (EST)
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
Date: Sat, 16 Jul 2011 03:25:47 +0000
Message-ID: <82C960D7DF4A1F47B94FC1C67A29BEE384D577@ALA-MBA.corp.ad.wrs.com>
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
	<CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>
	<4E1FCFEF.7070702@windriver.com>
	<20110715134232.56373e03@schlenkerla.am.freescale.net>
In-Reply-To: <20110715134232.56373e03@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]=20
> Sent: Saturday, July 16, 2011 2:43 AM
> To: Chen, Tiejun
> Cc: Kumar Gala; linuxppc-dev@ozlabs.org
> Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program=20
> exception to use one dedicated exception stack
>=20
> On Fri, 15 Jul 2011 13:28:15 +0800
> tiejun.chen <tiejun.chen@windriver.com> wrote:
>=20
> > Kumar Gala wrote:
> > > I'm still very confused why we need a unique stack frame=20
> for kprobe/program exceptions on book-e devices.
> >=20
> > Its a bug at least for Book-E.
>=20
> But why only booke?  There's nothing booke-specific about the=20

I don't mean this is reproduced only on booke, so I use 'at least' carefull=
y to notice we really see this problem on booke.

> stwu instruction.

Please note this root cause to this bug is not related to how to emulate st=
wu instruction. That should be issued from the overlap between an exception=
 frame and the kprobed function stack frame on booke. Would you like to see=
 that example I showed?

>=20
> > And if you'd like to check another topic thread,
> > "[BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction=20
> 'stwu' lead to=20
> > system crash/freeze", you can know this story completely :)
> >=20
> > This bug should not be reproduced on PPC64 with the exception=20
> > prolog/endlog dedicated to PPC64.
>=20
> What if the function you're stepping through is creating a=20
> stack frame that is larger than the 288 bytes that get skipped?

>From that bug email looks PPC64 should be good from some feedbacks. So here=
 I think guys who are very familiar with PPC64 can reply this rather than m=
e :)

>=20
> > But I have no enough time to check other PPC32 & !BOOKE so I'm not=20
> > sure if we should extend this modification.
>=20
> Someone should.

This is fine to me.

But currently we have to fix this based on booke firstly.

Tiejun=20

>=20
> -Scott
>=20
> =
