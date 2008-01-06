Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A83F1DDE2F
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 09:53:12 +1100 (EST)
Date: Sun, 6 Jan 2008 16:52:52 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] Look for include files in the directory of the
	including file.
Message-ID: <20080106225252.GB8239@ld0162-tx32.am.freescale.net>
References: <20080103234331.GB8441@ld0162-tx32.am.freescale.net>
	<20080104042739.GC4326@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080104042739.GC4326@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 04, 2008 at 03:27:39PM +1100, David Gibson wrote:
> > +	newfile = dtc_open_file(filename, searchptr);
> > +	if (!newfile) {
> > +		yyerrorf("Couldn't open \"%s\": %s",
> > +		         filename, strerror(errno));
> > +		exit(1);
> 
> Use die() here, that's what it's for.

die() doesn't print file and line information.

> > +	while (search) {
> > +		if (dtc_open_one(file, search->dir, fname))
> > +			return file;
> 
> Don't we need a different case here somewhere for if someone specifies
> an include file as an absolute path?  Have I missed something?

Yeah, I forgot about that, and sent another patch to fix it when I
noticed (jdl had already pulled, so I didn't send an amended patch).

> [snip]
> > +struct search_path {
> > +	const char *dir; /* NULL for current directory */
> > +	struct search_path *prev, *next;
> > +};
> 
> I wouldn't suggest a doubly linked list here.  Or at least not without
> converting our many existing singly linked lists at the same time.

The doubly-linked list is intended to make it easier to construct search
path lists one-at-a-time from arguments in the proper order, without
needing to reverse the list at the end.

-Scott
