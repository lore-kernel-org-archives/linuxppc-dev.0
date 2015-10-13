Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67E161A07F1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 15:29:30 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39817140273
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 15:29:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 14:29:29 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4758E2BB0054
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 15:29:26 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D4TJEb66126052
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 15:29:27 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D4SrdS016977
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 15:28:53 +1100
Date: Tue, 13 Oct 2015 15:28:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/8] powerpc/eeh: More relexed hotplug criterion
Message-ID: <20151013042828.GA28681@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <87612b4rye.fsf@gamma.ozlabs.ibm.com>
 <20151012232510.GA14333@gwshan>
 <87y4f732ll.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y4f732ll.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 01:48:54PM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> Danienl, The issue is tracked by IBM's bugzilla 127612 reported from Nvida
>> private GPU drivers. I tried to find the source code from upstream kernel,
>> but failed.
>
>OK. So I've read the internal bug, and I'm going to do my best to summarise
>without including confidential info.
>
> 1) A PHB with 2 devices is fenced via error injection.
>
> 2) The error_detected() callback is run on both devices. One returns
>    CAN_RECOVER, the other returns NONE.
>
>We then fall through to partial-hotplug handling. (BTW this isn't
>documented in Documentation/PCI/pci-error-recovery.txt, so at some point
>this should be fixed!)
>

No hotplug is triggered when EEH core receives CAN_RECOVER. It seems the
bug brought confusion instead of helping to explain the situation as I
intended to. I was intended to say: there has driver which implements
part of the EEH callbacks to collect diag-data.

>Partial hotplug is detected by the presence of an err_handler, not by
>storing the result of error_detected. Would it be better to store the
>result from eeh_report_error in the eeh_dev structure, rather than by
>looking at more elements of the err_handler structure?
>

I don't see the benefit to do that. In eeh_report_error(), the specific
error handlers still need to be checked and the result (from the check)
is temporary, and not worthy to store that in eeh_dev. The current code
looks good.

>More generally, drivers using error_detect and then returning NONE as a
>way to get data and then not participate in EEH is a hack, and it's not
>surprising it's breaking in odd ways, especially with partial hotplug.
>

I think you're talking about the situation reported from the bug. It's
CAN_RECOVER instead of NONE returned from error_detected(). With the
CAN_RECOVER, the driver hopes the EEH core to enable the IO path so that
it can collect diag-data from IO space at late point.

>Partial hotplug is pretty hacky to begin with, and a driver being able
>to opt out of EEH selectively is a useful feature, so we probably want
>to redesign the state machine to handle them both better. That would be
>a long term project.
>

Thanks,
Gavin

>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>> ---
>>>>  arch/powerpc/kernel/eeh_driver.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>>>> index 3a626ed..32178a4 100644
>>>> --- a/arch/powerpc/kernel/eeh_driver.c
>>>> +++ b/arch/powerpc/kernel/eeh_driver.c
>>>> @@ -416,7 +416,10 @@ static void *eeh_rmv_device(void *data, void *userdata)
>>>>  	driver = eeh_pcid_get(dev);
>>>>  	if (driver) {
>>>>  		eeh_pcid_put(dev);
>>>> -		if (driver->err_handler)
>>>> +		if (driver->err_handler &&
>>>> +		    driver->err_handler->error_detected &&
>>>> +		    driver->err_handler->slot_reset &&
>>>> +		    driver->err_handler->resume)
>>>>  			return NULL;
>>>>  	}
>>>>  
>>>> -- 
>>>> 2.1.0
>>>>
>>>> _______________________________________________
>>>> Linuxppc-dev mailing list
>>>> Linuxppc-dev@lists.ozlabs.org
>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
