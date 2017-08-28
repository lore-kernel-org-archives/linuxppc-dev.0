Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0047.outbound.protection.outlook.com [104.47.33.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgqn929WyzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 21:49:32 +1000 (AEST)
Cc: brijesh.singh@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-efi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 David Howells <dhowells@redhat.com>, Matt Fleming
 <matt@codeblueprint.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Laura Abbott <labbott@redhat.com>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Airlie <airlied@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>
Subject: Re: [RFC Part1 PATCH v3 15/17] x86: Add support for changing memory
 encryption attribute in early boot
To: Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-16-brijesh.singh@amd.com>
 <20170828105119.xs73tinknqcmrgvk@pd.tnic>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4b3cec09-ab6a-0400-00fe-328b36564942@amd.com>
Date: Mon, 28 Aug 2017 06:49:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170828105119.xs73tinknqcmrgvk@pd.tnic>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Boris,


On 8/28/17 5:51 AM, Borislav Petkov wrote:

[..]

> +static int __init early_set_memory_enc_dec(resource_size_t paddr,
>> +					   unsigned long size, bool enc)
>> +{
>> +	unsigned long vaddr, vaddr_end, vaddr_next;
>> +	unsigned long psize, pmask;
>> +	int split_page_size_mask;
>> +	pte_t *kpte;
>> +	int level;
>> +
>> +	vaddr = (unsigned long)__va(paddr);
>> +	vaddr_next = vaddr;
>> +	vaddr_end = vaddr + size;
>> +
>> +	/*
>> +	 * We are going to change the physical page attribute from C=1 to C=0
>> +	 * or vice versa. Flush the caches to ensure that data is written into
>> +	 * memory with correct C-bit before we change attribute.
>> +	 */
>> +	clflush_cache_range(__va(paddr), size);
>> +
>> +	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
>> +		kpte = lookup_address(vaddr, &level);
>> +		if (!kpte || pte_none(*kpte))
>> +			return 1;
> Return before flushing TLBs? Perhaps you mean
>
> 			ret = 1;
> 			goto out;
>
> here and out does
>
> 	__flush_tlb_all();
> 	return ret;

thanks, good catch. I will fix in next rev.

-Brijesh
