Return-Path: <Thomas.Lendacky@amd.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0062.outbound.protection.outlook.com [104.47.34.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYFxF6MWlzDrLP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 05:03:45 +1000 (AEST)
Subject: Re: [RFC Part1 PATCH v3 09/17] resource: Consolidate resource walking
 code
From: Tom Lendacky <thomas.lendacky@amd.com>
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
 <20170724190757.11278-10-brijesh.singh@amd.com>
 <20170728152342.GB11564@nazgul.tnic>
 <a31c9643-87a5-ae4a-25a5-9dae235f158d@amd.com>
Message-ID: <029b17ab-00c4-c845-d39f-1b3337e296b1@amd.com>
Date: Thu, 17 Aug 2017 14:03:30 -0500
MIME-Version: 1.0
In-Reply-To: <a31c9643-87a5-ae4a-25a5-9dae235f158d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/17/2017 1:55 PM, Tom Lendacky wrote:
> On 7/28/2017 10:23 AM, Borislav Petkov wrote:
>> On Mon, Jul 24, 2017 at 02:07:49PM -0500, Brijesh Singh wrote:
>>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>>
>>> The walk_iomem_res_desc(), walk_system_ram_res() and 
>>> walk_system_ram_range()
>>> functions each have much of the same code.  Create a new function that
>>> consolidates the common code from these functions in one place to reduce
>>> the amount of duplicated code.
>>>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> ---
>>>   kernel/resource.c | 53 
>>> ++++++++++++++++++++++++++---------------------------
>>>   1 file changed, 26 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/kernel/resource.c b/kernel/resource.c
>>> index 9b5f044..7b20b3e 100644
>>> --- a/kernel/resource.c
>>> +++ b/kernel/resource.c
>>> @@ -397,9 +397,30 @@ static int find_next_iomem_res(struct resource 
>>> *res, unsigned long desc,
>>>           res->start = p->start;
>>>       if (res->end > p->end)
>>>           res->end = p->end;
>>> +    res->desc = p->desc;
>>>       return 0;
>>
>> I must be going blind: where are we using that res->desc?
> 
> I think that was left-over from the initial consolidation work I was
> doing.  I'll remove it.

I spoke too soon...  I use it in a later patch as part of a callback.
But instead of putting it here, I'll add it to the patch that actually
needs it.

Thanks,
Tom

> 
>>
>>> +static int __walk_iomem_res_desc(struct resource *res, unsigned long 
>>> desc,
>>> +                 bool first_level_children_only,
>>
>> Btw, that variable name is insanely long.
> 
> I know, but I'm maintaining consistency with the name that was already
> present vs. changing it.
> 
>>
>> The rest looks ok to me, thanks for the cleanup!
> 
> Thanks,
> Tom
> 
>>
