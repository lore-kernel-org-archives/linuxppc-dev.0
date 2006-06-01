Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13CF667AC7
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 04:14:27 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k51IENLr028948
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 14:14:23 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k51IEM9J113244
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 14:14:22 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k51IELej027014
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 14:14:21 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Collecting hypervisor call stats
Date: Thu, 1 Jun 2006 20:14:20 +0200
References: <20060531204144.GA7909@w-mikek2.ibm.com>
	<20060531225813.GC7909@w-mikek2.ibm.com>
	<1149139576.28307.28.camel@localhost.localdomain>
In-Reply-To: <1149139576.28307.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606012014.20467.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 01 June 2006 07:26, Benjamin Herrenschmidt wrote:
>=20
> > We need to get a timestamp before and after the call. =A0mftb should do
> > the trick. =A0Also, I'd prefer to have the code that stuffs the values
> > into the array be C. =A0So, the decision is to have the assembly code
> > call out to the C routine -OR- create wrappers for the assembly routine=
s.
> > I much prefer C wrappers to touching the assembly.
>=20
> Argh... yet another use of mftb for which I'll need a cell specific
> workaround=20

I guess for statistics, we should rather avoid that overhead (and
document the fact that we did on purpose).

How fast is mftb really? Would that be significant compared to the
time spent in a fast hcall?

	Arnd <><
