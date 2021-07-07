Return-Path: <SRS0=hpF1=L7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D421EC07E95
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Jul 2021 14:05:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5975E61C92
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Jul 2021 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5975E61C92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GKh5c70wgz3035
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Jul 2021 00:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jw9QDbbo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=acme@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jw9QDbbo; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GKh543q8Dz300b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jul 2021 00:04:56 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C810C61C92;
 Wed,  7 Jul 2021 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625666692;
 bh=X05+giyFKsVT+sh0hnEHJ5D9wx29IQi/oJ6RZCCiYdc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jw9QDbboQVZmhJTdpYKUBDl5Urg8AOtcJ1QcxY+8FidTj0Qsdc6Ya7EXPDznObwfU
 jkeLZzQ7OE4HyTFk4vUuIEDUv757Vf7BcEpdhCI3EjpWwzCn0pzJUrLGqrXFDhGjNs
 OvAOFNolWWTIED7BlLP4MI+QgazZICx1UIirNIRa4P1lKUq+pcEFJxQgX89jqu3ovQ
 Fd5zgVv6ROfuCjczgWuRMLt5STOmLgPBSeEnZTpT34aFunQlzZd6lCPJT5UA321LxL
 jJijpFNGL2n4xTOvo/UPFmqQGRPFYOjkGn1lWbzOzPU2FFLzOYkBP9w1fc+FMddedL
 rJIcTENISNdOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id 1A48F40B1A; Wed,  7 Jul 2021 11:04:49 -0300 (-03)
Date: Wed, 7 Jul 2021 11:04:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH] perf script python: Fix buffer size to report iregs in
 perf script
Message-ID: <YOW0gU4yNpgN8MjB@kernel.org>
References: <20210628062341.155839-1-kjain@linux.ibm.com>
 <20210628144937.GE142768@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <ee98968a-f343-a68e-9a3e-58e97dc130c8@linux.ibm.com>
 <c6fb2136-21e1-325a-f7f7-9745dbe29661@linux.ibm.com>
 <YOSr25+a+r3MF2Ob@kernel.org>
 <d59266da-2aa6-69ff-646b-144ba874ee2f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59266da-2aa6-69ff-646b-144ba874ee2f@linux.ibm.com>
X-Url: http://acmel.wordpress.com
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
Cc: ravi.bangoria@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
 rnsastry@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 maddy@linux.vnet.ibm.com, "Paul A. Clarke" <pc@us.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, Jul 07, 2021 at 11:16:20AM +0530, kajoljain escreveu:
> On 7/7/21 12:45 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 06, 2021 at 05:26:12PM +0530, kajoljain escreveu:
> >> On 6/29/21 12:39 PM, kajoljain wrote:
> >>> On 6/28/21 8:19 PM, Paul A. Clarke wrote:
> >>>> On Mon, Jun 28, 2021 at 11:53:41AM +0530, Kajol Jain wrote:
> >>>>> @@ -713,7 +711,16 @@ static void set_regs_in_dict(PyObject *dict,
> >>>>>  			     struct evsel *evsel)
> >>>>>  {
> >>>>>  	struct perf_event_attr *attr = &evsel->core.attr;
> >>>>> -	char bf[512];
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * Here value 28 is a constant size which can be used to print
> >>>>> +	 * one register value and its corresponds to:
> >>>>> +	 * 16 chars is to specify 64 bit register in hexadecimal.
> >>>>> +	 * 2 chars is for appending "0x" to the hexadecimal value and
> >>>>> +	 * 10 chars is for register name.
> >>>>> +	 */
> >>>>> +	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
> >>>>> +	char bf[size];

> >>>> I propose using a template rather than a magic number here. Something like:
> >>>> const char reg_name_tmpl[] = "10 chars  ";
> >>>> const char reg_value_tmpl[] = "0x0123456789abcdef";
> >>>> const int size = __sw_hweight64(attr->sample_regs_intr) +
> >>>>                  sizeof reg_name_tmpl + sizeof reg_value_tmpl;

> >>>    Thanks for reviewing the patch. Yes these are
> >>> some standardization we can do by creating macros for different
> >>> fields.
> >>> The basic idea is, we want to provide significant buffer size
> >>> based on number of registers present in sample_regs_intr to accommodate
> >>> all data.

> >>    Is the approach used in this patch looks fine to you?

> > Yeah, and the comment you provide right above it explains it, so I think
> > that is enough, ok?
 
>     Thanks for reviewing it. As you said added comment already explains
> why we are taking size constant as 28, should we skip adding macros part?
> Can you pull this patch.

Sure.

- Arnaldo
