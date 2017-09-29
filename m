Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3Wrf62rtzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 23:00:50 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8TD0bt2036075
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 09:00:48 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d9pk9rcyt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 09:00:45 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 29 Sep 2017 23:00:28 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8TD0OlB49741910
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 23:00:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8TD0DH1016994
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 23:00:15 +1000
Subject: Re: [PATCH v8 6/6] powerpc/fadump: use the new parse_args callback
 arguments
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Jason Baron <jbaron@akamai.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Daniel Axtens
 <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Neuling <mikey@neuling.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Sylvain 'ythier' Hitier" <sylvain.hitier@gmail.com>,
 David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Steven Rostedt," <rostedt@goodmis.org>,
 Michal Hocko <mhocko@suse.com>, Laura Abbott <lauraa@codeaurora.org>,
 Tejun Heo <tj@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Lokesh Vutla <lokeshvutla@ti.com>, Baoquan He <bhe@redhat.com>,
 Ilya Matveychikov <matvejchikov@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
 <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 29 Sep 2017 18:30:13 +0530
MIME-Version: 1.0
In-Reply-To: <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <12256349-cdac-8e66-699f-095873ed2809@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In case, someone wishes for a changelog:


With fadump_rework_cmdline_params() function, parse_args() callback 
function,

taking new arguments - current & next, use them to process 
'fadump_extra_args='

parmeter, in enforcing the parameters passed through it for fadump kernel.


On Tuesday 12 September 2017 09:31 PM, Michal Suchanek wrote:
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>   arch/powerpc/kernel/fadump.c | 47 ++++++++++++--------------------------------
>   1 file changed, 13 insertions(+), 34 deletions(-)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 8778e1cc0380..1678d99ea835 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -481,33 +481,19 @@ struct param_info {
>   };
>
>   static void __init fadump_update_params(struct param_info *param_info,
> -					char *param, char *val)
> +					char *param, char *val,
> +					char *currant, char *next)
>   {
> -	ptrdiff_t param_offset = param - param_info->tmp_cmdline;
> +	ptrdiff_t param_offset = currant - param_info->tmp_cmdline;
>   	size_t vallen = val ? strlen(val) : 0;
>   	char *tgt = param_info->cmdline + param_offset
>   				- param_info->shortening;
> -	int shortening = 0;
> -	int quoted = 0;
> +	int shortening = ((next - 1) - (currant))
> +		- (FADUMP_EXTRA_ARGS_LEN + 1 + vallen);
>
>   	if (!val)
>   		return;
>
> -	/* leading '"' removed from parameter */
> -	if ((param > param_info->tmp_cmdline) && *(param - 1) == '"') {
> -		quoted = 1;
> -		shortening += 1;
> -		tgt--;
> -	}
> -
> -	/* next_arg removes one leading and one trailing '"' */
> -	if ((*(tgt + FADUMP_EXTRA_ARGS_LEN + 1 + vallen + shortening) == '"') &&
> -	    (quoted || (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1) == '"'))) {
> -		shortening += 1;
> -		if (!quoted)
> -			shortening += 1;
> -	}
> -
>   	/* remove one leading and one trailing quote if both are present */
>   	if ((val[0] == '"') && (val[vallen - 1] == '"')) {
>   		shortening += 2;
> @@ -515,22 +501,15 @@ static void __init fadump_update_params(struct param_info *param_info,
>   		val++;
>   	}
>
> -	/* some characters were removed - move the trailing part of cmdline */
> -	if (shortening) {
> -		char *src;
> +	strncpy(tgt, FADUMP_EXTRA_ARGS_PARAM, FADUMP_EXTRA_ARGS_LEN);
> +	tgt += FADUMP_EXTRA_ARGS_LEN;
> +	*tgt++ = ' ';
> +	strncpy(tgt, val, vallen);
> +	tgt += vallen;
>
> -		strncpy(tgt, FADUMP_EXTRA_ARGS_PARAM, FADUMP_EXTRA_ARGS_LEN);
> -		tgt += FADUMP_EXTRA_ARGS_LEN;
> -		*tgt++ = ' ';
> -
> -		strncpy(tgt, val, vallen);
> -		tgt += vallen;
> -
> -		src = tgt + shortening;
> +	if (shortening) {
> +		char *src = tgt + shortening;
>   		memmove(tgt, src, strlen(src) + 1);
> -	} else {
> -		/* remove the '=' */
> -		*(tgt + FADUMP_EXTRA_ARGS_LEN) = ' ';
>   	}
>
>   	param_info->shortening += shortening;
> @@ -550,7 +529,7 @@ static int __init fadump_rework_cmdline_params(char *param, char *val,
>   		     strlen(FADUMP_EXTRA_ARGS_PARAM) - 1))
>   		return 0;
>
> -	fadump_update_params(param_info, param, val);
> +	fadump_update_params(param_info, param, val, currant, next);
>
>   	return 0;
>   }


Thanks
Hari
