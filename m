Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DF4667C3E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 07:43:22 +1000 (EST)
Subject: Re: [PATCH] fix gettimeofday vs. update_gtod race
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20060821212555.GC9828@localdomain>
References: <20060811204105.GK3233@localdomain>
	<1155772134.11312.119.camel@localhost.localdomain>
	<20060817001807.GB354@localdomain>
	<1155774477.11312.137.camel@localhost.localdomain>
	<20060817204712.GD354@localdomain> <20060821212555.GC9828@localdomain>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 07:43:10 +1000
Message-Id: <1156196590.21752.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-08-21 at 16:25 -0500, Nathan Lynch wrote:
> Nathan Lynch wrote:
> > Benjamin Herrenschmidt wrote:
> > > On Wed, 2006-08-16 at 19:18 -0500, Nathan Lynch wrote:
> > > 
> > > > No?  I didn't find anything about mftb having synchronizing
> > > > behavior.  How should we ensure that temp_varp is assigned before
> > > > reading the timebase?
> > > 
> > > I sync an isync would be enough.
> > 
> > I see, thanks.
> 
> Actually, after checking Book 2 and discussing with some other folks
> I'm not so sure -- isync "may complete before storage accesses
> associated with instructions preceding the isync instruction have been
> performed."

Of sure, I was thinking about isync preventing mftb from being executed
and we can have a proper data dependency. Anyway, that's not necessary,
I've looked at the code and we no longer need to pass the tb value in
(it's historical). Thus we can just move the mftb in the protected area
and maybe with a twi/isync pair make sure we got the gtod pointer before
we do the mftb

Ben.
