Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17476.34830.897083.360572@cargo.ozlabs.ibm.com>
Date: Tue, 18 Apr 2006 16:32:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
In-Reply-To: <1145340034.4705.55.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
	<1145048461.4223.38.camel@localhost.localdomain>
	<17476.31998.168122.413195@cargo.ozlabs.ibm.com>
	<1145340034.4705.55.camel@localhost.localdomain>
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> The 970 version bloats the exception prolog significantly... I

Four instructions, in the external and decrementer interrupt entry
paths - I don't think that's really significant bloat.

> understand now why you were talking about putting the code in the exit
> path on irc ... I don't like it that way.... Also, if you want to keep
> it, maybe use a separate CONFIG_PPC_970STYLE_NAP or something that gets
> selected by platforms that can do it ?

The config option makes sense.

> I suppose a PACA field would be less inefficient but still sucks... the
> exception return to userland code path already accesses thread_info and
> definitely looks like a better place to put it... as long as we never
> have to add dodgy workarounds when getting out of NAP like we do on 6xx.

More likely we'll get more situations like Cell where we come in
through the soft reset vector after sleep.

Paul.
