Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE76A2C00D2
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Sep 2013 08:30:33 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 24 Sep 2013 18:30:31 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 27C4738C8042
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Sep 2013 18:30:28 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8OMUSgI64815280
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Sep 2013 22:30:28 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8OMURXC008225
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Sep 2013 19:30:28 -0300
Date: Tue, 24 Sep 2013 15:30:18 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8][v4] powerpc/perf: Export Power7 memory hierarchy
 info to user space.
Message-ID: <20130924223018.GA21644@us.ibm.com>
References: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1379119755-21025-9-git-send-email-sukadev@linux.vnet.ibm.com>
 <523AB8B2.1060202@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <523AB8B2.1060202@linux.vnet.ibm.com>
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

Anshuman Khandual [khandual@linux.vnet.ibm.com] wrote:
| On 09/14/2013 06:19 AM, Sukadev Bhattiprolu wrote:
| > +static void power7_get_mem_data_src(union perf_mem_data_src *dsrc,
| > +			struct pt_regs *regs)
| > +{
| > +	u64 idx;
| > +	u64 mmcra = regs->dsisr;
| > +	u64 addr;
| > +	int ret;
| > +	unsigned int instr;
| > +
| > +	if (mmcra & POWER7_MMCRA_DCACHE_MISS) {
| > +		idx = mmcra & POWER7_MMCRA_DCACHE_SRC_MASK;
| > +		idx >>= POWER7_MMCRA_DCACHE_SRC_SHIFT;
| > +
| > +		dsrc->val |= dcache_src_map[idx];
| > +		return;
| > +	}
| > +
| > +	instr = 0;
| > +	addr = perf_instruction_pointer(regs);
| > +
| > +	if (is_kernel_addr(addr))
| > +		instr = *(unsigned int *)addr;
| > +	else {
| > +		pagefault_disable();
| > +		ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
| > +		pagefault_enable();
| > +		if (ret)
| > +			instr = 0;
| > +	}
| > +	if (instr && instr_is_load_store(&instr))
| 
| 
| Wondering if there is any possibility of getting positive values for
| "(mmcra & POWER7_MMCRA_DCACHE_SRC_MASK) >> POWER7_MMCRA_DCACHE_SRC_SHIFT"
| when the marked instruction did not have MMCRA[POWER7_MMCRA_DCACHE_MISS]
| bit set. In that case we should actually compute dsrc->val as in the previous
| case. I did couple of experiments on a P7 box, but was not able to find a
| instance for a marked instruction whose MMCRA[POWER7_MMCRA_DCACHE_MISS] bit
| not set and have a positive value POWER7_MMCRA_DCACHE_SRC field.

Confirmed again with the hardware team that if there was no DCACHE_MISS,
the DCACHE_SRC field will be clear.

Thanks,

Sukadev
