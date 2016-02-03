Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31DE91A0226
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 20:04:03 +1100 (AEDT)
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 62D9314033E
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 20:04:02 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id n128so10479217pfn.3
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Feb 2016 01:04:02 -0800 (PST)
Date: Wed, 3 Feb 2016 14:33:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160203090357.GA31828@vireshk>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160203082700.GZ31828@vireshk>
 <56B1BD71.2050403@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B1BD71.2050403@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-02-16, 14:12, Shilpasri G Bhat wrote:
> I need the chip-id in the <attr>_show(). With just sysfs_create_group() I will
> get the cpufreq_global_kobject in the <attr>_show() and I will not be able to
> figure out the chip-id.

The more I look at it, the more I am convinced that keeping this
'chip' directory in /sys/devices/system/cpu/cpuX/cpufreq/ makes sense.

So, here is the deal:
- A 'chip' on your platforms can contain multiple group of CPUs, which
  are represented by policies in cpufreq core. i.e. A chip can have
  multiple policies.
- All CPUs present on the same chip are subject to same throttling
  outcomes.
- Right now you are putting the 'chip' directory in cpu/cpufreq/
  directory. Because that directory isn't specific to a policy, but
  entire cpufreq subsystem, you can't get a policy->cpu in the code
  for the kobject in question. And so you are *forced* to create a
  kobject, so that you can do container_of() and get chip->id.
- And then you also need to unnecessarily add another field in the
  chip directory 'chip_mask', that is nothing but an bitwise OR
  operation on policy->related_cpus, so that userspace can know which
  policies/CPUs are managed by the 'chip'.

What I can suggest is:
- Move this directory inside cpuX/cpufreq/ directory, in a similar way
  as to how we create 'stats' directory today.
- You can then get policy->cpu, to get chip->id out of it.
- The only disadvantage here is that the same chip directory will be
  replicated in multiple policies, but that makes it more readable.

Thoughts ?

-- 
viresh
