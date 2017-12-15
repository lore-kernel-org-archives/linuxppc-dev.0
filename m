Return-Path: <srs0=gpzr=dl=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz2Y90w8bzDsFl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 07:47:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yz2Y838Gtz8w0c
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 07:47:08 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yz2Y74VwNz9sCZ
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2017 07:47:06 +1100 (AEDT)
Date: Fri, 15 Dec 2017 21:47:02 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Andrew Morton
 <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Ankit
 Kumar <ankit@linux.vnet.ibm.com>, Mahesh J Salgaonkar
 <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 2/8] boot/param: add pointer to current and next
 argument to unknown parameter callback
Message-ID: <20171215214702.7c7afba1@kitsune.suse.cz>
In-Reply-To: <151075902585.14434.14102853902713018755.stgit@hbathini.in.ibm.com>
References: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
 <151075902585.14434.14102853902713018755.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, 15 Nov 2017 20:47:14 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> From: Michal Suchanek <msuchanek@suse.de>
> 
> Add pointer to current and next argument to make parameter processing
> more robust. This can make parameter processing easier and less error
> prone in cases where the parameters need to be enforced/ignored based
> on firmware/system state.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

> @@ -179,16 +183,18 @@ char *parse_args(const char *doing,
>  	if (*args)
>  		pr_debug("doing %s, parsing ARGS: '%s'\n", doing,
> args); 
> -	while (*args) {
> +	next = next_arg(args, &param, &val);
> +	while (*next) {
>  		int ret;
>  		int irq_was_disabled;
>  
> -		args = next_arg(args, &param, &val);
> +		args = next;
> +		next = next_arg(args, &param, &val);
>  		/* Stop at -- */

The [PATCH v8 5/6] you refreshed here moves the while(*next) to the end
of the cycle for a reason. Checking *args at the start is mostly
equivalent checking *next at the end. Checking *next at the start on
the other hand skips the last argument.

The "mostly" part is that there is a bug here because *args is not
checked at the start of the cycle making it possible to crash if it is
0. To fix that the if(*args) above should be extended to wrap the cycle.

Thanks

Michal
