Return-Path: <SRS0=3PCM=VH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B84C73C7C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 10:08:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D4D20838
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 10:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D4D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kFJm1PtNzDqdG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 20:08:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rjwysocki.net
 (client-ip=79.96.170.134; helo=cloudserver094114.home.pl;
 envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rjwysocki.net
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kFGj65SQzDqcN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 20:07:08 +1000 (AEST)
Received: from 79.184.253.121.ipv4.supernova.orange.pl (79.184.253.121) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id fb1402abfa64d0e0; Wed, 10 Jul 2019 12:07:03 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>, Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH v5] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Date: Wed, 10 Jul 2019 12:07:03 +0200
Message-ID: <2173177.H4fXhsoBLG@kreacher>
In-Reply-To: <20190709081205.a5sjsqo2el6zt24b@vireshk-i7>
References: <1562659447-39989-1-git-send-email-wen.yang99@zte.com.cn>
 <20190709081205.a5sjsqo2el6zt24b@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: wang.yi59@zte.com.cn, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tuesday, July 9, 2019 10:12:05 AM CEST Viresh Kumar wrote:
> On 09-07-19, 16:04, Wen Yang wrote:
> > The cpu variable is still being used in the of_get_property() call
> > after the of_node_put() call, which may result in use-after-free.
> > 
> > Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")
> > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org

Patch applied.

> > ---
> > v5: put together the code to get, use, and release cpu device_node.
> > v4: restore the blank line.
> > v3: fix a leaked reference.
> > v2: clean up the code according to the advice of viresh.
> > 
> >  drivers/cpufreq/pasemi-cpufreq.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> > index 6b1e4ab..1f0beb7 100644
> > --- a/drivers/cpufreq/pasemi-cpufreq.c
> > +++ b/drivers/cpufreq/pasemi-cpufreq.c
> > @@ -131,10 +131,17 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	int err = -ENODEV;
> >  
> >  	cpu = of_get_cpu_node(policy->cpu, NULL);
> > -
> > -	of_node_put(cpu);
> >  	if (!cpu)
> >  		goto out;
> 
> I would have loved a blank line here :)

And I added the blank line.

> > +	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
> > +	of_node_put(cpu);
> > +	if (!max_freqp) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/* we need the freq in kHz */
> > +	max_freq = *max_freqp / 1000;
> >  
> >  	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
> >  	if (!dn)
> > @@ -171,16 +178,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	}
> >  
> >  	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
> > -
> > -	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
> > -	if (!max_freqp) {
> > -		err = -EINVAL;
> > -		goto out_unmap_sdcpwr;
> > -	}
> > -
> > -	/* we need the freq in kHz */
> > -	max_freq = *max_freqp / 1000;
> > -
> >  	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
> >  	pr_debug("initializing frequency table\n");
> 
> Though, enough versions have happened now.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Thanks!



