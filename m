Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0050.outbound.protection.outlook.com [104.47.34.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xH1c94ZcszDqpc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 00:59:37 +1000 (AEST)
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
Subject: Re: [RFC Part1 PATCH v3 01/17] Documentation/x86: Add AMD Secure
 Encrypted Virtualization (SEV) descrption
To: Borislav Petkov <bp@suse.de>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-2-brijesh.singh@amd.com>
 <20170725054522.GA21822@nazgul.tnic>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <6273a2f0-151a-e8c2-6f4c-09d397446128@amd.com>
Date: Tue, 25 Jul 2017 09:59:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170725054522.GA21822@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/25/2017 12:45 AM, Borislav Petkov wrote:
> On Mon, Jul 24, 2017 at 02:07:41PM -0500, Brijesh Singh wrote:
> 
> Subject: Re: [RFC Part1 PATCH v3 01/17] Documentation/x86: Add AMD Secure Encrypted Virtualization (SEV) descrption
> 													 ^^^^^^^^^^
> 
> Please introduce a spellchecker into your workflow.
> 
>> Update amd-memory-encryption document describing the AMD Secure Encrypted
> 
> "Update the AMD memory encryption document...
> 
> The patch has the proper URL already.
> 
>> Virtualization (SEV) feature.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   Documentation/x86/amd-memory-encryption.txt | 29 ++++++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/x86/amd-memory-encryption.txt b/Documentation/x86/amd-memory-encryption.txt
>> index f512ab7..747df07 100644
>> --- a/Documentation/x86/amd-memory-encryption.txt
>> +++ b/Documentation/x86/amd-memory-encryption.txt
>> @@ -1,4 +1,5 @@
>> -Secure Memory Encryption (SME) is a feature found on AMD processors.
>> +Secure Memory Encryption (SME) and Secure Encrypted Virtualization (SEV) are
>> +features found on AMD processors.
>>   
>>   SME provides the ability to mark individual pages of memory as encrypted using
>>   the standard x86 page tables.  A page that is marked encrypted will be
>> @@ -6,6 +7,12 @@ automatically decrypted when read from DRAM and encrypted when written to
>>   DRAM.  SME can therefore be used to protect the contents of DRAM from physical
>>   attacks on the system.
>>   
>> +SEV enables running encrypted virtual machine (VMs) in which the code and data
> 
> 					 machines
> 
>> +of the virtual machine are secured so that decrypted version is available only
> 
> ... of the guest VM ...		  ... so that a decrypted ...
> 
>> +within the VM itself. SEV guest VMs have concept of private and shared memory.
> 
> 				 	have *the* concept - you need to use
> 					definite and indefinite articles in your
> 					text.
> 
>> +Private memory is encrypted with the guest-specific key, while shared memory
>> +may be encrypted with hypervisor key.
> 
> And here you explain that the hypervisor key is the same key which we
> use in SME. So that people can make the connection.
> 
>> +
>>   A page is encrypted when a page table entry has the encryption bit set (see
>>   below on how to determine its position).  The encryption bit can also be
>>   specified in the cr3 register, allowing the PGD table to be encrypted. Each
>> @@ -19,11 +26,20 @@ so that the PGD is encrypted, but not set the encryption bit in the PGD entry
>>   for a PUD which results in the PUD pointed to by that entry to not be
>>   encrypted.
>>   
>> -Support for SME can be determined through the CPUID instruction. The CPUID
>> -function 0x8000001f reports information related to SME:
>> +When SEV is enabled, certain type of memory (namely insruction pages and guest
> 
> When SEV is enabled, instruction pages and guest page tables are ...
> 
>> +page tables) are always treated as private. Due to security reasons all DMA
> 
> security reasons??
> 
>> +operations inside the guest must be performed on shared memory. Since the
>> +memory encryption bit is only controllable by the guest OS when it is operating
> 
> 		     ... is controlled ...
> 
>> +in 64-bit or 32-bit PAE mode, in all other modes the SEV hardware forces memory
> 
> 								... forces the memory ...
> 
>> +encryption bit to 1.
>> +
>> +Support for SME and SEV can be determined through the CPUID instruction. The
>> +CPUID function 0x8000001f reports information related to SME:
>>   
>>   	0x8000001f[eax]:
>>   		Bit[0] indicates support for SME
>> +	0x800001f[eax]:
> 
> There's a 0 missing and you don't really need it as it is already above.
> 
>> +		Bit[1] indicates support for SEV
>>   	0x8000001f[ebx]:
>>   		Bits[5:0]  pagetable bit number used to activate memory
>>   			   encryption
>> @@ -39,6 +55,13 @@ determine if SME is enabled and/or to enable memory encryption:
>>   		Bit[23]   0 = memory encryption features are disabled
>>   			  1 = memory encryption features are enabled
>>   
>> +If SEV is supported, MSR 0xc0010131 (MSR_F17H_SEV) can be used to determine if
> 
> If this MSR is going to be part of the architecture - and I really think
> it is - then call it MSR_AMD64_SEV.
> 

Thanks Boris, I'll update the doc per your feedbacks. And will rename the MSR to
MSR_AMD64_SEV.

-Brijesh
