Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A18D21A0729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 23:41:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 28 Jul 2015 23:41:49 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8EA913578055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 23:41:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6SDfW9764159908
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 23:41:41 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6SDf6ch007323
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 23:41:07 +1000
Message-ID: <55B7865E.8000402@linux.vnet.ibm.com>
Date: Tue, 28 Jul 2015 19:10:46 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, j.anaszewski@samsung.com, mpe@ellerman.id.au
CC: rpurdie@rpsys.net, cooloney@gmail.com, khandual@linux.vnet.ibm.com,
 j.anaszewski81@gmail.com, arnd@arndb.de, stewart@linux.vnet.ibm.com,
 benh@kernel.crashing.org
Subject: Re: [PATCH v8 3/3] leds/powernv: Add driver for PowerNV platform
References: <1437801670-23705-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1437801670-23705-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55B5540B.1000301@gmail.com> <55B5A853.3080909@linux.vnet.ibm.com>
 <55B5FEDD.2000506@gmail.com>
In-Reply-To: <55B5FEDD.2000506@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/27/2015 03:20 PM, Jacek Anaszewski wrote:
> Hi Vasant,
> 
> On 27.07.2015 05:41, Vasant Hegde wrote:
>> On 07/27/2015 03:11 AM, Jacek Anaszewski wrote:
>>> Hi Vasant,
>>>
>>
>> Hi Jacek,
>>
>>> Two trivial details left. Please find them below.
>>
>> Thanks for the review/Ack. I'll fix below issues and resend patchset.
>>
>> I will ask Benh/Michael to take this patchset. But this patchset is depending
>> on your core changes. Can you confirm that you are pushing that patchset in next
>> merge window?

Jacek,

> 
> Without my core changes your driver won't work with led triggers, but
> AFAIR this use case is not relevant for your LEDs? Eventually, we could
> produce a patch set adding support for LED triggers if it will be clear
> that LED core changes will not be merged in the upcoming merge window.

IIUC current LED code doesn't allow me to sleep (without driver specific
workqueue). And powernv_led_set() call will sleep. Hence I think it won't work.

I did a quick test without your patch. It doesn't seems to be working.

Alternatively we can revert the changes (add driver specific workqueue now) and
later when your changes goes to upstream, I can fix my code.

-Vasant
