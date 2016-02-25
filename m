Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA0CF1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 03:58:50 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 09:58:46 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8185019D806B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 09:46:41 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1PGwi4a31719668
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 09:58:44 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1PGwhR0011266
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 09:58:44 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v5 14/18] cxl: Support to flash a new image on the adapter
 from a guest
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-15-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CE0C7E.7090001@linux.vnet.ibm.com> <56CEFD7D.6010005@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CF32DA.2060806@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2016 10:59:06 -0600
MIME-Version: 1.0
In-Reply-To: <56CEFD7D.6010005@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fred: Comments below.

On 2/25/2016 7:11 AM, Frederic Barrat wrote:
>
>
> Le 24/02/2016 21:03, Manoj Kumar a écrit :
>
>>> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
>>>
>>> +#define CXL_DEV_MINORS 13   /* 1 control + 4 AFUs * 3
>>> (dedicated/master/shared) */
>>
>> Where does this limit of 4 AFUs come from?
>> Is this related to CXL_MAX_SLICES?
>> Should this be a computed value, in case the number of AFUs/slices
>> is increased at a future date?
>
> The architecture document (CAIA) limits the number of AFUs to 4, though
> I don't think anybody as tried with more than 1 so far.
> So yes, we could have reused CXL_MAX_SLICES. Since we were just moving
> the definition from another file and this is not likely to vary until a
> major revision of the architecture, I don't intend to address it in this
> patchset, but I've added it to my list of ideas for future cleanup (you
> had already mentioned something about hard-coded constants in the
> previous series).

Since it was a carryover from existing code, it is fine to address
later.

>> memset(0) after kzalloc() is redundant.
>
> yep! Will fix.

If this is resolved in v6, you may add

Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar
