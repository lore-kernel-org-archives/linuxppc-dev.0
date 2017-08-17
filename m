Return-Path: <Thomas.Lendacky@amd.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0049.outbound.protection.outlook.com [104.47.42.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYFSx1ty4zDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 04:42:40 +1000 (AEST)
Subject: Re: [RFC Part1 PATCH v3 08/17] x86/efi: Access EFI data as encrypted
 when SEV is active
To: Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Piotr Luc <piotr.luc@intel.com>,
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
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-9-brijesh.singh@amd.com>
 <20170728103152.GE1889@nazgul.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9b56cea1-3338-8d75-e7ff-ecfa06046630@amd.com>
Date: Thu, 17 Aug 2017 13:42:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170728103152.GE1889@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/28/2017 5:31 AM, Borislav Petkov wrote:
> On Mon, Jul 24, 2017 at 02:07:48PM -0500, Brijesh Singh wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> EFI data is encrypted when the kernel is run under SEV. Update the
>> page table references to be sure the EFI memory areas are accessed
>> encrypted.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   arch/x86/platform/efi/efi_64.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
>> index 12e8388..1ecb3f6 100644
>> --- a/arch/x86/platform/efi/efi_64.c
>> +++ b/arch/x86/platform/efi/efi_64.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/reboot.h>
>>   #include <linux/slab.h>
>>   #include <linux/ucs2_string.h>
>> +#include <linux/mem_encrypt.h>
>>   
>>   #include <asm/setup.h>
>>   #include <asm/page.h>
>> @@ -369,7 +370,10 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
>>   	 * as trim_bios_range() will reserve the first page and isolate it away
>>   	 * from memory allocators anyway.
>>   	 */
>> -	if (kernel_map_pages_in_pgd(pgd, 0x0, 0x0, 1, _PAGE_RW)) {
>> +	pf = _PAGE_RW;
>> +	if (sev_active())
>> +		pf |= _PAGE_ENC;
> 
> \n here
> 
>> +	if (kernel_map_pages_in_pgd(pgd, 0x0, 0x0, 1, pf)) {
>>   		pr_err("Failed to create 1:1 mapping for the first page!\n");
>>   		return 1;
>>   	}
>> @@ -412,6 +416,9 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
>>   	if (!(md->attribute & EFI_MEMORY_WB))
>>   		flags |= _PAGE_PCD;
>>   
>> +	if (sev_active())
>> +		flags |= _PAGE_ENC;
>> +
>>   	pfn = md->phys_addr >> PAGE_SHIFT;
>>   	if (kernel_map_pages_in_pgd(pgd, pfn, va, md->num_pages, flags))
>>   		pr_warn("Error mapping PA 0x%llx -> VA 0x%llx!\n",
>> @@ -511,6 +518,9 @@ static int __init efi_update_mappings(efi_memory_desc_t *md, unsigned long pf)
>>   	pgd_t *pgd = efi_pgd;
>>   	int err1, err2;
>>   
>> +	if (sev_active())
>> +		pf |= _PAGE_ENC;
> 
> Move this assignment to the caller efi_update_mem_attr() where pf is being
> set...

Will do.

> 
>> +
>>   	/* Update the 1:1 mapping */
>>   	pfn = md->phys_addr >> PAGE_SHIFT;
>>   	err1 = kernel_map_pages_in_pgd(pgd, pfn, md->phys_addr, md->num_pages, pf);
>> @@ -589,6 +599,9 @@ void __init efi_runtime_update_mappings(void)
>>   			(md->type != EFI_RUNTIME_SERVICES_CODE))
>>   			pf |= _PAGE_RW;
>>   
>> +		if (sev_active())
>> +			pf |= _PAGE_ENC;
> 
> ... just like here.

Yup.

Thanks,
Tom

> 
>> +
>>   		efi_update_mappings(md, pf);
> 
> In general, I'm not totally excited about that sprinkling of if
> (sev_active())... :-\
> 
