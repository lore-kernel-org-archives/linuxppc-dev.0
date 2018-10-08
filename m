Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0629AC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 10:20:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4BD2064E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 10:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4BD2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TGZq6jVBzDqVD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 21:20:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TGXl4TVWzF3Bh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 21:18:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42TGXl1KDCz9sCV;
 Mon,  8 Oct 2018 21:18:31 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Serhii Popovych <spopovyc@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH kernel] vfio/spapr_tce: Get rid of possible infinite
 loop
In-Reply-To: <74ee5fc5-839b-27d6-5731-1b2731f9f95b@redhat.com>
References: <20181002032231.7494-1-aik@ozlabs.ru>
 <74ee5fc5-839b-27d6-5731-1b2731f9f95b@redhat.com>
Date: Mon, 08 Oct 2018 21:18:27 +1100
Message-ID: <87sh1g213g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Serhii Popovych <spopovyc@redhat.com> writes:
> Alexey Kardashevskiy wrote:
>> As a part of cleanup, the SPAPR TCE IOMMU subdriver releases preregistered
>> memory. If there is a bug in memory release, the loop in
>> tce_iommu_release() becomes infinite; this actually happened to me.
>> 
>> This makes the loop finite and prints a warning on every failure to make
>> the code more bug prone.
>> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  drivers/vfio/vfio_iommu_spapr_tce.c | 10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index b1a8ab3..ece0651 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -393,13 +394,8 @@ static void tce_iommu_release(void *iommu_data)
>>  		tce_iommu_free_table(container, tbl);
>>  	}
>>  
>> -	while (!list_empty(&container->prereg_list)) {
>> -		struct tce_iommu_prereg *tcemem;
>> -
>> -		tcemem = list_first_entry(&container->prereg_list,
>> -				struct tce_iommu_prereg, next);
>> -		WARN_ON_ONCE(tce_iommu_prereg_free(container, tcemem));
>> -	}
>> +	list_for_each_entry_safe(tcemem, tmtmp, &container->prereg_list, next)
>> +		WARN_ON(tce_iommu_prereg_free(container, tcemem));
>
> I'm not sure that tce_iommu_prereg_free() call under WARN_ON() is good
> idea because WARN_ON() is a preprocessor macro:
>
>   if CONFIG_WARN=n is added by the analogy with CONFIG_BUG=n defining
>   WARN_ON() as empty we will loose call to tce_iommu_prereg_free()
>   leaking resources.

I don't think that's likely to ever happen though, we have a large
number of uses that would need to be checked one-by-one:

  $ git grep "if (WARN_ON(" | wc -l
  2853


So if we ever did add CONFIG_WARN, I think it would still need to
evaluate the condition, just not emit a warning.

cheers
