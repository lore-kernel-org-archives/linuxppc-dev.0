Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18114.39893.913684.592560@cargo.ozlabs.ibm.com>
Date: Wed, 15 Aug 2007 16:23:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: fix i2c device string format
In-Reply-To: <Pine.LNX.4.60.0708092233130.5995@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
	<Pine.LNX.4.60.0707202219340.3946@poirot.grange>
	<235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>
	<Pine.LNX.4.60.0708010739560.4228@poirot.grange>
	<19a13f8700d078abc4cab0064a7d0183@kernel.crashing.org>
	<Pine.LNX.4.60.0708012053240.7394@poirot.grange>
	<46B0F030.9030007@freescale.com>
	<Pine.LNX.4.60.0708080023030.8493@poirot.grange>
	<3368b27f860fafb35d10f6352e9055bf@kernel.crashing.org>
	<Pine.LNX.4.60.0708092233130.5995@poirot.grange>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski writes:

> On Thu, 9 Aug 2007, Segher Boessenkool wrote:
> 
> > > > strncpy() won't put a terminating zero on there, is everything
> > > > that uses the resulting string okay with that?  Also, if the
> > > > name gets cut short, it might match some _other_ expected name.
> > > 
> > > On Wed, 1 Aug 2007, Scott Wood wrote:
> > > 
> > > > You could use strlcpy() instead, which always leaves a zero terminator.
> > > 
> > > The patch below does exactly this - uses strlcpy() to guarantee strings in
> > > i2c device type and driver_name fields are 0-terminated.
> > 
> > You're not checking the return values of these calls.  This would
> > be a good function to put attribute warn_unused_result on :-)
> 
> hm... Well, the worst that could happen, if an "evil" programmer defines 
> too long a name, it gets truncated, and then binds to a wrong driver, 
> well, the worst that can happen is that your hardware gets damaged, not a 
> big thing. However, some might disagree, so, below is a new version... 
> Wrap some long lines while at that.

That's not a commit message I can use.  Please repost with an
informative commit message that says what the motivation for the
change is, plus anything other information that would be useful for
someone looking at this in a couple of years' time.

Paul.
