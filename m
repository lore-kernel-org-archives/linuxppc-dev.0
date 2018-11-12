Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A947C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 12:03:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EE3223DD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 12:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EE3223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tqCb1jkdzF3XD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 23:03:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tq8G46k9zF3R0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 23:00:28 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75210B0AB9;
 Mon, 12 Nov 2018 12:00:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A35B10018F9;
 Mon, 12 Nov 2018 12:00:25 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <877ehnbwqy.fsf@oldenburg.str.redhat.com>
 <2d62c9e2-375b-2791-32ce-fdaa7e7664fd@intel.com>
 <87bm6zaa04.fsf@oldenburg.str.redhat.com>
 <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
 <20181109180947.GF5481@ram.oc3035372033.ibm.com>
Date: Mon, 12 Nov 2018 13:00:19 +0100
In-Reply-To: <20181109180947.GF5481@ram.oc3035372033.ibm.com> (Ram Pai's
 message of "Fri, 9 Nov 2018 10:09:47 -0800")
Message-ID: <87efbqqze4.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 12 Nov 2018 12:00:26 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Dave Hansen <dave.hansen@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Ram Pai:

> On Thu, Nov 08, 2018 at 09:23:35PM +0100, Florian Weimer wrote:
>> * Ram Pai:
>> 
>> > Florian,
>> >
>> > 	I can. But I am struggling to understand the requirement. Why is
>> > 	this needed?  Are we proposing a enhancement to the sys_pkey_alloc(),
>> > 	to be able to allocate keys that are initialied to disable-read
>> > 	only?
>> 
>> Yes, I think that would be a natural consequence.
>> 
>> However, my immediate need comes from the fact that the AMR register can
>> contain a flag combination that is not possible to represent with the
>> existing PKEY_DISABLE_WRITE and PKEY_DISABLE_ACCESS flags.  User code
>> could write to AMR directly, so I cannot rule out that certain flag
>> combinations exist there.
>> 
>> So I came up with this:
>> 
>> int
>> pkey_get (int key)
>> {
>>   if (key < 0 || key > PKEY_MAX)
>>     {
>>       __set_errno (EINVAL);
>>       return -1;
>>     }
>>   unsigned int index = pkey_index (key);
>>   unsigned long int amr = pkey_read ();
>>   unsigned int bits = (amr >> index) & 3;
>> 
>>   /* Translate from AMR values.  PKEY_AMR_READ standing alone is not
>>      currently representable.  */
>>   if (bits & PKEY_AMR_READ)
>
> this should be
>    if (bits & (PKEY_AMR_READ|PKEY_AMR_WRITE))

This would return zero for PKEY_AMR_READ alone.

>>     return PKEY_DISABLE_ACCESS;
>
>
>>   else if (bits == PKEY_AMR_WRITE)
>>     return PKEY_DISABLE_WRITE;
>>   return 0;
>> }

It's hard to tell whether PKEY_DISABLE_ACCESS is better in this case.
Which is why I want PKEY_DISABLE_READ.

>> And this is not ideal.  I would prefer something like this instead:
>> 
>>   switch (bits)
>>     {
>>       case PKEY_AMR_READ | PKEY_AMR_WRITE:
>>         return PKEY_DISABLE_ACCESS;
>>       case PKEY_AMR_READ:
>>         return PKEY_DISABLE_READ;
>>       case PKEY_AMR_WRITE:
>>         return PKEY_DISABLE_WRITE;
>>       case 0:
>>         return 0;
>>     }
>
> yes.
>  and on x86 it will be something like:
>    switch (bits)
>      {
>        case PKEY_PKRU_ACCESS :
>          return PKEY_DISABLE_ACCESS;
>        case PKEY_AMR_WRITE:
>          return PKEY_DISABLE_WRITE;
>        case 0:
>          return 0;
>      }

x86 returns the PKRU bits directly, including the nonsensical case
(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE).

> But for this to work, why do you need to enhance the sys_pkey_alloc()
> interface?  Not that I am against it. Trying to understand if the
> enhancement is really needed.

sys_pkey_alloc performs an implicit pkey_set for the newly allocated key
(that is, it updates the PKRU/AMR register).  It makes sense to match
the behavior of the userspace implementation.

Thanks,
Florian
