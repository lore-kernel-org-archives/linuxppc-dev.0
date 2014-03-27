Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f53.google.com (mail-oa0-f53.google.com
 [209.85.219.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8C7C2140132
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 21:22:04 +1100 (EST)
Received: by mail-oa0-f53.google.com with SMTP id j17so3980927oag.26
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 03:22:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140327101137.GA8747@dirshya.in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
 <20140327101137.GA8747@dirshya.in.ibm.com>
Date: Thu, 27 Mar 2014 15:52:01 +0530
Message-ID: <CAKohpokqQGZPSsPXNeteEPu-HvDZtqvWPfFY+naWXkRAtXB_nA@mail.gmail.com>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27 March 2014 15:41, Vaidyanathan Srinivasan
<svaidy@linux.vnet.ibm.com> wrote:
>> > Why do you need to get these from DT? And not find that yourself here instead?

> DT provides the values that we should use.  Ideally these are the
> upper and lower limits of the PState table,  however as per the
> platform spec, we should use the PState IDs between these limits.  We
> would like to parse it and keep it in the driver for debug purposes.
>
> The platform exports this info in the DT to be more explicit and not
> have a strong dependency on the PState numbering or PState table
> itself.  In the driver we parse it for debug/validation purpose.

I couldn't find how they are used for debugging except this:

+ pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
+ pstate_nominal, pstate_max);

This is the only place where these values are used.

Anyway, you can keep it if you really want to..
