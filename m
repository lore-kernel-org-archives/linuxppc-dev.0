Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Aug 2012 09:57:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] powerpc/mm: match variable types to API
Message-ID: <20120828235718.GA11869@bloggs.ozlabs.ibm.com>
References: <1345573348-28248-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345573348-28248-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, Joe MacDonald <joe.macdonald@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2012 at 02:22:28PM -0400, Paul Gortmaker wrote:
> From: Joe MacDonald <joe.macdonald@windriver.com>
> 
> sys_subpage_prot() takes an unsigned long for 'addr' then does some stuff
> with it and the result is stored in a signed int, i, which is eventually
> used as the size parameter in a copy_from_user call.  Update 'i' to be an
> unsigned long as well and since 'nw' is used in a size_t context which,
> depending on whether this is 32- or 64-bit may be unsigned int or unsigned
> long, switch that to a size_t and always be right.
> 
> Finally, since we're in the neighbourhood, make the same changes to
> subpage_prot_clear().
> 
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Joe MacDonald <joe.macdonald@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

This change won't hurt; in fact it won't make any difference since (a)
this code is only ever used on 64-bit and (b) i and nw are restricted
to the range 0 .. PTRS_PER_PTE - 1, but I agree the code is slightly
cleaner this way.

Acked-by: Paul Mackerras <paulus@samba.org>
