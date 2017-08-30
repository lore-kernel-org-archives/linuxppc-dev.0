Return-Path: <brijesh.singh@amd.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0050.outbound.protection.outlook.com [104.47.36.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj9gC0NwFzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 02:19:00 +1000 (AEST)
Cc: brijesh.singh@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-efi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
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
Subject: Re: [RFC Part1 PATCH v3 16/17] X86/KVM: Provide support to create
 Guest and HV shared per-CPU variables
To: Borislav Petkov <bp@suse.de>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-17-brijesh.singh@amd.com>
 <20170829102258.gxk227js4yw47qi3@pd.tnic>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <0810a732-9c77-a543-ffeb-7fd2d8f46266@amd.com>
Date: Wed, 30 Aug 2017 11:18:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170829102258.gxk227js4yw47qi3@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Boris,

On 08/29/2017 05:22 AM, Borislav Petkov wrote:

[...]

> On Mon, Jul 24, 2017 at 02:07:56PM -0500, Brijesh Singh wrote:
>> Some KVM specific MSR's (steal-time, asyncpf, avic_eio) allocates per-CPU
> 
> 		   MSRs
> 
>> variable at compile time and share its physical address with hypervisor.
> 
> That sentence needs changing - the MSRs don't allocate - for them gets
> allocated.
> 
>> It presents a challege when SEV is active in guest OS, when SEV is active,
>> the guest memory is encrypted with guest key hence hypervisor will not
>> able to modify the guest memory. When SEV is active, we need to clear the
>> encryption attribute (aka C-bit) of shared physical addresses so that both
>> guest and hypervisor can access the data.
> 
> This whole paragraph needs rewriting.
> 

I will improve the commit message in next rev.

[...]

>> +/* NOTE: function is marked as __ref because it is used by __init functions */
> 
> No need for that comment.
> 
> What should you look into is why do you need to call the early versions:
> 
> " * producing a warning (of course, no warning does not mean code is
>   * correct, so optimally document why the __ref is needed and why it's OK)."
> 
> And we do have the normal set_memory_decrypted() etc helpers so why
> aren't we using those?
> 

Since kvm_guest_init() is called early in the boot process hence we will not
able to use set_memory_decrypted() function. IIRC, if we try calling
set_memory_decrypted() early then we will hit a BUG_ON [1] -- mainly when it
tries to flush the caches.

[1] http://elixir.free-electrons.com/linux/latest/source/arch/x86/mm/pageattr.c#L167



> If you need to use the early ones too, then you probably need to
> differentiate this in the callers by passing a "bool early", which calls
> the proper flavor.
> 

Sure I can rearrange code to make it more readable and use "bool early"
parameter to differentiate it.


>> +static int __ref kvm_map_hv_shared_decrypted(void)
>> +{
>> +	static int once, ret;
>> +	int cpu;
>> +
>> +	if (once)
>> +		return ret;
> 
> So this function gets called per-CPU but you need to do this ugly "once"
> thing - i.e., global function called in a per-CPU context.
> 
> Why can't you do that mapping only on the current CPU and then
> when that function is called on the next CPU, it will do the same thing
> on that next CPU?
> 


Yes, it can be done but I remember running into issues during the CPU hot plug.
The patch uses early_set_memory_decrypted() -- which calls
kernel_physical_mapping_init() to split the large pages into smaller. IIRC, the
API did not work after the system is successfully booted. After the system is
booted we must use the set_memory_decrypted().

I was trying to avoid mixing early and no-early set_memory_decrypted() but if
feedback is: use early_set_memory_decrypted() only if its required otherwise
use set_memory_decrypted() then I can improve the logic in next rev. thanks


[...]

>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index da0be9a..52854cf 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -783,6 +783,9 @@
>>   	. = ALIGN(cacheline);						\
>>   	*(.data..percpu)						\
>>   	*(.data..percpu..shared_aligned)				\
>> +	. = ALIGN(PAGE_SIZE);						\
>> +	*(.data..percpu..hv_shared)					\
>> +	. = ALIGN(PAGE_SIZE);						\
>>   	VMLINUX_SYMBOL(__per_cpu_end) = .;
> 
> Yeah, no, you can't do that. That's adding this section unconditionally
> on *every* arch. You need to do some ifdeffery like it is done at the
> beginning of that file and have this only on the arch which supports SEV.
> 


Will do . thanks

-Brijesh
