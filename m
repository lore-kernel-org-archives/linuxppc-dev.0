Return-Path: <tnt@246tNt.com>
Received: from outmx023.isp.belgacom.be (outmx023.isp.belgacom.be
	[195.238.4.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78A26DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 00:18:18 +1100 (EST)
Received: from outmx023.isp.belgacom.be (localhost [127.0.0.1])
	by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l08DI7t9011601
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 14:18:10 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A24411.4030501@246tNt.com>
Date: Mon, 08 Jan 2007 14:16:01 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>		<1166528379.19254.69.camel@localhost.localdomain>		<4587D338.7060906@246tNt.com>		<1166538553.25827.99.camel@pmac.infradead.org>		<1166558300.19254.71.camel@localhost.localdomain>		<1167773388.22068.443.camel@pmac.infradead.org>		<1167773863.6165.82.camel@localhost.localdomain>		<1167775493.3660.23.camel@shinybook.infradead.org>		<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>		<45A01416.6080401@genesi-usa.com>		<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>		<45A1535C.1080007@genesi-usa.com>	<1168222654.14763.92.camel@shinybook.infradead.org>	<45A20C66.8060506@genesi-usa.com>
	<45A23E8E.7010209@246tNt.com>
In-Reply-To: <45A23E8E.7010209@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: bbrv@genesi-usa.com, David Woodhouse <dwmw2@infradead.org>,
	Paul Mackerras <paulus@samba.org>, Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:
> 2) What I'd really like to see fixed (but that I can't mark as
> 'bugs' as obviously as the other)
>  - The compatible properties of system node (like sram,
>    bestcomm and pic) should at least include the mpc52xx-...
>    strings as defined in the 'linux' bindings. Better than
>    include, be exacty what has been defined but include would
>    "do the trick".
>   
Forgot something here :

The "bestcomm" node should have all the interrupts for all task
in it's interrupts property instead of a non existent IRQ.
Currently it does have <2 0 3> which doesn't really exists (it's the
casaded interrupt IIRC, this is from memory, no time to check
that now).
And it should have <3 0 0> <3 1 0> .... <3 15 0>.
Because those are really bestcomm interrupt and I think they
do belong there.

I know I can find thos in your "bestcomm-txtask bestcomm-rxtask"
nodes for preloaded tasks and it's good they are there.
But what if I want to use DMA for PSC6 where you didn't
load anytask ... I can find some free ram in the sram node, some
non-used tasks id but I got nowhere to find the interrupt ...
So I'd like to have them there as well ...


    Sylvain
