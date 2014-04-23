Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C06F3140104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 14:36:59 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 23 Apr 2014 14:36:57 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A50B02BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 14:36:54 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3N4G1GH53149860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 14:16:02 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3N4arX3029509
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 14:36:53 +1000
Message-ID: <53574362.8010501@linux.vnet.ibm.com>
Date: Wed, 23 Apr 2014 10:06:50 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 6/6] powerpc/powernv: Fix little endian issues in OPAL
 dump code
References: <1398142887-24109-1-git-send-email-anton@samba.org>
 <1398142887-24109-6-git-send-email-anton@samba.org>
 <53562921.6050300@linux.vnet.ibm.com> <20140423073115.6a7d4802@kryten>
In-Reply-To: <20140423073115.6a7d4802@kryten>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: stewart@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/2014 03:01 AM, Anton Blanchard wrote:
> Hi,
>
>> -int64_t opal_dump_info(uint32_t *dump_id, uint32_t *dump_size);
>> -int64_t opal_dump_info2(uint32_t *dump_id, uint32_t *dump_size, uint32_t *dump_type);
>> +int64_t opal_dump_info(__be32 *dump_id, __be32 *dump_size);
>> +int64_t opal_dump_info2(__be32 *dump_id, __be32 *dump_size, __be32 *dump_type);
>>   int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
>>   int64_t opal_dump_ack(uint32_t dump_id);
>>
>> Shouldn't we change above two functions as well ?
>
> No, there are no endian issues here because we pass the values via
> register. The only endian issues are for values we pass via pointer.
>

Anton,

Thanks for the clarification..


-Vasant
