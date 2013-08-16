Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0034D2C0260
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 21:04:47 +1000 (EST)
Subject: Re: Critical Interrupt Input
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4724f96e$5f998126$5fb2b995$@deltatau.com>
Date: Fri, 16 Aug 2013 06:04:54 -0500
Message-Id: <DA804F98-B7E5-42C1-9D5C-8A8A63681EC0@kernel.crashing.org>
References: <4724f96e$5f998126$5fb2b995$@deltatau.com>
To: hbausley@deltatau.com
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 15, 2013, at 11:57 PM, Henry Bausley wrote:

>=20
> Is there any reason that a Critical Input Interrupt will not work =
reliably on a 44x powerpc?
>=20
> I am using an AMCC now Applied Micro AMCC460EX=20
>=20
> and changed
>=20
> CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
> to
> CRITICAL_EXCEPTION(0x0100, CriticalInput, do_MyCritIntr)
>=20
> The code for the handler is trivial
> ie.
> int crintrcount;
>=20
> void do_MyCritIntr(void)
> {
>   crintrcount++;
> }
>=20
> The code runs for a while but eventually I get panic messages and  the =
system hangs.  Is there something I must alter in the kernel to do this =
reliably?

The 44x low level code needs to handle exception stacks properly for =
this to work.  Since its possible to have a critical exception occur =
while in a normal exception level, you have to have proper saving of =
additional register state and a stack frame for the critical exception, =
etc.  I'm not sure if that was ever done for 44x.

- k
