Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE6341A0C5D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 19:01:27 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so60726627pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 00:01:26 -0800 (PST)
Subject: Re: [PATCH v7 10/50] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-11-git-send-email-gwshan@linux.vnet.ibm.com>
 <87r3k4hx89.fsf@gamma.ozlabs.ibm.com> <20151105235218.GC30465@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56498D4E.7010009@ozlabs.ru>
Date: Mon, 16 Nov 2015 19:01:18 +1100
MIME-Version: 1.0
In-Reply-To: <20151105235218.GC30465@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2015 10:52 AM, Gavin Shan wrote:
> On Fri, Nov 06, 2015 at 09:56:06AM +1100, Daniel Axtens wrote:
>> Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>>
>>> The original implementation of pnv_ioda_setup_pe_seg() configures
>>> IO and M32 segments by separate logics, which can be merged by
>>> by caching @segmap, @seg_size, @win in advance. This shouldn't
>>> cause any behavioural changes.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 62 ++++++++++++++-----------------
>>>   1 file changed, 28 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index 7ee7cfe..553d3f3 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -2752,8 +2752,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>>   	struct pnv_phb *phb = hose->private_data;
>>>   	struct pci_bus_region region;
>>>   	struct resource *res;
>>> -	int i, index;
>>> -	int rc;
>>> +	unsigned int segsize;
>>> +	int *segmap, index, i;
>>> +	uint16_t win;
>>> +	int64_t rc;
>>
>> Good catch! Opal return codes are 64 bit and that should be explicit
>> in the type. However, I seem to remember that we preferred a different
>> type for 64 bit ints in the kernel. I think it's s64, and there are some
>> other uses of that in pci_ioda.c for return codes.
>>
>
> Both int64_t and s64 are fine. I used s64 for the OPAL return value, but
> Alexey likes "int64_t", which is ok to me as well. I won't change it back
> to s64 :-)
>
>> (I'm actually surprised that's not picked up as a compiler
>> warning. Maybe that's something to look at in future.)
>>
>
> Indeed, I didn't see a warning from gcc.
>
>> The rest of the patch looks good on casual inspection - to be sure I'll
>> test the entire series on a machine. (hopefully, time permitting!)
>>
>
> I run scripts/checkpatch.pl on the patchset. Only one warning came from
> [PATCH 44/50], but I won't bother to change that as the warning was
> brought by original code.

None of these patches failed checkpatch.pl check, what was the error in 44/50?




-- 
Alexey
