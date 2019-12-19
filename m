Return-Path: <SRS0=TRtS=2J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E6C43603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 09:12:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA2C21D7D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 09:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA2C21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47dmPH5TvvzDqrW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 20:12:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=lionel.g.landwerlin@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47dmLq5hSRzDqrF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2019 20:10:42 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Dec 2019 01:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,331,1571727600"; d="scan'208";a="212954494"
Received: from bbartede-mobl2.ger.corp.intel.com (HELO [10.252.33.233])
 ([10.252.33.233])
 by fmsmga007.fm.intel.com with ESMTP; 19 Dec 2019 01:10:30 -0800
Subject: Re: [PATCH v4 4/9] drm/i915/perf: open access for CAP_SYS_PERFMON
 privileged process
To: Alexey Budankov <alexey.budankov@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "james.bottomley@hansenpartnership.com"
 <james.bottomley@hansenpartnership.com>, Serge Hallyn <serge@hallyn.com>,
 James Morris <jmorris@namei.org>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Casey Schaufler
 <casey@schaufler-ca.com>, Robert Richter <rric@kernel.org>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <ea050255-a125-8831-ce91-ee23bd6ad08b@linux.intel.com>
From: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
 Swindon SN3 1RJ
Message-ID: <d5f908f3-b545-7953-8c72-ceb7177609d3@intel.com>
Date: Thu, 19 Dec 2019 11:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <ea050255-a125-8831-ce91-ee23bd6ad08b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Song Liu <songliubraving@fb.com>, Andi Kleen <ak@linux.intel.com>,
 Kees Cook <keescook@chromium.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 Jann Horn <jannh@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 Igor Lubashev <ilubashe@akamai.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stephane Eranian <eranian@google.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, oprofile-list@lists.sf.net,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@redhat.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 18/12/2019 11:27, Alexey Budankov wrote:
> Open access to i915_perf monitoring for CAP_SYS_PERFMON privileged
> processes. For backward compatibility reasons access to i915_perf
> subsystem remains open for CAP_SYS_ADMIN privileged processes but
> CAP_SYS_ADMIN usage for secure i915_perf monitoring is discouraged
> with respect to CAP_SYS_PERFMON capability.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>

> ---
>   drivers/gpu/drm/i915/i915_perf.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index e42b86827d6b..e2697f8d04de 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -2748,10 +2748,10 @@ i915_perf_open_ioctl_locked(struct drm_i915_private *dev_priv,
>   	/* Similar to perf's kernel.perf_paranoid_cpu sysctl option
>   	 * we check a dev.i915.perf_stream_paranoid sysctl option
>   	 * to determine if it's ok to access system wide OA counters
> -	 * without CAP_SYS_ADMIN privileges.
> +	 * without CAP_SYS_PERFMON or CAP_SYS_ADMIN privileges.
>   	 */
>   	if (privileged_op &&
> -	    i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
> +	    i915_perf_stream_paranoid && !perfmon_capable()) {
>   		DRM_DEBUG("Insufficient privileges to open system-wide i915 perf stream\n");
>   		ret = -EACCES;
>   		goto err_ctx;
> @@ -2939,9 +2939,8 @@ static int read_properties_unlocked(struct drm_i915_private *dev_priv,
>   			} else
>   				oa_freq_hz = 0;
>   
> -			if (oa_freq_hz > i915_oa_max_sample_rate &&
> -			    !capable(CAP_SYS_ADMIN)) {
> -				DRM_DEBUG("OA exponent would exceed the max sampling frequency (sysctl dev.i915.oa_max_sample_rate) %uHz without root privileges\n",
> +			if (oa_freq_hz > i915_oa_max_sample_rate && !perfmon_capable()) {
> +				DRM_DEBUG("OA exponent would exceed the max sampling frequency (sysctl dev.i915.oa_max_sample_rate) %uHz without CAP_SYS_PERFMON or CAP_SYS_ADMIN privileges\n",
>   					  i915_oa_max_sample_rate);
>   				return -EACCES;
>   			}
> @@ -3328,7 +3327,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
>   		return -EINVAL;
>   	}
>   
> -	if (i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
> +	if (i915_perf_stream_paranoid && !perfmon_capable()) {
>   		DRM_DEBUG("Insufficient privileges to add i915 OA config\n");
>   		return -EACCES;
>   	}
> @@ -3474,7 +3473,7 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
>   		return -ENOTSUPP;
>   	}
>   
> -	if (i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
> +	if (i915_perf_stream_paranoid && !perfmon_capable()) {
>   		DRM_DEBUG("Insufficient privileges to remove i915 OA config\n");
>   		return -EACCES;
>   	}


