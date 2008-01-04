Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 Jan 2008 15:27:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Look for include files in the directory of the
	including file.
Message-ID: <20080104042739.GC4326@localhost.localdomain>
References: <20080103234331.GB8441@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080103234331.GB8441@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 05:43:31PM -0600, Scott Wood wrote:
> Looking in the diretory dtc is invoked from is not very useful behavior.
> 
> As part of the code reorganization to implement this, I removed the
> uniquifying of name storage -- it seemed a rather dubious optimization
> given likely usage, and some aspects of it would have been mildly awkward
> to integrate with the new code.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Would have been kind of nice to see the two parts as separate
patches.  But no big deal, again, I'd really like to see this in for
1.1.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

A few comments nonetheless:

[snip]
> @@ -260,7 +259,19 @@ int push_input_file(const char *filename)
>  		return 0;
>  	}
>  
> -	f = dtc_open_file(filename);
> +	if (srcpos_file) {
> +		search.dir = srcpos_file->dir;
> +		search.next = NULL;
> +		search.prev = NULL;
> +		searchptr = &search;
> +	}
> +
> +	newfile = dtc_open_file(filename, searchptr);
> +	if (!newfile) {
> +		yyerrorf("Couldn't open \"%s\": %s",
> +		         filename, strerror(errno));
> +		exit(1);

Use die() here, that's what it's for.

> +	}
>  
>  	incl_file = malloc(sizeof(struct incl_file));
>  	if (!incl_file) {

And we should be using xmalloc() here (not your change, I realise).

[snip]
> -FILE *dtc_open_file(const char *fname)
> +static int dtc_open_one(struct dtc_file *file,
> +                        const char *search,
> +                        const char *fname)
>  {
> -	FILE *f;
> -
> -	if (lookup_file_name(fname, 1) < 0)
> -		die("Too many files opened\n");
> -
> -	if (streq(fname, "-"))
> -		f = stdin;
> -	else
> -		f = fopen(fname, "r");
> +	char *fullname;
> +
> +	if (search) {
> +		fullname = malloc(strlen(search) + strlen(fname) + 2);
> +		if (!fullname)
> +			die("Out of memory\n");

xmalloc() again (your fault, this time).

> +		strcpy(fullname, search);
> +		strcat(fullname, "/");
> +		strcat(fullname, fname);
> +	} else {
> +		fullname = strdup(fname);
> +	}
>  
> -	if (! f)
> -		die("Couldn't open \"%s\": %s\n", fname, strerror(errno));
> +	file->file = fopen(fullname, "r");
> +	if (!file->file) {
> +		free(fullname);
> +		return 0;
> +	}
>  
> -	return f;
> +	file->name = fullname;
> +	return 1;
>  }
>  
>  
> -
> -/*
> - * Locate and optionally add filename fname in the file_names[] array.
> - *
> - * If the filename is currently not in the array and the boolean
> - * add_it is non-zero, an attempt to add the filename will be made.
> - *
> - * Returns;
> - *    Index [0..MAX_N_FILE_NAMES) where the filename is kept
> - *    -1 if the name can not be recorded
> - */
> -
> -int lookup_file_name(const char *fname, int add_it)
> +struct dtc_file *dtc_open_file(const char *fname,
> +                               const struct search_path *search)
>  {
> -	int i;
> -
> -	for (i = 0; i < n_file_names; i++) {
> -		if (strcmp(file_names[i], fname) == 0)
> -			return i;
> +	static const struct search_path default_search = { NULL, NULL, NULL };
> +
> +	struct dtc_file *file;
> +	const char *slash;
> +
> +	file = malloc(sizeof(struct dtc_file));
> +	if (!file)
> +		die("Out of memory\n");

xmalloc() again.

> +	slash = strrchr(fname, '/');
> +	if (slash) {
> +		char *dir = malloc(slash - fname + 1);
> +		if (!dir)
> +			die("Out of memory\n");

And again.

> +		memcpy(dir, fname, slash - fname);
> +		dir[slash - fname] = 0;
> +		file->dir = dir;
> +	} else {
> +		file->dir = NULL;
>  	}
>  
> -	if (add_it) {
> -		if (n_file_names < MAX_N_FILE_NAMES) {
> -			file_names[n_file_names] = strdup(fname);
> -			return n_file_names++;
> -		}
> +	if (streq(fname, "-")) {
> +		file->name = "stdin";
> +		file->file = stdin;
> +		return file;
>  	}
>  
> -	return -1;
> -}
> +	if (!search)
> +		search = &default_search;
>  
> +	while (search) {
> +		if (dtc_open_one(file, search->dir, fname))
> +			return file;

Don't we need a different case here somewhere for if someone specifies
an include file as an absolute path?  Have I missed something?

[snip]
> +struct search_path {
> +	const char *dir; /* NULL for current directory */
> +	struct search_path *prev, *next;
> +};

I wouldn't suggest a doubly linked list here.  Or at least not without
converting our many existing singly linked lists at the same time.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
