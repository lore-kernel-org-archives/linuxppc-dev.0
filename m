Return-Path: <paulus@ozlabs.org>
Date: Thu, 1 Dec 2011 12:04:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Subject: Re: [PATCH 02/10] powerpc: Consolidate mpic_alloc() OF address
 translation
Message-ID: <20111201010402.GA5268@drongo>
References: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <1322593117-29938-3-git-send-email-Kyle.D.Moffett@boeing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1322593117-29938-3-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 29, 2011 at 01:58:29PM -0500, Kyle Moffett wrote:
> diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
> index 901bfbd..44f9774 100644
> --- a/arch/powerpc/platforms/powermac/pic.c
> +++ b/arch/powerpc/platforms/powermac/pic.c
> @@ -498,15 +498,10 @@ static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
>  						int master)
>  {
>  	const char *name = master ? " MPIC 1   " : " MPIC 2   ";
> -	struct resource r;
>  	struct mpic *mpic;
>  	unsigned int flags = master ? MPIC_PRIMARY : 0;
>  	int rc;
>  
> -	rc = of_address_to_resource(np, 0, &r);
> -	if (rc)
> -		return NULL;
> -

This gets me an unused variable warning, which because we compile
arch/powerpc with -Werror is fatal:

  CC      arch/powerpc/platforms/powermac/pic.o
/home/paulus/kernel/kvm-merge/arch/powerpc/platforms/powermac/pic.c: In function ‘pmac_setup_one_mpic’:
/home/paulus/kernel/kvm-merge/arch/powerpc/platforms/powermac/pic.c:491:6: error: unused variable ‘rc’ [-Werror=unused-variable]
cc1: all warnings being treated as errors

Need to remove the declaration of rc as well.

Paul.
