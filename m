Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlkrk3H88zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 12:19:32 +1000 (AEST)
Received: by mail-pf0-x229.google.com with SMTP id 184so41117164pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 19:19:32 -0700 (PDT)
Date: Thu, 14 Apr 2016 07:49:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
Message-ID: <20160414021927.GK19433@vireshk-i7>
References: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460484386-28389-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160413050310.GE19433@vireshk-i7>
 <570E889F.2010401@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570E889F.2010401@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13-04-16, 23:27, Akshay Adiga wrote:
> On 04/13/2016 10:33 AM, Viresh Kumar wrote:
> >>+void gpstate_timer_handler(unsigned long data)
> >>+{
> >>+	struct cpufreq_policy *policy = (struct cpufreq_policy *) data;
> >no need to cast.
> 
> May be i need a cast here,  because data is unsigned long ( unlike other places where its void *).
> On building without cast, it throws me a warning.

My bad, yeah :(

> >>+	if (freq_data.gpstate_id != freq_data.pstate_id)
> >>+		ret = queue_gpstate_timer(gpstates);
> >ret not used.
> 
> Should i make it void instead of returning int?, as i cannot do much even if it fails, except for notifying.

Sure.

-- 
viresh
