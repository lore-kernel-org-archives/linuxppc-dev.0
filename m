Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL4wJ2lFXzDqZK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 21:37:52 +1000 (AEST)
Message-ID: <1464867465.11826.4.camel@ellerman.id.au>
Subject: Re: [PATCH 3/8] cpufreq: powerenv: Fix memory leak
From: Michael Ellerman <mpe@ellerman.id.au>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linaro-kernel@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Thu, 02 Jun 2016 21:37:45 +1000
In-Reply-To: <20160602112203.GO3725@vireshk-i7>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
 <f67b4b395c777a3e933ab51eafcd76b1299bf1fb.1464776797.git.viresh.kumar@linaro.org>
 <1464865688.11826.1.camel@ellerman.id.au>
 <20160602112203.GO3725@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-02 at 16:52 +0530, Viresh Kumar wrote:
> On 02-06-16, 21:08, Michael Ellerman wrote:
> > On Wed, 2016-06-01 at 16:04 +0530, Viresh Kumar wrote:
> > 
> > > The policy is copied (unnecessarily) and is never freed. Fix it by just
> > > getting a reference to the existing policy structure and putting it
> > > back.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > When was it broken, always?
> > 
> > Cc: stable ?
> 
> Its a small memory leak and its not that we will fail on something. So
> didn't bother to add those details, but in case they are required:
> 
> Cc: <stable@vger.kernel.org> # 4.3+
> Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")

OK. I can't actually see where the copy is?

But if we are leaking even a small amount of memory in a loop like that, in a
function that's run semi-regularly, then it's going to add up eventually.

cheers
