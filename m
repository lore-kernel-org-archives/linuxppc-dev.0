Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3ACC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:09:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF3E2087E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF3E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p6MW5QCSzDqGY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 22:09:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jolsa@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p6Kc53gxzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 22:07:29 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE841C004BFB;
 Mon, 28 Jan 2019 11:07:26 +0000 (UTC)
Received: from krava (unknown [10.40.205.232])
 by smtp.corp.redhat.com (Postfix) with SMTP id C9804611D4;
 Mon, 28 Jan 2019 11:07:23 +0000 (UTC)
Date: Mon, 28 Jan 2019 12:07:22 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf mem/c2c: Fix perf_mem_events to support powerpc
Message-ID: <20190128110722.GB15461@krava>
References: <20190114041402.14033-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114041402.14033-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 28 Jan 2019 11:07:27 +0000 (UTC)
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
Cc: dzickus@redhat.com, maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, fowles@inreach.com, jmario@redhat.com, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 14, 2019 at 09:44:02AM +0530, Ravi Bangoria wrote:

SNIP

> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> new file mode 100644
> index 0000000..5b4dcfe
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "mem-events.h"
> +
> +struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> +	PERF_MEM_EVENT("ldlat-loads", "cpu/mem-loads,ldlat=%u/P", "mem-loads"),
> +	PERF_MEM_EVENT("ldlat-stores", "cpu/mem-stores/P", "mem-stores"),
> +};
> +
> +static char mem_loads_name[100];
> +static bool mem_loads_name__init;
> +
> +char *perf_mem_events__name(int i)
> +{
> +	if (i == PERF_MEM_EVENTS__LOAD) {
> +		if (!mem_loads_name__init) {
> +			mem_loads_name__init = true;
> +			scnprintf(mem_loads_name, sizeof(mem_loads_name),
> +				  perf_mem_events[i].name,
> +				  perf_mem_events__loads_ldlat);
> +		}
> +		return mem_loads_name;
> +	}
> +
> +	return (char *)perf_mem_events[i].name;
> +}
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 93f74d8..1ffefd3 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -15,31 +15,13 @@
>  
>  unsigned int perf_mem_events__loads_ldlat = 30;
>  
> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
> -
> -struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> -	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"mem-loads"),
> -	E("ldlat-stores",	"cpu/mem-stores/P",		"mem-stores"),
> +struct perf_mem_event __weak perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> +	PERF_MEM_EVENT("ldlat-loads", "cpu/mem-loads/P", "mem-loads"),
> +	PERF_MEM_EVENT("ldlat-stores", "cpu/mem-stores/P", "mem-stores"),
>  };

I dont think perf_mem_events array needs to be overloaded as well,
the perf_mem_events__name function should be enough no?

thanks,
jirka
