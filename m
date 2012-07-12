Return-Path: <paulus@ozlabs.org>
Date: Fri, 13 Jul 2012 08:45:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stuart Yoder <stuart.yoder@freescale.com>
Subject: Re: [PATCH v4] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
Message-ID: <20120712224556.GA9730@bloggs.ozlabs.ibm.com>
References: <1341499295-10795-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341499295-10795-1-git-send-email-stuart.yoder@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 05, 2012 at 09:41:35AM -0500, Stuart Yoder wrote:

> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index ba3aeb4..bad42e3 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -92,7 +92,7 @@ crit_transfer_to_handler:
>  	mfspr	r8,SPRN_SPRG_THREAD
>  	lwz	r0,KSP_LIMIT(r8)
>  	stw	r0,SAVED_KSP_LIMIT(r11)
> -	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
> +	CURRENT_THREAD_INFO(r0, r1)
>  	stw	r0,KSP_LIMIT(r8)
>  	/* fall through */
>  #endif
> @@ -112,7 +112,7 @@ crit_transfer_to_handler:
>  	mfspr	r8,SPRN_SPRG_THREAD
>  	lwz	r0,KSP_LIMIT(r8)
>  	stw	r0,saved_ksp_limit@l(0)
> -	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
> +	CURRENT_THREAD_INFO(r0, r1)
>  	stw	r0,KSP_LIMIT(r8)
>  	/* fall through */
>  #endif

Do you really mean to replace a rlwimi with a rlwinm?  If so, is that
because the rlwinm is a bug fix, or is it because you know something
special about KSP_LIMIT(r8) which means that rlwinm and rlwimi are
equivalent here?

Paul.
