Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FC9CDDF3D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 08:38:30 +1000 (EST)
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808052335i7a3bbc64g5bcdaca21c3550af@mail.gmail.com>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<20080805.233205.201125898.davem@davemloft.net>
	<fa686aa40808052335i7a3bbc64g5bcdaca21c3550af@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Aug 2008 08:37:58 +1000
Message-Id: <1218148678.24157.317.camel@pasglop>
Mime-Version: 1.0
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-06 at 00:35 -0600, Grant Likely wrote:
> On Wed, Aug 6, 2008 at 12:32 AM, David Miller <davem@davemloft.net> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> > Date: Wed, 06 Aug 2008 00:02:44 -0600
> >
> >> of_lookup_stdout() is useful for figuring out what device to use as output
> >> for early boot progress messages.  It returns the node pointed to by the
> >> linux,stdout-path property in the chosen node.
> >>
> >> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > On sparc platforms this is obtained differently.  We obtain the 32-bit
> > instance value of "/chosen/stdout" and convert that into a prom device
> > node path using "instance-to-path".
> 
> How about if I modify it to try both methods?

The sparc method however cannot be used on powerpc because it requires
a call to OF to do the "live" conversion (ie, instance-to-path). In
fact, our /chosen/linux,stdout-path is just a cached result of that
conversion done during boot.

Ben.
