Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2668F679A6
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 16:00:44 +1000 (EST)
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17476.31998.168122.413195@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
	<1145048461.4223.38.camel@localhost.localdomain>
	<17476.31998.168122.413195@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 16:00:34 +1000
Message-Id: <1145340034.4705.55.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Tue, 2006-04-18 at 15:45 +1000, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > Looks good to me except that we need the same for ppc64 since the 970
> > theorically has the same problem...
> 
> OK, does this look OK to everyone, before I send it off to Linus?  I
> now use a bit in the thread_info rather than using the HID0 bits
> themselves to indicate that we're napping, since the m[ft]spr might be
> slow.  I added a `local_flags' field to the thread_info struct for
> things that are only changed by the task itself and therefore don't
> need to be accessed atomically.
> 
> This version does the same sort of change for the 970 as for 6xx.

Hrm...

The 970 version bloats the exception prolog significantly... I
understand now why you were talking about putting the code in the exit
path on irc ... I don't like it that way.... Also, if you want to keep
it, maybe use a separate CONFIG_PPC_970STYLE_NAP or something that gets
selected by platforms that can do it ?

I suppose a PACA field would be less inefficient but still sucks... the
exception return to userland code path already accesses thread_info and
definitely looks like a better place to put it... as long as we never
have to add dodgy workarounds when getting out of NAP like we do on 6xx.

Ben.
