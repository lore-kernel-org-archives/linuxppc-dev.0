Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8748FB6F8C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 19:36:36 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by e28smtp01.in.ibm.com (8.14.4/8.13.1) with ESMTP id pA48aV94021134
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2011 14:06:31 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA48aUbt2813986
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2011 14:06:31 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA48aUIA016720
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2011 14:06:30 +0530
Message-ID: <4EB3A40C.1070802@in.ibm.com>
Date: Fri, 04 Nov 2011 14:06:28 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
 <20111025115354.8183.48237.stgit@suzukikp.in.ibm.com>
 <1320276969.3309.3.camel@treble>
In-Reply-To: <1320276969.3309.3.camel@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Nathan Miller <nathanm2@us.ibm.com>, Josh Poimboeuf <jpoimboe@us.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/03/11 05:06, Josh Poimboeuf wrote:
> On Tue, 2011-10-25 at 17:23 +0530, Suzuki K. Poulose wrote:
>> The following patch implements the dynamic relocation processing for
>> PPC32 kernel. relocate() accepts the target virtual address and relocates
>>   the kernel image to the same.
>
> Hi Suzuki,
>
> Thanks for the patches.  I've been testing them on a 440-based card, and
> encountered TLB error exceptions because the BSS section wasn't getting
> properly cleared in early_init().

Thanks a lot for the testing.
>
> It turns out that some of the instructions which were modified in
> relocate() weren't then getting flushed out of the d-cache into memory.
> After that, early_init() executed the stale (non-modified) instructions
> for the BSS area.  Those instructions just accessed offset 0 instead of
> the actual BSS-related offsets.  That resulted in BSS not getting`
> zeroed.
>
> I was able to verify this on my 440 by comparing the d-cache and i-cache
> entries for the BSS-accessing instructions in early_init() using a
> RISCWatch.  As I suspected, the instructions in the d-cache showed the
> corrected offsets, but the i-cache showed the old, non-relocated
> offsets.
>
> To fix the issue, I wrote the following patch, applied on top of your
> patches.  Suggestions and comments are welcome.
>
>
>
>  From c88ae39da0c0352f411aca8d9636990a442d47da Mon Sep 17 00:00:00 2001
> From: Josh Poimboeuf<jpoimboe@linux.vnet.ibm.com>
> Date: Wed, 2 Nov 2011 16:41:24 -0500
> Subject: [PATCH] Flush relocated instructions from data cache
>
> After updating instructions with relocated addresses, flush them from
> the data cache and invalidate the icache line so we don't execute stale
> instructions.
>
> Signed-off-by: Josh Poimboeuf<jpoimboe@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/reloc_32.S |   11 ++++++++++-
>   1 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/reloc_32.S
> b/arch/powerpc/kernel/reloc_32.S
> index 045d61e..a92857d 100644
> --- a/arch/powerpc/kernel/reloc_32.S
> +++ b/arch/powerpc/kernel/reloc_32.S
> @@ -137,6 +137,9 @@ get_type:
>   	lwz	r0, 8(r9)	/* r_addend */
>   	add	r0, r0, r3	/* final addend */
>   	stwx	r0, r4, r7	/* memory[r4+r7]) = (u32)r0 */
> +	dcbst	r4,r7		/* flush dcache line to memory */
> +	sync			/* wait for flush to complete */
> +	icbi	r4,r7		/* invalidate icache line */

Doing it this way has two drawbacks :

1) Placing it here in relocate would do the flushing for each and every update.
2) I would like to keep this code as generic as possible for the PPC32 code.

Could we move this to the place from relocate is called and flush the d-cache and
i-cache entirely ?

Thanks

Suzuki
