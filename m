Return-Path: <brking@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 320BA1A026E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 00:12:55 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 13 May 2015 10:12:53 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 41680C90045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 10:03:58 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4DECoRp64094284
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 14:12:50 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4DECngO031783
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 10:12:50 -0400
Message-ID: <55535BDF.6020502@linux.vnet.ibm.com>
Date: Wed, 13 May 2015 09:12:47 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mpt2sas: Fall back to 64 bit coherent mask if 64 bit
 DMA / 32 bit coherent mask not supported
References: <555279A8.6060906@linux.vnet.ibm.com> <2214146.EzgWBA6g23@wuerfel>
 <5553505D.50102@linux.vnet.ibm.com> <10045033.4fV0qQU90u@wuerfel>
In-Reply-To: <10045033.4fV0qQU90u@wuerfel>
Content-Type: text/plain; charset=windows-1252
Cc: Daniel Kreling <kreling@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Sreekanth Reddy <sreekanth.reddy@avagotech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/13/2015 08:31 AM, Arnd Bergmann wrote:
> On Wednesday 13 May 2015 08:23:41 Brian King wrote:
>> On 05/13/2015 03:10 AM, Arnd Bergmann wrote:
>>> On Tuesday 12 May 2015 18:24:43 Brian King wrote:
>>>>
>>>> Commit 5fb1bf8aaa832e1e9ca3198de7bbecb8eff7db9c broke 64 bit DMA for mpt2sas on Power.
>>>> That commit changed the sequence for setting up the DMA and coherent DMA masks so
>>>> that during initialization the driver requests a 64 bit DMA mask and a 32 bit consistent
>>>> DMA mask, then later requests a 64 bit consistent DMA mask. The Power architecture does
>>>> not currently support this, which results in always falling back to a 32 bit DMA window,
>>>> which has a negative impact on performance. Tweak this algorithm slightly so that
>>>> if requesting a 32 bit consistent mask fails after we've successfully set a 64 bit
>>>> DMA mask, just try to get a 64 bit consistent mask. This should preserve existing
>>>> behavior on platforms that support mixed mask setting and restore previous functionality
>>>> to those that do not.
>>>>
>>>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>>>
>>> I believe the way the API is designed, it should guarantee that after dma_set_mask()
>>> succeeds for a device, dma_set_coherent_mask() with the same mask will also succeed.
>>>
>>> Could you just call dma_set_mask_and_coherent() here to avoid that complex logic?
>>
>> I don't think that would work. The mpt2sas driver wants to set the dma mask to 64bits
>> but set the coherent mask to 32 bits, then my change is to set the coherent mask to
>> 64bits if setting it to 32bit fails. I'm not seeing how using dma_set_mask_and_coherent
>> would simplify anything here.
> 
> My question was more about why the driver would ask for a 32-bit coherent
> mask to start with. Is this a limitation in the mpt2sas device that can
> only have descriptors at low addresses, or is it trying to work around some
> bug in a particular host system?

I'll need help from Sreekanth in answering that. All that is in the git commit log is:

    2. Initially set the consistent DMA mask to 32 bit and then change it to 64 bit mask
    after allocating RDPQ pools by calling the function _base_change_consistent_dma_mask.
    This is to ensure that all the upper 32 bits of RDPQ entries's base address to be same.

So, I'm not sure my patch won't break something with mpt2sas... This commit also changed
how the RDPO pools are allocated, so its possible this won't work. However, I did load
it on Power box and I'm not seeing any major problems so far. I am seeing the following message
get logged on a regular basis, not sure if its related to this change or not:

mpt2sas3: log_info(0x31120303): originator(IOP), code(0x03), sub_code(0x3112)

-Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
