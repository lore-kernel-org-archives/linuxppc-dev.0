Return-Path: <tony@bakeyournoodle.com>
Date: Mon, 21 Dec 2009 11:44:58 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH] powerpc: update ibm,client-architecture
Message-ID: <20091221004458.GI30375@ozlabs.org>
References: <1261170452.8134.13.camel@jschopp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1261170452.8134.13.camel@jschopp-laptop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 18, 2009 at 03:07:32PM -0600, Joel Schopp wrote:
> In order to boot with more than 64 cores on machines that support the
> ibm,client-architecture RTAS call a new field has been added to the
> structure.  This patch updates that field and adds a few others in the
> process.  It would be good if this could go in as a bugfix.  

But it's not really is it? What does it fix?

> Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
> 
> Index: linux-2.6.git/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- linux-2.6.git.orig/arch/powerpc/kernel/prom_init.c
> +++ linux-2.6.git/arch/powerpc/kernel/prom_init.c
> @@ -654,6 +654,9 @@ static void __init early_cmdline_parse(v
>  #define OV5_CMO			0x00
>  #endif
>  
> +/* Option Vector 6: IBM PAPR hints */
> +#define OV6_LINUX		0x02	/* Linux is our OS */
> +
>  /*
>   * The architecture vector has an array of PVR mask/value pairs,
>   * followed by # option vectors - 1, followed by the option vectors.
> @@ -665,7 +668,7 @@ static unsigned char ibm_architecture_ve
>  	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
>  	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
>  	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
> -	5 - 1,				/* 5 option vectors */
> +	6 - 1,				/* 6 option vectors */
>  
>  	/* option vector 1: processor architectures supported */
>  	3 - 2,				/* length */
> @@ -697,12 +700,26 @@ static unsigned char ibm_architecture_ve
>  	0,				/* don't halt */
>  
>  	/* option vector 5: PAPR/OF options */
> -	5 - 2,				/* length */
> +	13 - 2,				/* length */
>  	0,				/* don't ignore, don't halt */
>  	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
>  	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
>  	0,
>  	OV5_CMO,
> +	0,				/* reserved */
> +	0,				/* reserved */
> +	0,				/* reserved */
> +	0,				/* reserved */

Not so much reserved, as unused by us.

> +	W(NR_CPUS/4),			/* max cores supported */

4?  I can see a case for 2 or just plain NR_CPUS, but 4 is wrong.

> +	/* option vector 6: IBM PAPR hints */
> +	4 - 2,

We all know this is a length, but please follow the style in this structure.

> +	0,				/* reserved */
> +	0,				/* 1 == no secondary pteg */

I think the "1 == " confuses things.

> +	OV6_LINUX,

Does filling in the vector actually let us boot on systems where we do not already?

> +
> +	/* option vector 7: IBM PAPR OS identification */
> +	/* a human readable ascii string will go here */

Either fill it in or leave the comments out.  

Yours Tony
