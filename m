Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 Jan 2008 15:30:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] Return a non-zero exit code if an error occurs
	during dts parsing.
Message-ID: <20080104043033.GD4326@localhost.localdomain>
References: <20080103234333.GC8441@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080103234333.GC8441@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 05:43:33PM -0600, Scott Wood wrote:
> Previously, only failure to parse caused the reading of the tree to fail;
> semantic errors that called yyerror() but not YYERROR only emitted a message,
> without signalling make to stop the build.

This one, however, I don't like.

[snip]
> diff --git a/dtc.h b/dtc.h
> index 9b89689..cba9d28 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -233,6 +233,7 @@ struct reserve_info *add_reserve_entry(struct reserve_info *list,
>  struct boot_info {
>  	struct reserve_info *reservelist;
>  	struct node *dt;		/* the device tree */
> +	int error;
>  };

This is unequivocally wrong.  boot_info should have information about
the contents of the blob, not state information like the error.

If you're going to use an ugly global, then use it everywhere.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
