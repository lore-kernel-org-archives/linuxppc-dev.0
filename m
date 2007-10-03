Return-Path: <shemminger@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3691FDDE2E
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 02:45:16 +1000 (EST)
Date: Wed, 3 Oct 2007 09:44:49 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v4] qe: miscellaneous code improvements and fixes to the
	QE library
Message-ID: <20071003094449.702c4a90@freepuppy.rosehill>
In-Reply-To: <1191429299378-git-send-email-timur@freescale.com>
References: <1191429299378-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed,  3 Oct 2007 11:34:59 -0500
Timur Tabi <timur@freescale.com> wrote:

> This patch makes numerous miscellaneous code improvements to the QE library.
> 
> 1. Remove struct ucc_common and merge ucc_init_guemr() into ucc_set_type()
>    (every caller of ucc_init_guemr() also calls ucc_set_type()).  Modify all
>    callers of ucc_set_type() accordingly.
> 
> 2. Remove the unused enum ucc_pram_initial_offset.
> 
> 3. Refactor qe_setbrg(), also implement work-around for errata QE_General4.
> 
> 4. Several printk() calls were missing the terminating \n.
> 
> 5. Add __iomem where needed, and change u16 to __be16 and u32 to __be32 where
>    appropriate.
> 
> 6. In ucc_slow_init() the RBASE and TBASE registers in the PRAM were programmed
>    with the wrong value.
> 
> 7. Add the protocol type to struct us_info and updated ucc_slow_init() to
>    use it, instead of always programming QE_CR_PROTOCOL_UNSPECIFIED.
> 
> 8. Rename ucc_slow_restart_x() to ucc_slow_restart_tx()
> 
> 9. Add several macros in qe.h (mostly for slow UCC support, but also to
>    standardize some naming convention) and remove several unused macros.
> 
> 10. Update ucc_geth.c to use the new macros.
> 
> 11. Add ucc_slow_info.protocol to specify which QE_CR_PROTOCOL_xxx protcol
>     to use when initializing the UCC in ucc_slow_init().
> 
> 12. Rename ucc_slow_pram.rfcr to rbmr and ucc_slow_pram.tfcr to tbmr, since
>     these are the real names of the registers.
> 
> 13. Use the setbits, clrbits, and clrsetbits where appropriate.
> 
> 14. Refactor ucc_set_qe_mux_rxtx().
> 
> 15. Remove all instances of 'volatile'.
> 
> 16. Simplify get_cmxucr_reg();
> 
> 17. Replace qe_mux.cmxucrX with qe_mux.cmxucr[].
> 
> 18. Updated struct ucc_geth because struct ucc_fast is not padded any more.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 

Separate the changes into individual patches to allow for better comment/review
and bisection in case of regression.
