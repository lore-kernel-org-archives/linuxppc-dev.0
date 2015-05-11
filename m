Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E69ED1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 08:31:35 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 11 May 2015 16:31:33 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1316B19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 16:22:36 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BMVOZk50069552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 15:31:24 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BMVWk9022933
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 16:31:32 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: trigg <mr.triggtrigg@gmail.com>,
 Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/powernv: Add poweroff (EPOW,
 DPO) events support for PowerNV platform
In-Reply-To: <CAPfuKj+CpLN7QdRJ+VFTz1_p5QL9fkJ+FOa0tKQ2-YEOoXR+4g@mail.gmail.com>
References: <1430991020-7556-1-git-send-email-vipin@linux.vnet.ibm.com>
 <1430991020-7556-2-git-send-email-vipin@linux.vnet.ibm.com>
 <CAPfuKj+CpLN7QdRJ+VFTz1_p5QL9fkJ+FOa0tKQ2-YEOoXR+4g@mail.gmail.com>
Date: Tue, 12 May 2015 08:31:29 +1000
Message-ID: <m3zj5arbjy.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, joel@jms.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

trigg <mr.triggtrigg@gmail.com> writes:
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -730,6 +730,36 @@ struct opal_i2c_request {
>>         __be64 buffer_ra;               /* Buffer real address */
>>  };
>>
>> +/*
>> + * EPOW status sharing (OPAL and the host)
>> + *
>> + * The host will pass on OPAL, a buffer of length OPAL_EPOW_MAX_CLASSES
>> + * to fetch system wide EPOW status. Each element in the returned buffer
>> + * will contain bitwise EPOW status for each EPOW sub class.
>> + */
>> +
>> +/* EPOW types */
>> +enum OpalEpow {
>> +       OPAL_EPOW_POWER         = 0,    /* Power EPOW */
>> +       OPAL_EPOW_TEMP          = 1,    /* Temperature EPOW */
>> +       OPAL_EPOW_COOLING       = 2,    /* Cooling EPOW */
>> +       OPAL_MAX_EPOW_CLASSES   = 3,    /* Max EPOW categories */
>> +};
> Dont explicitly assign sequential numbers in an enum. Its taken care
> of by the compiler.

This header is shared with firmware, and the exact values of each item
does matter as it's ABI. The explicit numbers means that people think
twice before inserting a new value in the middle and subtley breaking
firmware ABI.
