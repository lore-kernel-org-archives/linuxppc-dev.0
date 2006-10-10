Return-Path: <dgibson@ozlabs.org>
Date: Tue, 10 Oct 2006 16:25:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 3/4] powerpc: Add simple memory allocator to bootwrapper
Message-ID: <20061010062538.GB18681@localhost.localdomain>
References: <20061010061246.GD28311@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010061246.GD28311@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 09, 2006 at 11:12:46PM -0700, Mark A. Greer wrote:
> Provide primitive malloc, free, and realloc functions for bootwrapper.

[snip]
> +/*
> + * Change size of area pointed to by 'ptr' to 'size'.
> + * If 'ptr' is NULL, then its a malloc().  If 'size' is 0, then its a free().
> + * 'ptr' must be NULL or a value previously returned by simple_realloc().
> + */
> +static void *simple_realloc(void *ptr, unsigned long size)
> +{
> +	if (size == 0) {
> +		simple_free(ptr);
> +		return NULL;
> +	}
> +	else if (ptr == NULL)
> +		return simple_malloc(size);
> +	else {
> +		simple_free(ptr);
> +		return simple_malloc(size);
> +	}
> +}

Um.. the above is clearly broken, it will throw away the data in a
realloc()ed block.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
