Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F06E01A0143
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 18:10:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 13:40:38 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2B346E005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 13:43:07 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E8AYqG63832234
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 13:40:35 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E8AW3t020338
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 13:40:32 +0530
Message-ID: <552CCB77.1000307@linux.vnet.ibm.com>
Date: Tue, 14 Apr 2015 13:40:31 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 3/3] powerpc/powernv: Introduce sysfs control for
 fastsleep workaround behavior
References: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1428976613-13007-4-git-send-email-shreyas@linux.vnet.ibm.com>
 <552CACD2.5060600@linux.vnet.ibm.com>
In-Reply-To: <552CACD2.5060600@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>
>> By default, fastsleep_workaround_state = dynamic. In this case, workaround
>> is applied/undone everytime the core enters/exits fastsleep.
>>
>> fastsleep_workaround_state = applyonce. In this case the workaround is
>> applied once on all the cores and never undone. This can be triggered by
>> echo applyonce > /sys/devices/system/cpu/fastsleep_workaround_state
> 
> I was wondering if we really need such an elaborate design for this
> sysfs file. Why not a sysfs file called fastsleep_workaround_apply_once,
> which is set to '0' by default and the only value that it can take is
> '1' ? The name easily implies that the workaround is applied only once
> if it is set. I can see that this can cut down a good chunk of code from
> this patch. I just didn't find too much value in having so much code for
> a simple 'on' knob.

I was considering something similar too. But then moved to this format
as I thought this was unambiguous. Also moving to a binary attribute
will reduces code only in show_fastsleep_workaround_state which I don't
feel is much.
That said, if you feel strongly about it, I can change it to the format
you suggested.

Thanks,
Shreyas
