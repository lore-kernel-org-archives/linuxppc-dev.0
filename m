Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B35C1A096A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 02:20:46 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 15:20:43 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id CF2D41B08072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 15:21:02 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANFKeTv2228682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 15:20:40 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANFKduH023794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 08:20:40 -0700
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
To: Pratyush Anand <panand@redhat.com>, Mark Salter <msalter@redhat.com>,
 Ming Lei <ming.lei@canonical.com>
References: <1447838334.1564.2.camel@ellerman.id.au>
 <1447855399.3974.24.camel@redhat.com>
 <1447894964.15206.0.camel@ellerman.id.au>
 <20151119082325.GA11419@infradead.org>
 <1448021448.14769.7.camel@ellerman.id.au>
 <565055C6.5040801@linux.vnet.ibm.com> <20151122005635.1b9ffbe1@tom-T450>
 <1448234410.8209.3.camel@redhat.com> <56531B3F.60503@linux.vnet.ibm.com>
 <20151123151330.GA10990@dhcppc13.redhat.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 "James E. J. Bottomley" <JBottomley@odin.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 brking <brking@us.ibm.com>, tom.leiming@gmail.com,
 linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <56532EC7.3060000@linux.vnet.ibm.com>
Date: Mon, 23 Nov 2015 16:20:39 +0100
MIME-Version: 1.0
In-Reply-To: <20151123151330.GA10990@dhcppc13.redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/11/2015 16:13, Pratyush Anand wrote:
> On 23/11/2015:02:57:19 PM, Laurent Dufour wrote:
>> On 23/11/2015 00:20, Mark Salter wrote:
>>> On Sun, 2015-11-22 at 00:56 +0800, Ming Lei wrote:
>>>> On Sat, 21 Nov 2015 12:30:14 +0100
>>>> Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
>>>>
>>>>> On 20/11/2015 13:10, Michael Ellerman wrote:
>>>>>> On Thu, 2015-11-19 at 00:23 -0800, Christoph Hellwig wrote:
>>>>>>
>>>>>>> It's pretty much guaranteed a block layer bug, most likely in the
>>>>>>> merge bios to request infrastucture where we don't obey the merging
>>>>>>> limits properly.
>>>>>>>
>>>>>>> Does either of you have a known good and first known bad kernel?
>>>>>>
>>>>>> Not me, I've only hit it one or two times. All I can say is I have hit it in
>>>>>> 4.4-rc1.
>>>>>>
>>>>>> Laurent, can you narrow it down at all?
>>>>>
>>>>> It seems that the panic is triggered by the commit bdced438acd8 ("block:
>>>>> setup bi_phys_segments after splitting") which has been pulled by the
>>>>> merge d9734e0d1ccf ("Merge branch 'for-4.4/core' of
>>>>> git://git.kernel.dk/linux-block").
>>>>>
>>>>> My system is panicing promptly when running a kernel built at
>>>>> d9734e0d1ccf, while reverting the commit bdced438acd8, it can run hours
>>>>> without panicing.
>>>>>
>>>>> This being said, I can't explain what's going wrong.
>>>>>
>>>>> May Ming shed some light here ?
>>>>
>>>> Laurent, looks there is one bug in blk_bio_segment_split(), would you
>>>> mind testing the following patch to see if it fixes your issue?
>>>>
>>>> ---
>>>> From 6fc701231dcc000bc8bc4b9105583380d9aa31f4 Mon Sep 17 00:00:00 2001
>>>> From: Ming Lei <ming.lei@canonical.com>
>>>> Date: Sun, 22 Nov 2015 00:47:13 +0800
>>>> Subject: [PATCH] block: fix segment split
>>>>
>>>> Inside blk_bio_segment_split(), previous bvec pointer('bvprvp')
>>>> always points to the iterator local variable, which is obviously
>>>> wrong, so fix it by pointing to the local variable of 'b
> ~Pratyush
> 
vprv'.
>>>>
>>>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>>>> ---
>>>>  block/blk-merge.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>>>> index de5716d8..f2efe8a 100644
>>>> --- a/block/blk-merge.c
>>>> +++ b/block/blk-merge.c
>>>> @@ -98,7 +98,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>>>>  
>>>>  			seg_size += bv.bv_len;bdced438acd8
>>>>  			bvprv = bv;
>>>> -			bvprvp = &bv;
>>>> +			bvprvp = &bvprv;
>>>>  			sectors += bv.bv_len >> 9;
>>>>  			continue;
>>>>  		}
>>>> @@ -108,7 +108,7 @@ new_segment:
>>>>  
>>>>  		nsegs++;
>>>>  		bvprv = bv;
>>>> -		bvprvp = &bv;
>>>> +		bvprvp = &bvprv;
>>>>  		seg_size = bv.bv_len;
>>>>  		sectors += bv.bv_len >> 9;
>>>>  	}
>>>
>>> I'm still hitting the BUG even with this patch applied on top of 4.4-rc1.
>>
>> On my side, with the patch applied on top of 4.4-rc1, I can't get the
>> panic anymore.
> 
> git bisect shows:
> 
> bdced438acd83ad83a6c6fc7f50099b820245ddb is the first bad commit
> commit bdced438acd83ad83a6c6fc7f50099b820245ddb
> Author: Ming Lei <ming.lei@canonical.com>
> Date:   Tue Oct 20 23:13:52 2015 +0800 
> 
>     block: setup bi_phys_segments after splitting
> 
> Reverting above commit on top if 4.4-rc1 seems to fix the problem for me.

That's what I mentioned earlier ;)

Now Ming send an additional patch with seems to fix the bug introduced
through the commit bdced438acd8. When testing with this new patch I
can't get the panic anymore, but Mark reported he is still hitting it.
