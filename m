Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 797B92C00FE
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Sep 2013 18:42:23 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 19 Sep 2013 18:42:22 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BCFA92BB0053
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Sep 2013 18:42:18 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8J8Pkgb2032076
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Sep 2013 18:25:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8J8gHvV019076
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Sep 2013 18:42:18 +1000
Message-ID: <523AB8B2.1060202@linux.vnet.ibm.com>
Date: Thu, 19 Sep 2013 14:11:22 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8][v4] powerpc/perf: Export Power7 memory hierarchy
 info to user space.
References: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1379119755-21025-9-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1379119755-21025-9-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2013 06:19 AM, Sukadev Bhattiprolu wrote:
> +static void power7_get_mem_data_src(union perf_mem_data_src *dsrc,
> +			struct pt_regs *regs)
> +{
> +	u64 idx;
> +	u64 mmcra = regs->dsisr;
> +	u64 addr;
> +	int ret;
> +	unsigned int instr;
> +
> +	if (mmcra & POWER7_MMCRA_DCACHE_MISS) {
> +		idx = mmcra & POWER7_MMCRA_DCACHE_SRC_MASK;
> +		idx >>= POWER7_MMCRA_DCACHE_SRC_SHIFT;
> +
> +		dsrc->val |= dcache_src_map[idx];
> +		return;
> +	}
> +
> +	instr = 0;
> +	addr = perf_instruction_pointer(regs);
> +
> +	if (is_kernel_addr(addr))
> +		instr = *(unsigned int *)addr;
> +	else {
> +		pagefault_disable();
> +		ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
> +		pagefault_enable();
> +		if (ret)
> +			instr = 0;
> +	}
> +	if (instr && instr_is_load_store(&instr))


Wondering if there is any possibility of getting positive values for
"(mmcra & POWER7_MMCRA_DCACHE_SRC_MASK) >> POWER7_MMCRA_DCACHE_SRC_SHIFT"
when the marked instruction did not have MMCRA[POWER7_MMCRA_DCACHE_MISS]
bit set. In that case we should actually compute dsrc->val as in the previous
case. I did couple of experiments on a P7 box, but was not able to find a
instance for a marked instruction whose MMCRA[POWER7_MMCRA_DCACHE_MISS] bit
not set and have a positive value POWER7_MMCRA_DCACHE_SRC field.
