Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 14:52:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Look for include files in the directory of the
	including file.
Message-ID: <20080110035201.GJ17816@localhost.localdomain>
References: <20080103234331.GB8441@ld0162-tx32.am.freescale.net>
	<20080104042739.GC4326@localhost.localdomain>
	<20080106225252.GB8239@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080106225252.GB8239@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 06, 2008 at 04:52:52PM -0600, Scott Wood wrote:
> On Fri, Jan 04, 2008 at 03:27:39PM +1100, David Gibson wrote:
> > > +	newfile = dtc_open_file(filename, searchptr);
> > > +	if (!newfile) {
> > > +		yyerrorf("Couldn't open \"%s\": %s",
> > > +		         filename, strerror(errno));
> > > +		exit(1);
> > 
> > Use die() here, that's what it's for.
> 
> die() doesn't print file and line information.
> 
> > > +	while (search) {
> > > +		if (dtc_open_one(file, search->dir, fname))
> > > +			return file;
> > 
> > Don't we need a different case here somewhere for if someone specifies
> > an include file as an absolute path?  Have I missed something?
> 
> Yeah, I forgot about that, and sent another patch to fix it when I
> noticed (jdl had already pulled, so I didn't send an amended patch).
> 
> > [snip]
> > > +struct search_path {
> > > +	const char *dir; /* NULL for current directory */
> > > +	struct search_path *prev, *next;
> > > +};
> > 
> > I wouldn't suggest a doubly linked list here.  Or at least not without
> > converting our many existing singly linked lists at the same time.
> 
> The doubly-linked list is intended to make it easier to construct search
> path lists one-at-a-time from arguments in the proper order, without
> needing to reverse the list at the end.

We've already got that problem with a bunch of the lists we create
during parsing (we have several ugly add-to-end-of-singly-linked-list
functions).  Going to doubly-linked lists might not be a bad idea, but
we should do it across the board, probably using the kernel's list.h
or something like it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
