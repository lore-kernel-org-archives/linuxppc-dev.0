Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01717B7B7B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:48:46 +1100 (EST)
Subject: Re: [PATCH 1/6] 8xx: DTLB Error must check for more errors.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255008298-19949-2-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255008298-19949-2-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 07:48:18 +1100
Message-Id: <1255034898.2146.23.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 15:24 +0200, Joakim Tjernlund wrote:
> DataTLBError currently does:
>  if ((err & 0x02000000) == 0)
>     DSI();
> This won't handle a store with no valid translation.
> Change this to
>  if ((err & 0x48000000) != 0)
>     DSI();
> that is, branch to DSI if either !permission or
> !translation.
> ---

As I said earlier, I don't think this is necessary, just get rid of the
whole bunch of code in DataTLBError :-)

Ben.

>  arch/powerpc/kernel/head_8xx.S |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 52ff8c5..118bb05 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -472,8 +472,8 @@ DataTLBError:
>  	/* First, make sure this was a store operation.
>  	*/
>  	mfspr	r10, SPRN_DSISR
> -	andis.	r11, r10, 0x0200	/* If set, indicates store op */
> -	beq	2f
> +	andis.	r11, r10, 0x4800 /* no translation, no permission. */
> +	bne	2f	/* branch if either is set */
>  
>  	/* The EA of a data TLB miss is automatically stored in the MD_EPN
>  	 * register.  The EA of a data TLB error is automatically stored in
