Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmRXM1HHpzF0p0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 16:54:58 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id a17so280539pff.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 21:54:58 -0800 (PST)
Date: Wed, 21 Feb 2018 11:24:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpufreq: powernv: Check  negative value returned by
 cpufreq_table_find_index_dl()
Message-ID: <20180221055450.GO28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7>
 <874lmasxxx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874lmasxxx.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21-02-18, 16:39, Michael Ellerman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:

> > AFAICT, you will get -1 here only if the freq table had no valid
> > frequencies (or the freq table is empty). Why would that happen ?
> 
> Bugs?

The cupfreq driver shouldn't have registered itself in that case (i.e.
if the cpufreq table is empty).

> Or if you ask for a target_freq that is higher than anything in the
> table.

You will still get a valid index in that case.

There is only once case where we return -1, when the cpufreq table
doesn't have any valid frequencies.

> Or the API changes, and we forget to update this call site.

I am not sure we can do much about that right now.

> If you're saying that cpufreq_table_find_index_dl() can NEVER fail,

Yes, if we have at least one valid frequency in the table, otherwise
the cpufreq driver shouldn't have registered itself.

> then
> write it so that it can never fail and change it to return unsigned int.

But what should we do when there is no frequency in the cpufreq table?
Just in case where a driver is buggy and tries to call this routine
for an invalid table.

> Having it potentially return -1, which is then used to index an array
> and not handling that is just asking for bugs to happen.

I understand what you are trying to say here, but I don't know what
can be done to prevent this here.

What we can do is change the return type to void and pass a int
pointer to the routine, but that wouldn't change anything at all. That
pointers variable can still have -1 in it.

-- 
viresh
