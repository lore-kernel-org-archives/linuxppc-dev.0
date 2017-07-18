Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBq7y30VmzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 04:54:05 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6IIpC1R006191
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:54:02 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bskg74500-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 14:54:02 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 18 Jul 2017 12:54:01 -0600
Date: Tue, 18 Jul 2017 11:53:52 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: Nicholas Piggin <nicholas.piggin@gmail.com>, mikey@neuling.org,
 herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ddstreet@ieee.org
Subject: Re: [PATCH V2 0/6] Enable NX 842 compression engine on Power9
References: <1500334999.995.6.camel@hbabu-laptop>
 <20170718161444.72252c9c@roar.ozlabs.ibm.com>
 <20170718180600.GB21838@us.ibm.com>
In-Reply-To: <20170718180600.GB21838@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <596E5940.7000207@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2017 11:06 AM, Sukadev Bhattiprolu wrote:
> Nicholas Piggin [nicholas.piggin@gmail.com] wrote:
>> On Mon, 17 Jul 2017 16:43:19 -0700
>> Haren Myneni <haren@linux.vnet.ibm.com> wrote:
>>
>>> [PATCH V2 0/6] Enable NX 842 compression engine on Power9
>>> This patchset depends on VAS kernel changes:
>>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-May/158178.html
>>
>> Just a question, we no longer invalidate the copy buffer on context
>> switch after this patch:
>>
>> 07d2a628bc ("powerpc/64s: Avoid cpabort in context switch when possible")
>>
>> If your vas address mappings are visible only to kernel, only used in
>> process / kthread context, and only used with kernel preemption disabled,
>> this is okay.
> 
> Kernel preemption is not explicitly disabled in the NX driver I think
> and
> 
>>
>> If userspace can possibly copy/paste to the mappings or if you need to
>> sleep or call this from interrupt context, we need to work out how to
>> invalidate the copy buffer.
> 
> user space cannot copy/paste to the mappings yet (that mechanism is
> further out).
> 
> NX driver calls:
> 
> 	vas_copy(&crb, ...);
> 	vas_paste(addr, ...);
> 
> but not from an interrupt context. Can/should we disable premption between
> the copy/paste and to avoid having to invalidate the copy buffer?

Nick, Also we do not support 842 in user space. Only future NX gzip compression module.

If OK, will add disable premption for copy/paste. Thanks for review, 
 
> 
> Sukadev
> 
