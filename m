Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 186E5DE187
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 23:08:40 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3LD8anD032095
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 09:08:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3LD8aVF163342
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 07:08:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3LD8ZKG026270
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 07:08:36 -0600
Date: Mon, 21 Apr 2008 08:03:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 1/2] [v3][POWERPC] refactor dcr code
Message-ID: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
In-Reply-To: <20080421035624.E528B48806A@mail212-sin.bigfish.com>
References: <1206914576.10388.132.camel@pasglop>
	<20080418215513.ACA0C17F007A@mail131-dub.bigfish.com>
	<20080419093500.752c1930@zod.rchland.ibm.com>
	<20080421035624.E528B48806A@mail212-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 20 Apr 2008 20:56:20 -0700
"Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com> wrote:

> 
> 
> > > +void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c)
> > > +{
> > > +	if (host.type == NATIVE)
> > > +		dcr_unmap_native(host.host.native, dcr_c);
> > > +	else
> > > +		dcr_unmap_mmio(host.host.mmio, dcr_c);
> >
> > What happens if host.type == INVALID?  Same question for the other
> > accessors in dcr_*_generic.
> 
> I guess looking back on it, I assumed that MAP_OK would return 0, meaning that behavior was undefined,
> but I agree it's probably safer to have some error reporting there...  There starts to become a speed tradeoff
> at some point, which would make function pointers more attractive.  If the ioremap does fail, or the
> dcr-access-method can't be determined, then dcr_unmap_mmio would probably SEGV anyway, although that's
> not something I'd really want to rely on.  I'll put an error case in there.

Well, MAP_OK would return 0, and the caller of the original dcr_map
should probably return an error or something.  But there's nothing to
enforce that.  Which is true for the current code today as well, so
it's not something you've introduced.

I just thought that if you were going to go to the trouble of defining
an invalid host type, that you'd check for it in the accessor
functions.  There is the concern of the speed tradeoffs.  I suppose you
could just omit INVALID altogether and have it match the existing code
in behavior if it was too big of a deal.

Ben, any thoughts?

josh
