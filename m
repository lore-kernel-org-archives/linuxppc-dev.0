Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yltVZ03TXzDrCy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 04:06:13 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vARH63cQ122481
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:06:11 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2egn99d1ce-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 12:06:09 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 17:05:35 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: "Alastair D'Silva" <alastair@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
In-Reply-To: <87609w4c8t.fsf@concordia.ellerman.id.au>
References: <20171123124718.16839-1-vaibhav@linux.vnet.ibm.com>
 <87lgiw19qd.fsf@concordia.ellerman.id.au>
 <87fu94f925.fsf@vajain21.in.ibm.com>
 <87609w4c8t.fsf@concordia.ellerman.id.au>
Date: Mon, 27 Nov 2017 22:35:24 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k1ybmz3f.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
>
>> Thanks Mpe for reviewing the patch
>>
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>
>>>> To fix this the patch assigns the return value of assign_thread_tidr()
>>>> to a temporary int and assigns it to thread.tidr iff its '> 0'.
>>>
>>> .. and changes the calling convention of the function.
>>>
>>> Now it returns -ve error values, or a +ve TIDR value when it succeeds,
>>> or possibly 0 if that's returned by assign_thread_tidr().
>>>
>>> Which I'm not sure you meant to do. If you did, you should at least
>>> document it.
>>
>> Yes this is intentional and this was supposed to be the calling
>> convention of set_thread_tidr() in first place. At-least that what I
>> gather from subsequent cxl patch to add its support
>> http://patchwork.ozlabs.org/patch/840719/
>
> That's not at all what I gather from that patch.
>
> +		/* Assign a unique TIDR (thread id) for the current thread */
> +		rc = set_thread_tidr(current);
> +		if (!rc)
> +			ctx->tid = current->thread.tidr;
>
> That expects 0 on success, anything else is an error.
>
> Which is what set_thread_tidr() currently implements, and is the most
> common calling convention in kernel code.
>
> Please don't change that as part of an unrelated fix.
>
> If you want to change the calling convention, send a patch to do that
> and only that.
>
> cheers
>
Agreed Mpe, checked with Christophe and he too echoed similar inputs. I
will update my v2 patch by not causing a change to he call convention.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
