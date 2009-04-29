Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA219DDF4E
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 22:47:36 +1000 (EST)
Message-Id: <66D3881A-A16D-4051-9073-1FF28C4F4742@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20090429003704.1c37d6e1.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: bug in drivers/edac/mpc85xx_edac.c:mpc85xx_mc_check()
Date: Wed, 29 Apr 2009 07:46:37 -0500
References: <57AC2FA1761300418C7AB8F3EA493C9702E319DB@HQ-EXCH-5.corp.brocade.com>
	<20090429003704.1c37d6e1.akpm@linux-foundation.org>
Cc: Jeff Haran <jharan@Brocade.COM>, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, linuxppc-dev@ozlabs.org,
	Doug Thompson <dougthompson@xmission.com>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2009, at 2:37 AM, Andrew Morton wrote:

> Let's cc the suitable people.
>
> On Tue, 28 Apr 2009 18:23:42 -0700 "Jeff Haran" <jharan@Brocade.COM>  
> wrote:
>
>> Hi,
>>
>> Recent versions of this function contain the following snippets:
>>
>>    if (err_detect & DDR_EDE_SBE)
>>        edac_mc_handle_ce(mci, pfn, err_addr & PAGE_MASK,
>>                  syndrome, row_index, 0, mci->ctl_name);
>>
>>    if (err_detect & DDR_EDE_MBE)
>>        edac_mc_handle_ue(mci, pfn, err_addr & PAGE_MASK,
>>                  row_index, mci->ctl_name);
>>
>> I am pretty sure the references to PAGE_MASK should be proceeded by a
>> tilda, as in:
>>
>>    if (err_detect & DDR_EDE_SBE)
>>        edac_mc_handle_ce(mci, pfn, err_addr & ~PAGE_MASK,
>>                  syndrome, row_index, 0, mci->ctl_name);
>>
>>    if (err_detect & DDR_EDE_MBE)
>>        edac_mc_handle_ue(mci, pfn, err_addr & ~PAGE_MASK,
>>                  row_index, mci->ctl_name);
>>
>
> Could well be.  PAGE_MASK is very easy to get wrong.  I've _never_
> trusted my own memory of it and I always have to go back to the
> definition when reviewing code :(

This should ~PAGE_MASK to get the offset into the page.

>> Much as I would like to submit a tested patch like the rest of the
>> world, I find myself in the situation where the only Freescale target
>> system I have to test on is running a 3 year old kernel (2.6.14),  
>> which
>> preceeds the introduction of EDAC driver support, at least for
>> Freescale. So the best I can do is borrow from the new EDAC driver  
>> and
>> backport it to the old kernel.
>>
>> But I have learned a few things in this process and can thus share  
>> what
>> I've learned as it may be of help to the EDAC driver developers:
>>
>> 1) Before you read the Freescale 8548 CAPTURE_ADDRESS register, you  
>> want
>> to read CAPTURE_ATTRIBUTES first and make sure the VLD bit (least
>> significant bit in the register) is set or else the data in
>> CAPTURE_ADDRESS may not be yet valid.
>>
>> 2) When you are done scrubbing the memory with the single bit  
>> error, you
>> want to write 0 to CAPTURE_ATTRIBUTES so as to clear VLD and thus  
>> setup
>> the ECC capture logic to capture the next single bit error.

This is a correct description based on how FSL error HW works.

- k
