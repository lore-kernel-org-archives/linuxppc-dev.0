Return-Path: <michael@ellerman.id.au>
Date: Mon, 22 Apr 2013 09:41:10 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/5] powerpc, perf: Add new BHRB related instructions
 for POWER8
Message-ID: <20130421234109.GC22246@concordia>
References: <1366287976-3900-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1366287976-3900-2-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366287976-3900-2-git-send-email-khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 18, 2013 at 05:56:12PM +0530, Anshuman Khandual wrote:
> This patch adds new POWER8 instruction encoding for reading
> the BHRB buffer entries and also clearing it. Encoding for
> "clrbhrb" instruction is straight forward.

Which is "clear branch history rolling buffer" ?

> But "mfbhrbe"
> encoding involves reading a certain index of BHRB buffer
> into a particular GPR register.

And "Move from branch history rolling buffer entry" ?

> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 8752bc8..93ae5a1 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -82,6 +82,7 @@
>  #define	__REGA0_R31	31
>  
>  /* sorted alphabetically */
> +#define PPC_INST_BHRBE			0x7c00025c

I don't think you really need this, just use the literal value below.

> @@ -297,6 +298,12 @@
>  #define PPC_NAP			stringify_in_c(.long PPC_INST_NAP)
>  #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
>  
> +/* BHRB instructions */
> +#define PPC_CLRBHRB		stringify_in_c(.long 0x7c00035c)
> +#define PPC_MFBHRBE(r, n)	stringify_in_c(.long PPC_INST_BHRBE | \
> +						__PPC_RS(r) | \
> +							(((n) & 0x1f) << 11))

Why are you not using ___PPC_RB(n) here ?

cheers
