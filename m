Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D27F01A0BEE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 18:31:49 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 02:31:47 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CB7F73E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:31:44 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E8VTaD34930864
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 01:31:29 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E8ViHL009538
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:31:44 -0600
Message-ID: <552CD06D.9070701@linux.vnet.ibm.com>
Date: Tue, 14 Apr 2015 14:01:41 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 3/3] powerpc/powernv: Introduce sysfs control for
 fastsleep workaround behavior
References: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1428976613-13007-4-git-send-email-shreyas@linux.vnet.ibm.com>
 <552CACD2.5060600@linux.vnet.ibm.com> <552CCB77.1000307@linux.vnet.ibm.com>
In-Reply-To: <552CCB77.1000307@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/14/2015 01:40 PM, Shreyas B Prabhu wrote:
> 
>>>
>>> By default, fastsleep_workaround_state = dynamic. In this case, workaround
>>> is applied/undone everytime the core enters/exits fastsleep.
>>>
>>> fastsleep_workaround_state = applyonce. In this case the workaround is
>>> applied once on all the cores and never undone. This can be triggered by
>>> echo applyonce > /sys/devices/system/cpu/fastsleep_workaround_state
>>
>> I was wondering if we really need such an elaborate design for this
>> sysfs file. Why not a sysfs file called fastsleep_workaround_apply_once,
>> which is set to '0' by default and the only value that it can take is
>> '1' ? The name easily implies that the workaround is applied only once
>> if it is set. I can see that this can cut down a good chunk of code from
>> this patch. I just didn't find too much value in having so much code for
>> a simple 'on' knob.
> 
> I was considering something similar too. But then moved to this format
> as I thought this was unambiguous. Also moving to a binary attribute
> will reduces code only in show_fastsleep_workaround_state which I don't
> feel is much.
> That said, if you feel strongly about it, I can change it to the format
> you suggested.

It cuts down two of your data structures:
fastsleep_workaround_avail_states[] and the enum and the parsing of the
input string in store_fastsleep_workaround_state() too.

Regards
Preeti U Murthy
> 
> Thanks,
> Shreyas
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
