Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729F606A31F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=AbVyf0EC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8BCX3mN5z2xwL;
	Tue, 20 Oct 2026 23:13:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792498424;
	cv=none; b=XBs57YuLXJLyq7Wi36wPzEAQy+R+Jsz/n7s8vd+MSLsmb3t4D3GLq7YNcJo2pgwBxou295cAuN2Jfg7YyWudCpEaol2S2r3n5ssiA05x8SmHlbC4JxE8cncEel81kJXctzVIrS5dQYqlm/MwVyYJhFUda6xQbC7p/Z63R6fbTaviNzw+H3dWWp7foB+Iy2G65IFa6n6Qsbq9yWW7sfUBk+XTHVXcd8UQFxwj32bBVKxjNiIcHBGLdNQjRdoiq86U6FX3HuU80fmCYMlKgx6mqeKgcFxbH/1UsosKB/o9pOHje8lHznjH4kV1x6BmWKDIyDiWeScYh3T6J5MU53AtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792498424; c=relaxed/relaxed;
	bh=tW+jOFa0bAPRo5ob6iKpdpiylE+QgPpSwSf2SsyL4p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KheXPk8UaUy50c5YfGwKzqAI7hUKEXiqNM3DR2przy0XTTuRKx9F1KbjWiczzHBtl3wJlty9uCxMET7csbBKykS5AZ7rAWSy/kVa4DYQcAdPssEz6EoIOjKbI0vqz/UzFdM5ZtXwkpd/v1OoWfhkhUEzxiTPaF9Ukwrg9ha8vCmAGUmBPZixb5FCqg8ZEslL4qBtZoWP44iWGjoJ8C/dEwgusfsVxtUT5tLJPlCHRi7ivNXX+2+2qNs0UqWMA4aKaVM3ElZiLO0LZB+spNrdpX1ricFGFJGWYFUzlPsfBHXR7LbzH1BO4LJoTr3XRXxqYKM/N3LEl72d6dPQIX2lMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; dkim=pass (2048-bit key; unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=AbVyf0EC; dkim-atps=neutral; spf=pass (client-ip=35.89.44.35; helo=omta36.uswest2.a.cloudfilter.net; envelope-from=gustavo@embeddedor.com; receiver=lists.ozlabs.org) smtp.mailfrom=embeddedor.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=AbVyf0EC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=embeddedor.com (client-ip=35.89.44.35; helo=omta36.uswest2.a.cloudfilter.net; envelope-from=gustavo@embeddedor.com; receiver=lists.ozlabs.org)
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8BCS5j3Kz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 23:13:38 +1100 (AEDT)
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id IxGuxHqlJusRSJ8hIx342x; Tue, 20 Oct 2026 12:12:04 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id J8hGxPrFtFB8dJ8hHxZXnq; Tue, 20 Oct 2026 12:12:03 +0000
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=6ad75a93
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7T7KSl7uo7wA:10 a=9AdMxfjQAAAA:20
 a=FmNn6hfUth-HS78a2iwA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
 a=bA3UWDv6hWIuX7UZL3qL:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=tW+jOFa0bAPRo5ob6iKpdpiylE+QgPpSwSf2SsyL4p0=; b=AbVyf0ECm4W7
	tIKrNrtOl/QoYsbOfllsmecnIpcjx7XMr0JAxyB0D+8FDXSGxp9sUKHssuTqvu7XcoD4dB/n4VehD
	/UUqQg+lcKsgGHanroZ2XiCNePZ8hhEwdk8luTpo1DS6wxPLrg4LXCRsnSb5WCP5/TFD8vQjXwC11
	XWXs99OZmjcQwjkbqNOoDrylTUpO3h51NGLxYvVEiorCHen2gqpxsclFYkEz1d/dLC80Cj849335X
	90/z1TZIUUo5BneulKzuw3La3huIen69cHvLQ+5Xwra8BE0RvlEV1scU8zv3JcG5bxGiNKNzbHYIn
	3Ly49No4/31RKSSWVNooQA==;
Received: from [1.234.115.197] (port=33036)
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1xJ8hE-00000000wsV-45S0;
	Tue, 20 Oct 2026 07:12:01 -0500
Message-ID: <6cf42177-5c35-49b8-9e4b-36a4d28aa26e@embeddedor.com>
Date: Tue, 20 Oct 2026 21:11:47 +0900
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/kexec: Annotate umem_info members with
 __counted_by_ptr
To: Thorsten Blum <blum@kernel.org>, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aditya Gupta <adityag@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260730130248.597249-2-thorsten.blum@linux.dev>
 <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>
 <asDClaRrHuKB44X-@kernel.org>
 <dbb4580d-7e20-4c38-9716-f39cf81a4942@linux.ibm.com>
 <asNfSSp-AckyeO7P@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <asNfSSp-AckyeO7P@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 1.234.115.197
X-Source-L: No
X-Exim-ID: 1xJ8hE-00000000wsV-45S0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([1.234.115.197]) [1.234.115.197]:33036
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIM6ietuiZfvD8bdfYbb/95/qJJDUYy8MdSj2v0LpHVFV3D0iZFz2qgeWtvt16NVwShMiHd8ZpreEq1h8mOnWRCMxRSDq0D/1yVv+sxHLqZ0tq3YD+9G
 3Hr4C/yitGzyjRqx+/AoQMDAWSSOll1C7jsI8mxzmfmsFc88Q1IcY7lP/948SWi/atXjx1MJaLM3vsgLRfDiXU+geSw2a7zXKcd6Yy0SyOb7nqEmQtsfrqjI
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/5/26 17:26, Thorsten Blum wrote:
> On Mon, Oct 05, 2026 at 01:42:01PM +0530, Sourabh Jain wrote:
>> On 03/10/26 14:23, Thorsten Blum wrote:
>>> On Fri, Sep 25, 2026 at 11:49:04AM +0530, Sourabh Jain wrote:
>>>> On 30/07/26 18:32, Thorsten Blum wrote:
>>>>> Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
>>>>> improve access bounds checking via CONFIG_UBSAN_BOUNDS and
>>>>> CONFIG_FORTIFY_SOURCE.
>>>>>
>>>>> Set the count fields before assigning the corresponding pointers, return
>>>>> early on krealloc() failure, and use sizeof(*buf) when deriving
>>>>> max_entries from the allocation size.
>>>>>
>>>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>>>> ---
>>>>>     arch/powerpc/kexec/file_load_64.c | 22 ++++++++++++----------
>>>>>     1 file changed, 12 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>>>>> index 8c72e12ea44e..6424b668f0e9 100644
>>>>> --- a/arch/powerpc/kexec/file_load_64.c
>>>>> +++ b/arch/powerpc/kexec/file_load_64.c
>>>>> @@ -34,14 +34,15 @@
>>>>>     #include <asm/cputhreads.h>
>>>>>     struct umem_info {
>>>>> -	__be64 *buf;		/* data buffer for usable-memory property */
>>>>> +	/* data buffer for usable-memory property */
>>>>> +	__be64 *buf __counted_by_ptr(max_entries);
>>>>>     	u32 size;		/* size allocated for the data buffer */
>>>>>     	u32 max_entries;	/* maximum no. of entries */
>>>>>     	u32 idx;		/* index of current entry */
>>>>>     	/* usable memory ranges to look up */
>>>>>     	unsigned int nr_ranges;
>>>>> -	const struct range *ranges;
>>>>> +	const struct range *ranges __counted_by_ptr(nr_ranges);
>>>>>     };
>>>> [...]
>>>>>     const struct kexec_file_ops * const kexec_file_loaders[] = {
>>>>> @@ -83,11 +84,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
>>>>>     	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
>>>>>     	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
>>>>> -	if (tbuf) {
>>>>> -		um_info->buf = tbuf;
>>>>> -		um_info->size = new_size;
>>>>> -		um_info->max_entries = (um_info->size / sizeof(u64));
>>>>> -	}
>>>>> +	if (!tbuf)
>>>>> +		return NULL;
>>>>> +
>>>>> +	um_info->size = new_size;
>>>>> +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
>>>>> +	um_info->buf = tbuf;
>>>>
>>>> Could you please explain why size and max_entries are updated before the
>>>> buffer itself?
>>> __counted_by_ptr() requires the counter ->max_entries to be set before
>>> the ->buf pointer is assigned; otherwise you have an inconsistent state
>>> where the counter doesn't match the pointer.
>>
>> But isn't updating the counter holding the buffer size before the actual
>> buffer
>> can cause problems?
>>
>> Can you share the document link of __counted_by_ptr() which says that size
>> counter to be
>> updated before the buffer pointer.
>>
>> Here is an example in fs/coredump.c file where size counter is updated after
>> the buffer
>> with __counter_by_ptr():
>>
>> https://github.com/torvalds/linux/blob/a90ee4305c4a5df72c11b31dacfdc76e00fcf78a/fs/coredump.c#L98
>> https://github.com/torvalds/linux/blob/a90ee4305c4a5df72c11b31dacfdc76e00fcf78a/fs/coredump.c#L115
> 
> Maybe the order only matters for flexible arrays and __counted_by(), but
> not for __counted_by_ptr(). I reordered it mostly out of habit from
> __counted_by() annotations and assumed the same rules apply for
> __counted_by_ptr(). Happy to restore the old order if it's not required.
> 
> Kees or Gustavo, what's your take on this?

The order matters when dereferencing the pointer. In this case, it's just
an assignment.

Thanks
-Gustavo



