Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8WPN2VfwzDq6q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 05:57:11 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0QIrVIm100201
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 13:57:09 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 287m9yekeu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 13:57:09 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Thu, 26 Jan 2017 11:57:07 -0700
Subject: Re: [PATCH net 1/5] ibmvnic: harden interrupt handler
To: David Miller <davem@davemloft.net>
References: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <20170125.230413.830821835017116629.davem@davemloft.net>
 <0cea7654-6722-5e68-cd05-cc51bbf7a5ae@linux.vnet.ibm.com>
 <20170126.125624.243097121899163842.davem@davemloft.net>
Cc: netdev@vger.kernel.org, wvoigt@us.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2017 12:57:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170126.125624.243097121899163842.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <8fa5134a-25a7-165a-d035-cc86cd690885@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/26/2017 11:56 AM, David Miller wrote:
> From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> Date: Thu, 26 Jan 2017 10:44:22 -0600
>
>> On 01/25/2017 10:04 PM, David Miller wrote:
>>> From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>>> Date: Wed, 25 Jan 2017 15:02:19 -0600
>>>
>>>> Move most interrupt handler processing into a tasklet, and
>>>> introduce a delay after re-enabling interrupts to fix timing
>>>> issues encountered in hardware testing.
>>>>
>>>> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>>> I don't think you have any idea what the real problem is.  This looks
>>> like a hack, at best.  Next patch you'll increase the delay to "20",
>>> right?  And if that doesn't work you'll try "40".
>>>
>>> Or if you do know the reason, you need to explain it in detail in this
>>> commit message so that we can properly evaluate this patch.
>> You're right, I should have given more explanation in the commit message about the bug encountered and our reasons for this sort of fix.  The issue is that there are some scenarios during the device init where multiple messages are sent by firmware in one interrupt request. 
>>
>> We have observed behavior where messages are delayed, resulting in the interrupt handler completing before the delayed messages can be processed, fouling up the device bring-up in the device probing and elsewhere.  The goal of the delay is to buy some time for the hypervisor to forward all the CRQ messages from the firmware.
> Then isn't there an event you can sleep and wait for, or a piece of state for
> you to poll and test for in a timeout based loop?
>
> This delay is a bad solution for the problem of waiting for A to happen
> before you do B.
>
Understood.  We will come up with a better fix.  Thanks for your attention.
