Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <c689550a30a3129f8576f78eaa6f7af4@freescale.com>
References: <1112770418.9567.137.camel@gaston>
	<c689550a30a3129f8576f78eaa6f7af4@freescale.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 08:22:42 +1000
Message-Id: <1112826162.9568.175.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-04-06 at 11:44 -0500, Kumar Gala wrote:

> Ben, I agree with you about having the flags in a single word so we can 
> lock them properly.  In the short term it appears that the issue I'm 
> running into is explicit with ptep_get_and_clear():
> 
> static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned 
> long addr,
>                                         pte_t *ptep)
> {
>          return __pte(pte_update(ptep, ~_PAGE_HASHPTE, 0));
> }
> 
> It appears that we should be returning the pte that was passed in, 
> before its modified?  (seems a little silly to me, why bother, the 
> caller could do this -- i've posted to lkml on the issue?).

No, we should return the "old" PTE.

>   Anyways, 
> since pte_update only returns the lower 32-bits the wrong thing 
> happens.  The following seems to be a better implementation of 
> ptep_get_and_clear() for ppc32 which resolves my issue:
> 
> static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned 
> long addr,
>                                         pte_t *ptep)
> {
>          pte_t tmp = *ptep;
>          pte_update(ptep, ~_PAGE_HASHPTE, 0);
>          return tmp;
> }

Hrm... I would still do it differently. I would read the "rpn only" part
non atomically and load/clear the other half atomically. Withotu that,
you may miss a bit set between the load and the update (for example,
_PAGE_HASHPTE may have been put in in between).

> If we are ok with this I'll send a patch upstream for it.  I'd like to 
> still discuss how to make this all proper long term.  Currently, 
> ptep_get_and_clear was the only user of pte_update that used the return 
> value for anything but flags.  One change would be for it to return 
> just the flags portion of the pte it was given.  Another would be for 
> us to implement a proper 64-bit pte version of pte_update.
> 
> - kumar
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
