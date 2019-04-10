Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E91C10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:55:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEBF2075B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 07:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEBF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fGg64YpqzDqN2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:55:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jasowang@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fGdD6vQwzDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 17:54:05 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CCA6C002965;
 Wed, 10 Apr 2019 07:54:03 +0000 (UTC)
Received: from [10.72.12.186] (ovpn-12-186.pek2.redhat.com [10.72.12.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2125419C72;
 Wed, 10 Apr 2019 07:53:53 +0000 (UTC)
Subject: Re: [PATCH net] vhost: flush dcache page when logging dirty pages
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190409041647.21269-1-jasowang@redhat.com>
 <20190409085607-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b635592f-a2c5-5687-e634-6fcd4f5a1e36@redhat.com>
Date: Wed, 10 Apr 2019 15:53:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409085607-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 10 Apr 2019 07:54:04 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 James Hogan <jhogan@kernel.org>, linux@armlinux.org.uk,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 2019/4/9 下午9:14, Michael S. Tsirkin wrote:
> On Tue, Apr 09, 2019 at 12:16:47PM +0800, Jason Wang wrote:
>> We set dirty bit through setting up kmaps and access them through
>> kernel virtual address, this may result alias in virtually tagged
>> caches that require a dcache flush afterwards.
>>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
> This is like saying "everyone with vhost needs this".
> In practice only might affect some architectures.


For the archs that does need dcache flushing, the function is just a nop.


> Which ones?


There're more than 10 archs that have ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 
defined, just cc some maintainers of some more influenced ones.


> You want to Cc the relevant maintainers
> who understand this...
>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> I am not sure this is a good idea.
> The region in question is supposed to be accessed
> by userspace at the same time, through atomic operations.
>
> How do we know userspace didn't access it just before?


get_user_pages() will do both flush_annon_page() to make sure the 
userspace write is visible to kernel.


>
> Is that an issue at all given we use
> atomics for access? Documentation/core-api/cachetlb.rst does
> not mention atomics.
> Which architectures are affected?
> Assuming atomics actually do need a flush, then don't we need
> a flush in the other direction too? How are atomics
> supposed to work at all?


It's the issue of visibility, atomic operation is just one of the 
possible operations. If we can finally makes the write visible to each 
other, there will be no issue.

It looks to me we could still end up alias if userspace is accessing the 
dirty log between get_user_pages_fast() and flush_dcache_page(). But the 
flush_dcache_page() can guarantee what kernel wrote is visible to 
userspace finally though some bits cleared by userspace might still 
there. We may end up with more dirty pages noticed by userspace which 
should be harmless.


>
>
> I really think we need new APIs along the lines of
> set_bit_to_user.


Can we simply do:

get_user()

set bit

put_user()

instead?


>
>> ---
>>   drivers/vhost/vhost.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 351af88231ad..34a1cedbc5ba 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -1711,6 +1711,7 @@ static int set_bit_to_user(int nr, void __user *addr)
>>   	base = kmap_atomic(page);
>>   	set_bit(bit, base);
>>   	kunmap_atomic(base);
>> +	flush_dcache_page(page);
>>   	set_page_dirty_lock(page);
>>   	put_page(page);
>>   	return 0;
> Ignoring the question of whether this actually helps, I doubt
> flush_dcache_page is appropriate here.  Pls take a look at
> Documentation/core-api/cachetlb.rst as well as the actual
> implementation.
>
> I think you meant flush_kernel_dcache_page, and IIUC it must happen
> before kunmap, not after (which you still have the va locked).


Looks like you're right.

Thanks


>
>> -- 
>> 2.19.1
