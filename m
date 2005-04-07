Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 695ED67B1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 02:19:37 +1000 (EST)
Date: Thu, 7 Apr 2005 09:19:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Message-ID: <20050407161935.GM3396@smtp.west.cox.net>
References: <JPEALJAFNGDDLOPNDIEEGEGJDCAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <JPEALJAFNGDDLOPNDIEEGEGJDCAA.joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] [RFC] workaround buggy dcbX instructions in 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2005 at 05:22:57PM +0200, Joakim Tjernlund wrote:

> All cache instructions in 8xx are somewhat buggy as they
> do not update the DAR register when causing a DTLB Miss/Error
[snip]
> ===== head_8xx.S 1.21 vs edited =====
[snip]
> +#define CONFIG_8xx_DCBxFIXED

If this is configurable, it needs to be done in the Kconfig like, well a
real config option.  The arguement for doing it as a config option is
that it is possible to avoid these instructions in userland (I _think_
with a properly configured gcc, all you need to do is remove the
memset.S file from glibc), and avoid the (theoretical) slow-down.

That said, it should also probably be an 'advanced' option that defaults
to the fixup.

[snip]
> +#ifdef CONFIG_8xx_DCBxFIXED
> +/* These macros are used to tag DAR with a known value so that the
> + * DataTLBError can recognize a buggy dcbx instruction and workaround
> + * the problem.
> + */
> +#define TAG_VAL 0x00f0	/*  -1 may also be used */

Is there an advantage of using -1?  If it just "or we could use",
perhaps we should just comment about it, and always define TAG_VAL to
0x00f0 (which will make the rest of the patch a bit cleaner).

[snip]
> +#ifdef CONFIG_8xx_DCBxFIXED
> +/* This is the workaround procedure to calculate the data EA for buggy dcbx,dcbi instructions
> + * by decoding the registers used by the dcbx instruction and adding them.
> + * DAR is set to the calculated address and r10 also holds the EA on exit.
> + */
> +//#define INSTR_CHECK /* define to verify if it is a dcbx instr. Should not be needed. */
> +//#define NO_SELF_MODIFYING_CODE /* define if you don't want to use self modifying code */
> +//#define DEBUG_DCBX_INSTRUCTIONS /* for debugging only. Needs INSTR_CHECK defined as well. */
> +//#define KERNEL_SPACE_ONLY /* define if user space do NOT contain dcbx instructions. */

Aside from preferring #undef FOO to /* #define FOO *//* Comment */ and
detesting // comments:
- Perhaps just one debug symbol (combine INSTR_CHECK and
  DEBUG_DCBX_INSTRUCTIONS).
- Is there (aside from "eww, self modifying code") a good reason to have
  NO_SELF_MODIFYING_CODE ?
- Since today, IIRC, we avoid these instructions in the kernel anyhow,
  is there a reason for KERNEL_SPACE_ONLY ?  In my mind at least, I
  could see a why for userspace-only, but would think an all/nothing
  approach is probably most sane (if you can avoid in space A why not
  B?).

-- 
Tom Rini
http://gate.crashing.org/~trini/
