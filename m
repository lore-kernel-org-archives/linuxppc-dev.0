Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL52Y32WPzDqgc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 21:43:16 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id um11so5336147pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 04:43:16 -0700 (PDT)
Date: Thu, 2 Jun 2016 17:13:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rafael Wysocki <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linaro-kernel@lists.linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/8] cpufreq: powerenv: Fix memory leak
Message-ID: <20160602114311.GR3725@vireshk-i7>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
 <f67b4b395c777a3e933ab51eafcd76b1299bf1fb.1464776797.git.viresh.kumar@linaro.org>
 <1464865688.11826.1.camel@ellerman.id.au>
 <20160602112203.GO3725@vireshk-i7>
 <1464867465.11826.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464867465.11826.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02-06-16, 21:37, Michael Ellerman wrote:
> On Thu, 2016-06-02 at 16:52 +0530, Viresh Kumar wrote:
> > On 02-06-16, 21:08, Michael Ellerman wrote:
> > > On Wed, 2016-06-01 at 16:04 +0530, Viresh Kumar wrote:
> > > 
> > > > The policy is copied (unnecessarily) and is never freed. Fix it by just
> > > > getting a reference to the existing policy structure and putting it
> > > > back.
> > > > 
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > 
> > > When was it broken, always?
> > > 
> > > Cc: stable ?
> > 
> > Its a small memory leak and its not that we will fail on something. So
> > didn't bother to add those details, but in case they are required:
> > 
> > Cc: <stable@vger.kernel.org> # 4.3+
> > Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
> 
> OK. I can't actually see where the copy is?
> 
> But if we are leaking even a small amount of memory in a loop like that, in a
> function that's run semi-regularly, then it's going to add up eventually.

Urg, it wasn't a memory leak actually. I misread.

I somehow thought that cpufreq_get_policy() is also allocating memory
for the policy, but it just memcpy's it into the callers buffer. So,
that's not a problem really.

This patch should be just dropped. Sorry for the noise.

-- 
viresh
