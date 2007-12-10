Return-Path: <dgibson@ozlabs.org>
Date: Tue, 11 Dec 2007 10:10:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Use embedded libfdt in the bootwrapper
Message-ID: <20071210231056.GC5495@localhost.localdomain>
References: <20071210032343.GB29611@localhost.localdomain>
	<20071210032839.71412DDDFA@ozlabs.org>
	<20071210173217.GB4497@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210173217.GB4497@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 11:32:17AM -0600, Scott Wood wrote:
> On Mon, Dec 10, 2007 at 02:28:39PM +1100, David Gibson wrote:
> > +#define check_err(err) \
> > +	({ \
> > +		if (BAD_ERROR(err) || ((err < 0) && DEBUG)) \
> > +			printf("%s():%d  %s\n\r", __FUNCTION__, __LINE__, \
> > +			       fdt_strerror(err)); \
> > +		if (BAD_ERROR(err)) \
> > +			exit(); \
> > +		(err < 0) ? -1 : 0; \
> > +	})
> > +
> > +#define offset_devp(off)	\
> > +	({ \
> > +		int offset = (off); \
> > +		check_err(offset) ? NULL : (void *)(offset+1); \
> > +	})
> > +
> > +#define devp_offset(devp)	(((int)(devp))-1)
> 
> How does using offsets as devps work if a devp was previously acquired to a
> node that has to be moved due to a change later made in an earlier part of
> the tree?

It doesn't; don't do that.  I just don't think truly persistent
phandles are worth the code complexity to implement them.  Especially
since their use more-or-less completely precludes libfdt's "stateless"
approach, which has significant other advantages.

To reduce the confusion over this, the libfdt native interface always
refers to the offsets explicitly as offsets.  For the bootwrapper
abstraction layer, unfortunately I'm stuck with the "devp" terminology
for the time being.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
