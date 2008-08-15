Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Aug 2008 11:34:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3] libfdt: Add support for using aliases in
	fdt_path_offset()
Message-ID: <20080815013439.GB12327@yookeroo.seuss>
References: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net>
	<20080814174348.GA19488@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080814174348.GA19488@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 12:43:48PM -0500, Scott Wood wrote:
> On Thu, Aug 14, 2008 at 08:28:19AM -0500, Kumar Gala wrote:
> > -	if (*path != '/')
> > -		return -FDT_ERR_BADPATH;
> > +	/* see if we have an alias */
> > +	if (*path != '/') {
> > +		const char *q;
> > +		int aliasoffset = fdt_path_offset(fdt, "/aliases");
> > +
> > +		if (aliasoffset < 0)
> > +			return -FDT_ERR_BADPATH;
> > +
> > +		q = strchr(path, '/');
> > +		if (!q)
> > +			q = end;
> > +
> > +		p = fdt_getprop_namelen(fdt, aliasoffset, path, q - p, NULL);
> > +		if (!p)
> > +			return -FDT_ERR_BADPATH;
> > +		offset = fdt_path_offset(fdt, p);
> > +
> > +		p = q;
> > +	}
> 
> Can we limit the recursion depth to avoid falling off the stack if an
> alias points to itself?  Or if aliases pointing to aliases are
> disallowed, check for a leading '/' before recursively calling
> fdt_path_offset.

Hmm.. my reading of 1275 says that an alias pointing to another alias
is not permitted, but I'm not terribly confident I'm not misreading
it.  Segher, do you know whether this is allowed?

If that's the case then, yes, we should not recurse if the alias value
doesn't start with a /.  In fact, if I factor out a fdt_get_alias()
function, it should probably check the alias and return an error if
it's not an absolute path.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
