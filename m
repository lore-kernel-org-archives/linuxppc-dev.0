Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AE25DDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 04:27:13 +1100 (EST)
Date: Tue, 26 Feb 2008 11:26:54 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080226172654.GB305@ld0162-tx32.am.freescale.net>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080226003955.GA24382@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080226003955.GA24382@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 26, 2008 at 11:39:55AM +1100, David Gibson wrote:
> > diff --git a/Makefile b/Makefile
> > index 8a47c34..d4d935c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -16,7 +16,7 @@ LOCAL_VERSION =
> >  CONFIG_LOCALVERSION =
> >  
> >  CPPFLAGS = -I libfdt
> > -CFLAGS = -Wall -g -Os
> > +CFLAGS = -Wall -g -Os -D_FILE_OFFSET_BITS=64
> 
> Is this portable?

It seems fairly widespread, but I don't know if it's specified by any
standards.  Some googling shows that _LARGE_FILES and _LARGEFILE64_SOURCE
are used in some environments.

> >  	d.len = len;
> > -	fread(d.val, len, 1, f);
> > +	if (fread(d.val, len, 1, f) != 1) {
> > +		yyerrorf("Couldn't read %zu bytes from file: %s",
> > +		         len, feof(f) ? "end-of-file" : strerror(errno));
> > +		return empty_data;
> 
> Ugh.
> 	1) Error messages direct to the user really don't belong in
> data.c's low-level support routines.  This does mean we might need to
> substantially change this function so there's some other way of
> reporting the error to the caller who can report it.

Any suggestions on a mechanism that doesn't throw away information by
condensing everything down to a single error number?

> 	2) The horrid name 'yyerror()' exists only to match what bison
> expects.  It should never be used outside the parse code (we probably
> should create more generally usable error/warning functions, though).

Fine, so suggest a name.

> 	3) Is %zu portable?

I believe it's part of C99.

> > +	}
> > +
> > +	return d;
> > +}
> > +
> > +struct data data_copy_file_all(FILE *f)
> 
> It should be possible to combine these two functions.

Probably.

> > +		d = data_grow_for(d, ret);
> > +		memcpy(d.val + d.len, buf, ret);
> > +
> > +		if (d.len + ret < d.len) {
> > +			yyerror("Binary include too large");
> 
> Hrm.  A test which will cover this case should go into
> data_grow_for(), I think.

Agreed.

-Scott
