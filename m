Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7DFA1A0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 22:07:32 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 22:07:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 797CC2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 22:07:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7JC7D9d1442096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 22:07:21 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7JC6sEN011180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 22:06:55 +1000
Message-ID: <55D47143.5040908@linux.vnet.ibm.com>
Date: Wed, 19 Aug 2015 17:36:27 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, rpurdie@rpsys.net,
 cooloney@gmail.com, khandual@linux.vnet.ibm.com,
 j.anaszewski81@gmail.com, arnd@arndb.de, stewart@linux.vnet.ibm.com,
 benh@kernel.crashing.org
Subject: Re: [PATCH v8 3/3] leds/powernv: Add driver for PowerNV platform
References: <1437801670-23705-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1437801670-23705-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55B5540B.1000301@gmail.com> <55B5A853.3080909@linux.vnet.ibm.com>
 <55B5FEDD.2000506@gmail.com> <55B7865E.8000402@linux.vnet.ibm.com>
 <55B7BEA8.7080107@gmail.com> <55D46E5B.20203@samsung.com>
In-Reply-To: <55D46E5B.20203@samsung.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2015 05:24 PM, Jacek Anaszewski wrote:
> Hi Vasant,
> 
> On 07/28/2015 07:40 PM, Jacek Anaszewski wrote:
>> Vasant,
>>
>>>
>>>>
>>>> Without my core changes your driver won't work with led triggers, but
>>>> AFAIR this use case is not relevant for your LEDs? Eventually, we could
>>>> produce a patch set adding support for LED triggers if it will be clear
>>>> that LED core changes will not be merged in the upcoming merge window.
>>>
>>> IIUC current LED code doesn't allow me to sleep (without driver specific
>>> workqueue). And powernv_led_set() call will sleep. Hence I think it
>>> won't work.
>>>
>>> I did a quick test without your patch. It doesn't seems to be working.
> 

Jacek,

> Does brightness setting work properly without work queue?
> 

Sorry ...  I forgot to respond to this thread..

Yes.. It worked for me..

I have tested v9 with and without your code patchset.. In both cases its working
fine..

Sample test case :
	[root@tul176p1 leds]# cd U78C9.001.RST0027-P1-C14:identify
	
	[root@tul176p1 U78C9.001.RST0027-P1-C14:identify]# pwd
	/sys/class/leds/U78C9.001.RST0027-P1-C14:identify
	
	[root@tul176p1 U78C9.001.RST0027-P1-C14:identify]# cat brightness
	0
	
	[root@tul176p1 U78C9.001.RST0027-P1-C14:identify]# echo 1 > brightness
	[root@tul176p1 U78C9.001.RST0027-P1-C14:identify]# cat brightness
	255

-Vasant
