Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylXj15DkSzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 14:44:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: Avoid signed to unsigned conversion in
 set_thread_tidr()
In-Reply-To: <87fu94f925.fsf@vajain21.in.ibm.com>
References: <20171123124718.16839-1-vaibhav@linux.vnet.ibm.com>
 <87lgiw19qd.fsf@concordia.ellerman.id.au>
 <87fu94f925.fsf@vajain21.in.ibm.com>
Date: Mon, 27 Nov 2017 14:44:02 +1100
Message-ID: <87609w4c8t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> Thanks Mpe for reviewing the patch
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>>> To fix this the patch assigns the return value of assign_thread_tidr()
>>> to a temporary int and assigns it to thread.tidr iff its '> 0'.
>>
>> .. and changes the calling convention of the function.
>>
>> Now it returns -ve error values, or a +ve TIDR value when it succeeds,
>> or possibly 0 if that's returned by assign_thread_tidr().
>>
>> Which I'm not sure you meant to do. If you did, you should at least
>> document it.
>
> Yes this is intentional and this was supposed to be the calling
> convention of set_thread_tidr() in first place. At-least that what I
> gather from subsequent cxl patch to add its support
> http://patchwork.ozlabs.org/patch/840719/

That's not at all what I gather from that patch.

+		/* Assign a unique TIDR (thread id) for the current thread */
+		rc = set_thread_tidr(current);
+		if (!rc)
+			ctx->tid = current->thread.tidr;

That expects 0 on success, anything else is an error.

Which is what set_thread_tidr() currently implements, and is the most
common calling convention in kernel code.

Please don't change that as part of an unrelated fix.

If you want to change the calling convention, send a patch to do that
and only that.

cheers
