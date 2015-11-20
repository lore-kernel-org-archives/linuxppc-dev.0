Return-Path: <hare@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 923731A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 01:55:20 +1100 (AEDT)
Message-ID: <564F3453.9040603@suse.de>
Date: Fri, 20 Nov 2015 15:55:15 +0100
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
To: emilne@redhat.com
CC: Christoph Hellwig <hch@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Mark Salter <msalter@redhat.com>,
 "James E. J. Bottomley" <JBottomley@odin.com>,
 brking <brking@us.ibm.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
References: <1447838334.1564.2.camel@ellerman.id.au>	
 <1447855399.3974.24.camel@redhat.com>	
 <1447894964.15206.0.camel@ellerman.id.au>	
 <20151119082325.GA11419@infradead.org> <564DEC41.5010600@suse.de>
 <1448030316.4067.18.camel@localhost.localdomain>
In-Reply-To: <1448030316.4067.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/20/2015 03:38 PM, Ewan Milne wrote:
> On Thu, 2015-11-19 at 16:35 +0100, Hannes Reinecke wrote:
>> On 11/19/2015 09:23 AM, Christoph Hellwig wrote:
>>> It's pretty much guaranteed a block layer bug, most likely in the
>>> merge bios to request infrastucture where we don't obey the merging
>>> limits properly.
>>>
>>> Does either of you have a known good and first known bad kernel?
>>
>> Well, I have been fighting a similar issue for several months now,
>> albeit with multipath enabled. Haven't had much progress with this,
>> sadly.
>> Seeing that this is our distro kernel it might or might not be
>> related; however, as the symptoms are identical there still is a
>> chance that this is actually a generic block-layer problem.
>>
>> Cheers,
>>
>> Hannes
> 
> We have seen this also.  (e.g.  req->nr_phys_segments was 3, but
> blk_rq_map_sg() returned 4.)  I was suspicious of the patch:
> 
> bio: modify __bio_add_page() to accept pages that don't start a new segment
> 
> But we put some debugging code in and didn't hit it.  We haven't
> found the problem yet, either, though.  We're still looking.
> 
Can't we have a joint effort here?
I've been spending a _LOT_ of time trying to debug things here, but
none of the ideas I've come up with have been able to fix anything.

I'm almost tempted to increase the count from scsi_alloc_sgtable()
by one and be done with ...

> As Christoph said, it would seem to be a problem with the block layer
> merging.
> 
> The API for this seems defective, in that blk_rq_map_sg() should
> never be returning a value indicating that it overwrote past the
> end of the supplied SG array and depend on the caller to check it.
> (We could get data corruption on another I/O if it used adjacent
> memory for a different SG list, for example.)
> 
Yeah, the API is bloody useless.
By the time you hit the BUG_ON you've already caused a memory
corruption, so no way you can recover there.

At the very least we should be passing in the sg list count into
blk_map_rq_sg(), but that's a core blocklayer API and changes here
would require changes by quite a set of drivers. Plus it wouldn't
help me for a distribution kernel ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
