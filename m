Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0FAA1A0213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 19:07:47 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1253414016A
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 19:07:46 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 14:37:44 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 407EF1258059
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 14:39:44 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3S97g0Y50987134
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 14:37:42 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3S97cNp005978
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 14:37:38 +0530
Message-ID: <553F4DD9.5060509@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 14:37:37 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Register for OCC related
 opal_message notification
References: <1430202214-13807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1430202214-13807-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohpomaOvpdOYqAsOyPn0nRG0Mb68JscXhgBPDa6grqRAE8zA@mail.gmail.com>
 <553F426B.3050601@linux.vnet.ibm.com>
 <CAKohpon0XNfSo2qht_zZSspQCUMSG1mV_=SMnWdMbTMKQq0DVA@mail.gmail.com>
In-Reply-To: <CAKohpon0XNfSo2qht_zZSspQCUMSG1mV_=SMnWdMbTMKQq0DVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/28/2015 02:23 PM, Viresh Kumar wrote:
> On 28 April 2015 at 13:48, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>> My bad I haven't added explicit comment to state reason behind this change.
>>
>> I modified the definition of *throttle_check() to match the function definition
>> to be called via smp_call() instead of adding an additional wrapper around
>> *throttle_check().
>>
>> OCC is a chip entity and any local throttle state changes should be associated
>> to cpus belonging to that chip. The *throttle_check() will read the core
>> register PMSR to verify throttling. All the cores in a chip will have the same
>> throttled state as they are managed by a the same OCC in that chip.
>>
>> smp_call() is required to ensure *throttle_check() is called on a cpu belonging
>> to the chip for which we have received throttled/unthrottled notification. We
>> could be handling throttled/unthrottled notification of 'chip1' in 'chip2' so do
>> an smp_call() on 'chip1'.
> 
> Okay. Lets talk about the code that is already present in mainline. Isn't that
> suffering from this issue ? If yes, then you need to bugfix that separately.

Nope. The upstream code does not have this issue as it does not have checks to
detect unthrottling state. The unthrottling i.e, 'throttled=false' is being
handled only in this patchset.

Yes this can be fixed separately.

> 
>> We are irq_disabled in powernv_cpufreq_occ_msg() the notification handler.
>> Thus the use of kworker to do an smp_call and restore policy->cur.
>>
>> OCC_RESET is global event it affects frequency of all chips. Pmax capping is
>> local event, it affects the frequency of a chip.
>>
> 
>>> That's a lot. I am not an expert here and so really can't comment on
>>> the internals of ppc. But, is it patch solving a single problem ? I don't
>>> know, I somehow got the impression that it can be split into multiple
>>> (smaller & review-able) patches. Only if it makes sense. Your call.
>>
>> All the changes introduced in this patch is centered around opal_message
>> notification handler powernv_cpufreq_occ_msg(). I can split it into multiple
>> patches but it all will be relevant only to solve the above problem.
> 
> And that's what I meant here. Yes, this all is solving a central problem, but
> a patch must be divided into separate, independently working, entities.
> 

Yup agree. Will do.
