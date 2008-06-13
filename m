Return-Path: <dgibson@ozlabs.org>
Date: Fri, 13 Jun 2008 10:01:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: dtc: Add support for binary includes.
Message-ID: <20080613000125.GA10981@yookeroo.seuss>
References: <20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
	<483C4C04.9020408@freescale.com>
	<20080528235859.GA10260@yookeroo.seuss>
	<20080529000227.GB10260@yookeroo.seuss>
	<48404D83.4070108@freescale.com>
	<20080604041304.GD29085@yookeroo.seuss>
	<4846A60F.9020909@freescale.com>
	<20080611015839.GB22012@yookeroo.seuss>
	<20080612164322.GA2972@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612164322.GA2972@loki.buserror.net>
Cc: jdl@jdl.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 11:43:22AM -0500, Scott Wood wrote:
> On Wed, Jun 11, 2008 at 11:58:39AM +1000, David Gibson wrote:
> > Scott's original patch does still have some implementation details I
> > didn't like.  So in the interests of saving time, I've addressed some
> > of those, added a testcase, and and now resubmitting my revised
> > version of Scott's patch.
> 
> Acked-by: Scott Wood <scottwood@freescale.com>
> 
> > -struct data data_copy_file(FILE *f, size_t len)
> > +struct data data_copy_file(FILE *f, size_t maxlen)
> >  {
> > -	struct data d;
> > +	struct data d = empty_data;
> > +
> > +	while (!feof(f) && (d.len < maxlen)) {
> > +		size_t chunksize, ret;
> > +
> > +		if (maxlen == -1)
> > +			chunksize = 4096;
> > +		else
> > +			chunksize = maxlen - d.len;
> > +
> > +		d = data_grow_for(d, chunksize);
> > +		ret = fread(d.val + d.len, 1, chunksize, f);
> > +
> > +		if (ferror(f))
> > +			die("Error reading file into data: %s", strerror(errno));
> 
> It'd be nice if we could keep the filename around for reporting here...

It would.  Well, I've been intending to clean up the input file
handling in several ways already, I'll see if that can be worked in.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
