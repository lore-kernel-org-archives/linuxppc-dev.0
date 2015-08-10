Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AC6F1A1D4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 17:40:58 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 751D51401E7
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 17:40:57 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 10 Aug 2015 13:10:55 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6F171125805E
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 13:14:04 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7A7Yduo34668794
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 13:10:50 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7A7VOdN016208
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 13:01:25 +0530
Message-ID: <55C8534A.5040904@linux.vnet.ibm.com>
Date: Mon, 10 Aug 2015 13:01:22 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>
CC: rjw@rjwysocki.net, joel@jms.id.au, viresh.kumar@linaro.org,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/6] powerpc/powernv: Add definition of OPAL_MSG_OCC
 message type
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1437033863-15864-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <m31tfcf0td.fsf@oc8180480414.ibm.com>
In-Reply-To: <m31tfcf0td.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stewart,

On 08/10/2015 05:53 AM, Stewart Smith wrote:
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>> Add OPAL_MSG_OCC message definition to opal_message_type to receive
>> OCC events like reset, load and throttled. Host performance can be
>> affected when OCC is reset or OCC throttles the max Pstate.
>> We can register to opal_message_notifier to receive OPAL_MSG_OCC type
>> of message and report it to the userspace so as to keep the user
>> informed about the reason for a performance drop in workloads.
>>
>> The reset and load OCC events are notified to kernel when FSP sends
>> OCC_RESET and OCC_LOAD commands.  Both reset and load messages are
>> sent to kernel on successful completion of reset and load operation
>> respectively.
> 
> How is this done on OpenPower systems? Explanation involving just what
> OPAL does is likely better, rather than explaining in context of FSP,
> which Linux has no real knowledge of (OPAL provides all abstraction of
> it).
> 

In OpenPower systems, opal will only send OCC throttled event. OCC reset
and load messages are not sent to kernel.

How about the following git log message?

Add OPAL_MSG_OCC message definition to opal_message_type to receive
OCC events like reset, load and throttled. Host performance can be
affected when OCC is reset or OCC throttles the max Pstate.  We can
register to opal_message_notifier to receive OPAL_MSG_OCC type of
message and report it to the userspace so as to keep the user informed
about the reason for a performance drop in workloads.

Opal will send reset and load events to kernel on successful
completion of reset and load operation of OCC. During this duration
the cpu frequency will be throttled until OCC is started. Opal will
send a throttle message during the OCC reset-cycle to indicate that
OCC is active.

Opal will send throttle message to kernel when OCC is active to
indicate that the Pmax of the chip is reduced. The chip_id and
throttle reason for reducing Pmax is queued along with the message.

Thanks and Regards,
Shilpa
