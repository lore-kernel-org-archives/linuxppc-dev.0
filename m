Return-Path: <mgreer@mvista.com>
Date: Tue, 10 Oct 2006 08:59:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 3/4] powerpc: Add simple memory allocator to bootwrapper
Message-ID: <20061010155925.GA15265@mag.az.mvista.com>
References: <20061010061246.GD28311@mag.az.mvista.com>
	<20061010062538.GB18681@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010062538.GB18681@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 10, 2006 at 04:25:38PM +1000, David Gibson wrote:
> On Mon, Oct 09, 2006 at 11:12:46PM -0700, Mark A. Greer wrote:
> > Provide primitive malloc, free, and realloc functions for bootwrapper.
> 
> [snip]
> > +/*
> > + * Change size of area pointed to by 'ptr' to 'size'.
> > + * If 'ptr' is NULL, then its a malloc().  If 'size' is 0, then its a free().
> > + * 'ptr' must be NULL or a value previously returned by simple_realloc().
> > + */
> > +static void *simple_realloc(void *ptr, unsigned long size)
> > +{
> > +	if (size == 0) {
> > +		simple_free(ptr);
> > +		return NULL;
> > +	}
> > +	else if (ptr == NULL)
> > +		return simple_malloc(size);
> > +	else {
> > +		simple_free(ptr);
> > +		return simple_malloc(size);
> > +	}
> > +}
> 
> Um.. the above is clearly broken, it will throw away the data in a
> realloc()ed block.

Yes, too much of a hurry, I guess.  I'll fix.

Mark
