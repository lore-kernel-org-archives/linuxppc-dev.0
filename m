Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 57C2167B47
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 22:56:20 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.6/8.13.6) with ESMTP id k429TQYP081472
	for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2006 09:29:26 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k429UbMP118056
	for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2006 11:30:37 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k429TPFR025396
	for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2006 11:29:25 +0200
In-Reply-To: <17489.18630.75412.66803@cargo.ozlabs.ibm.com>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
To: Paul Mackerras <paulus@samba.org>
Message-ID: <OF38200CFC.0F39484B-ONC1257162.003179ED-C1257162.0033A003@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Tue, 2 May 2006 11:30:35 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>,
	=?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We started like that to get a clean interface between the register
intensive h_calls and the driver code.
We're in the middle of the tradeoff  "nice interface" vs strict fencing=
 of
data structures from one code piece to another.
Initially these functions, which only move paramaters from the stack in=
to
registers and back, were inline functions.
So the compiler collapsed the function call into "nothing", which won't=

work if you use a struct *.
Somewhen during code reviews people agreed that having this many inline=

functions leads to large header files
which isn't a good idea either.

We're about to change that interface again, so what should be the max
number of parameters in a function call?
The limit in existing kernel code is somewhere between 5-8
(just as a reminder, 8 is the max nr of parameters to be passed by regi=
ster
on ppc)


christoph raisch

Paul Mackerras <paulus@samba.org> wrote on 28.04.2006 00:42:14:

> J=F6rn Engel writes:
>
> > 25 parameters?  If you tell me which drugs were involved in this co=
de,
> > I know what to stay away from.
>
> You really need to ask the firmware architects that, since this is
> basically a single firmware call.
>
> Mind you, since a lot of the parameters are used to return individual=

> bytes or half-words, which are then put into structures, it might be
> better to pass the pointers to the structures and let the wrapper put=

> the values straight into the structures.
>
> Paul.=
