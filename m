Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1B01467B4C
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 01:06:36 +1000 (EST)
In-Reply-To: <83a359bdf2c4d4902f58e6788c37811a@embeddededge.com>
References: <83a359bdf2c4d4902f58e6788c37811a@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <7f0a378a4f3b17a9db01773fcca5fafd@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 12 Apr 2005 10:06:19 -0500
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <galak@freescale.com>
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

On Apr 12, 2005, at 9:46 AM, Dan Malek wrote:

>
>
> On Apr 12, 2005, at 2:03 AM, Kumar Gala wrote:
>
> > The handling of misaligned load/store multiplies did not check to =
see
> > if
>  > the address were ok to access before __{get,put}_user().
>
> I think we should also take the opportunity to fix up the lawrx
> case and look for other reserved/conditional instructions
>  that may slip through.=A0 Since these are atomic operations, we
> can't emulate them.=A0 According to the PEM, an alignment fault
> on these is a fatal programming error.

When you say "fix up" I assume you mean lwarx should return 0.  It=20
appears that stwcx. is already doing that.  Can't think of any other=20
cases that need fixing.

- kumar
