Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D9C6783B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6577B2084A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6577B2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DcCb5D38zDr49
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 21:50:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rjwysocki.net
 (client-ip=79.96.170.134; helo=cloudserver094114.home.pl;
 envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rjwysocki.net
X-Greylist: delayed 317 seconds by postgrey-1.36 at bilbo;
 Tue, 11 Dec 2018 21:48:06 AEDT
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dc9L5W4VzDqy9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 21:48:06 +1100 (AEDT)
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 7b48bb81d93096dd; Tue, 11 Dec 2018 11:48:03 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v2] cpufreq: pmac64: add of_node_put()
Date: Tue, 11 Dec 2018 11:47:45 +0100
Message-ID: <1962056.WEnsRsenr7@aspire.rjw.lan>
In-Reply-To: <20181126060226.wsludir4g7bao4lk@vireshk-i7>
References: <20181123133340.26849-1-tiny.windzz@gmail.com>
 <20181126060226.wsludir4g7bao4lk@vireshk-i7>
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
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Monday, November 26, 2018 7:02:26 AM CET Viresh Kumar wrote:
> On 23-11-18, 08:33, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > g5_neo2_cpufreq_init() doesn't do that, so fix it.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Changes in v2:
> > -update changelog
> > ---
> >  drivers/cpufreq/pmac64-cpufreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> > index be623dd7b9f2..1d32a863332d 100644
> > --- a/drivers/cpufreq/pmac64-cpufreq.c
> > +++ b/drivers/cpufreq/pmac64-cpufreq.c
> > @@ -411,6 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
> >  		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
> >  		pfunc_vdnap0_complete =
> >  			pmf_find_function(root, "slewing-done");
> > +		of_node_put(root);
> >  		if (pfunc_set_vdnap0 == NULL ||
> >  		    pfunc_vdnap0_complete == NULL) {
> >  			pr_err("Can't find required platform function\n");
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!

