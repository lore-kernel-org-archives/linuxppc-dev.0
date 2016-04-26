Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3qv3Kh3K5LzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 10:06:32 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>, Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com,
 yuantian.tang@nxp.com
Subject: Re: [PATCH 2/2] cpufreq: qoriq: Don't show cooling device messages if
 THERMAL_OF undefined
Date: Tue, 26 Apr 2016 02:02:50 +0200
Message-ID: <85987216.08EdccM4Dt@vostro.rjw.lan>
In-Reply-To: <20160418103345.GE2322@vireshk-i7>
References: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
 <1460966372-4877-2-git-send-email-hongtao.jia@nxp.com>
 <20160418103345.GE2322@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, April 18, 2016 04:03:45 PM Viresh Kumar wrote:
> On 18-04-16, 15:59, Jia Hongtao wrote:
> > When THERMAL_OF is undefined the cooling device messages should not be
> > shown. -ENOSYS is returned from of_cpufreq_cooling_register() when
> > THERMAL_OF is undefined.
> > 
> > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > ---
> >  drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> > index 1c2fdc1..ff8da83 100644
> > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > @@ -340,8 +340,8 @@ static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
> >  		cpud->cdev = of_cpufreq_cooling_register(np,
> >  							 policy->related_cpus);
> >  
> > -		if (IS_ERR(cpud->cdev)) {
> > -			pr_err("Failed to register cooling device cpu%d: %ld\n",
> > +		if (IS_ERR(cpud->cdev) && PTR_ERR(cpud->cdev) != -ENOSYS) {
> > +			pr_err("cpu%d is not running as cooling device: %ld\n",
> >  					policy->cpu, PTR_ERR(cpud->cdev));
> >  
> >  			cpud->cdev = NULL;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
