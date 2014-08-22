Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 024291A01C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 12:48:15 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 21 Aug 2014 20:48:13 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DDF9A1FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 20:48:10 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7M2mB5822872206
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 04:48:11 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7M2mB8W004387
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 20:48:11 -0600
Message-ID: <53F6AF66.10204@linux.vnet.ibm.com>
Date: Fri, 22 Aug 2014 08:18:06 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Shilpasri G Bhat <shilpabhatppc@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: powernv: Register the driver with reboot notifier
References: <1408015178-21745-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohponDNHYrD9b==cp+pVmAi2ygA9-HcLZWqr4w3DDivB=-Ng@mail.gmail.com>
 <53F57E51.4060200@gmail.com>
 <CAKohpon8ANWoy52B=_nSuNyHALrsQOLX4cA+690E=CifnVRFtg@mail.gmail.com>
In-Reply-To: <CAKohpon8ANWoy52B=_nSuNyHALrsQOLX4cA+690E=CifnVRFtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Viresh,

On 08/21/2014 11:56 AM, Viresh Kumar wrote:
> On 21 August 2014 10:36, Shilpasri G Bhat <shilpabhatppc@gmail.com> wrote:
>> The intention here is stop the cpufreq governor and then to set the cpus to
>> nominal frequency so as to ensure that the frequency won't be changed later.
>>
>> The .suspend callback of the driver is not called during reboot/kexec.
>> So we need an explicit reboot notifier to call cpufreq-suspend() to
>> suffice the requirement.
> 
> Hi Shilpa,
> 
> No, we can't allow any platform driver to misuse cpufreq_suspend().
> Platform drivers aren't *allowed* to call this routine.

At the moment this looks like the best way forward. We need to do this
cleanly by ensuring that we stop the governors and then call into the
driver to deal with the cpu frequency in its own way during reboot. The
best way to do this would be by calling this routine. Either this or
cpufreq_suspend() should be called in the reboot path generically. The
latter might not be an enticing option for other platforms.

Regards
Preeti U Murthy
> 
> Now the deal is how do we move to nominal frequency on reboot..
> @Rafael: Any suggestions? How do we ensure that governors
> are stopped on these notifiers, or if there is some other solution here?
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
