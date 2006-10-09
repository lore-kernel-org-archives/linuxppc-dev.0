Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80E7667A5E
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 18:58:46 +1000 (EST)
Subject: Re: [PATCH] powerpc: Cell timebase bug workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061009183652.3d4897bc.sfr@canb.auug.org.au>
References: <1160370623.14601.42.camel@localhost.localdomain>
	<20061009165629.4fa5813a.sfr@canb.auug.org.au>
	<1160377517.14601.48.camel@localhost.localdomain>
	<20061009183652.3d4897bc.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 18:57:55 +1000
Message-Id: <1160384275.10229.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-09 at 18:36 +1000, Stephen Rothwell wrote:
> On Mon, 09 Oct 2006 17:05:17 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > > Why not branch back to the mftb if the lower word is zero (this would
> > > also take care of the very unlikely "hitting the bug more than once" case
> > > and the "normal" case would then not have to branch at all.  (And it uses
> > > one less instruction.)
> >
> > Because that would cause us to spinloop for the whole duration of a tb
> > tick in that case, which is pretty bad when the timebase is slow (the
> > slower I've seen so far is 14Mhz).
> 
> Right!  /me hits himself in the forehead :-)

Well, it's not -that- stupid .... I did consider it. The chances of
hitting the problem at all are so small that taking a 100ns hit or so
when it happen isn't -that- bad and it does make the normal case nicer
avoiding a branch....

In fact, I'll ask Mike what he thinks of doing it that way instead, it
might be a better option in the long run.

Ben.
