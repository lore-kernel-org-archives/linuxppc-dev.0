Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 464881A0213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 18:53:08 +1000 (AEST)
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 97FFF14012C
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 18:53:03 +1000 (AEST)
Received: by obbeb7 with SMTP id eb7so103075034obb.3
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 01:53:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <553F426B.3050601@linux.vnet.ibm.com>
References: <1430202214-13807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1430202214-13807-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohpomaOvpdOYqAsOyPn0nRG0Mb68JscXhgBPDa6grqRAE8zA@mail.gmail.com>
 <553F426B.3050601@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 14:23:01 +0530
Message-ID: <CAKohpon0XNfSo2qht_zZSspQCUMSG1mV_=SMnWdMbTMKQq0DVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Register for OCC related
 opal_message notification
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
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

On 28 April 2015 at 13:48, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> My bad I haven't added explicit comment to state reason behind this change.
>
> I modified the definition of *throttle_check() to match the function definition
> to be called via smp_call() instead of adding an additional wrapper around
> *throttle_check().
>
> OCC is a chip entity and any local throttle state changes should be associated
> to cpus belonging to that chip. The *throttle_check() will read the core
> register PMSR to verify throttling. All the cores in a chip will have the same
> throttled state as they are managed by a the same OCC in that chip.
>
> smp_call() is required to ensure *throttle_check() is called on a cpu belonging
> to the chip for which we have received throttled/unthrottled notification. We
> could be handling throttled/unthrottled notification of 'chip1' in 'chip2' so do
> an smp_call() on 'chip1'.

Okay. Lets talk about the code that is already present in mainline. Isn't that
suffering from this issue ? If yes, then you need to bugfix that separately.

> We are irq_disabled in powernv_cpufreq_occ_msg() the notification handler.
> Thus the use of kworker to do an smp_call and restore policy->cur.
>
> OCC_RESET is global event it affects frequency of all chips. Pmax capping is
> local event, it affects the frequency of a chip.
>

>> That's a lot. I am not an expert here and so really can't comment on
>> the internals of ppc. But, is it patch solving a single problem ? I don't
>> know, I somehow got the impression that it can be split into multiple
>> (smaller & review-able) patches. Only if it makes sense. Your call.
>
> All the changes introduced in this patch is centered around opal_message
> notification handler powernv_cpufreq_occ_msg(). I can split it into multiple
> patches but it all will be relevant only to solve the above problem.

And that's what I meant here. Yes, this all is solving a central problem, but
a patch must be divided into separate, independently working, entities.
