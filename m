Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26E521A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 00:20:41 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 06:20:39 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8F8BA3E4004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 06:20:36 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1GDKaJ625755686
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 06:20:36 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1GDKa2O007202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 06:20:36 -0700
Received: from oc5780617838.ibm.com ([9.80.84.27])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1GDKY5V007104
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 06:20:34 -0700
Subject: Re: [RFC, kernel] powerpc/ioda: Set "read" permission when "write" is
 set
To: linuxppc-dev@lists.ozlabs.org
References: <20160216031824.E5C8E140761@ozlabs.org>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Message-ID: <56C32222.6050704@linux.vnet.ibm.com>
Date: Tue, 16 Feb 2016 07:20:34 -0600
MIME-Version: 1.0
In-Reply-To: <20160216031824.E5C8E140761@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/15/2016 09:18 PM, Michael Ellerman wrote:
> On Tue, 2016-12-01 at 04:40:20 UTC, Alexey Kardashevskiy wrote:
>> Quite often drivers set only "write" permission assuming that this
>> includes "read" permission as well and this works on plenty platforms.
>> However IODA2 is strict about this and produces an EEH when "read"
>> permission is not and reading happens.
>>
>> This adds a workaround in IODA code to always add the "read" bit when
>> the "write" bit is set.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Tested-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> Are you planning on sending a non-RFC version of this?
>
> If so is it an urgent fix I should send upstream now? And if so should it
> also be CC'ed to stable?
>
> cheers
I vote for the more-urgent case. This is the result of a fairly recent 
change in behavior and we may not have found all the adapters that will 
break yet. If we get this upstream sooner, it means less exposure.
