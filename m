Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 62B5667B44
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 01:26:59 +1000 (EST)
In-Reply-To: <7f0a378a4f3b17a9db01773fcca5fafd@freescale.com>
References: <7f0a378a4f3b17a9db01773fcca5fafd@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <cb6c89fb776248d3a2ddbcd5d3d043ed@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 12 Apr 2005 10:26:48 -0500
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: Fix alignment exception checking on load/store
	multiple instructions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  > > The handling of misaligned load/store multiplies did not check to=20=

> see
>  > > if
>  >=A0 > the address were ok to access before __{get,put}_user().
> >
>  > I think we should also take the opportunity to fix up the lawrx
> > case and look for other reserved/conditional instructions
>  >=A0 that may slip through.=A0 Since these are atomic operations, we
> > can't emulate them.=A0 According to the PEM, an alignment fault
> > on these is a fatal programming error.
>
> When you say "fix up" I assume you mean lwarx should return 0.=A0 It
> appears that stwcx. is already doing that.=A0 Can't think of any other
> cases that need fixing.

Upon further review, the PEM and PPC Arch spec, say that its ok to=20
emulate lwarz as an lwz.  =46rom the spec:

The instructions lwz and lwarx give the same DSISR bits (all zero). But=20=

if lwarx causes an Alignment interrupt, it should not be emulated. It=20
is adequate for the Alignment interrupt handler simply to treat the=20
instruction as if it were lwz. The emulator
must use the address in the DAR, rather than compute it from RA/RB/D,=20
because lwz and lwarx have different instruction formats.

So we are handled lwarx according to the arch specs already.

- kumar=
