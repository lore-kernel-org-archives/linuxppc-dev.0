Return-Path: <linuxppc-dev+bounces-20057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856ACFE51F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 09:27:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g270l1YGWz2xwH;
	Fri, 24 Apr 2026 19:27:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777022871;
	cv=none; b=ZIrjBXFx8QS2GkgMQkydNWuNEvZ+qdugPzoGC+/Gy5KDjx8RUcLDjDpSQbUnei4u7B2jV7qEHAvfjNd1YNMukOnp4jU72UQty6QSFfc1ZZXRRFVnTpuJMsml+01alGmUoeDp9fOMB2wXPhzyKuCssrMN7JhTLvctdLjHhbu3QpnXfbdX1YIY8JMOrwWvP5TXJcKEUD8KrYsrwlg8PVf7P5GmUb1qEEAAQoB6Lxsup+CATa+iTkg+UYkz+92sXaw8mJUeFaQ7thisYCJ5WQP67E0w5tX7xf7Ij0s6W16XFMQxeKCx4vDhSfDusHVJH4BsC7isr4gIrMuOF+rIzD0yqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777022871; c=relaxed/relaxed;
	bh=aQGPdSUZArT+x56gw3hYUPcGQkhIE6zaM5Sc2CVHtBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiKtlzMiPo0Ult6zU2ue3Wdr7AXLZhFImIjrHtwWm4guFv7Kxx7x/TnYPa6/1ql2b4PvPBdUOHbkGX9XNsnXp6cTf+p3EuFytjtfdpAF2pqKWbxzo5qDgHMlEhJKrkaQTUGV3WOCPv0CyWdEEov44TeP69AOJeyGRc8zBsVQ0k1lvkw2xisP0FYIgT0/poSr7kPIIH12+I7tKpqVl3buC+2t9JKi8UxkX88YYTK7cAEy9xok+GIFOvaUohC2npSeUaY+kDRomqll+WK1xpz/2Vp9ST6Q7kdaH8ov8UFimQ5KwuBF+ZxmtEffWn8wul8e3Y+QZp+KNYB9lAJGAh+qwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PWy54yGE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=james.clark@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PWy54yGE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=james.clark@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g270h4Txmz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 19:27:47 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso104471285e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777022864; x=1777627664; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQGPdSUZArT+x56gw3hYUPcGQkhIE6zaM5Sc2CVHtBo=;
        b=PWy54yGE/f/YB2gtbQMHx2J4uAK24Wwl1N2Cqo7lViPZmccokBKwDV5FG935rk4cGl
         v4BoaYNW0t6A+ySIPKiz7GMqJ66v+atTeiiETYR7X/wfTEGCsl8Dpg0b3cSsolkZF16r
         lxuOTl7gq+7Ib7cAs3kazuEv8HDGXOEKDo97H2vPu+VJpTGUSgrHZGDOfkuAUlK+Io7C
         /K9LpIoVa8rEdJ5lI1QwML2ZjnoweeOOb2JPRHbQYcbcBa3JrTCvWDghSj00IJVkT15W
         pUWdMXPB11nMX8zlbPkS1knT5+80Kn91mVRSY2g2PzH3SyIKoxi9OBrN1ZDRwDXZde9i
         DSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777022864; x=1777627664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQGPdSUZArT+x56gw3hYUPcGQkhIE6zaM5Sc2CVHtBo=;
        b=VDm+ePb/Rpeb3owAZFRI0sGo9AHDjSNbVbQAhicToL2fdX0/BkVfSiTGte5iQwjT5b
         QeWZNkR5e+Os80oqZdnpZAT5SAFFVagt1aNoNda26+XG6V84lXN03vsuy+hxdmNIllg1
         NWwA+5Q6fxWv1HobvRmJOPcDDm9hb4GQtTCz3Ud5I2CiVbVTPqOH8KRkf7U4EBS8ZcT9
         +dTvnGWo7CPf8xGPpdW7hCN4IP0eOX4EzEAV6dA/WM7n8akSnc8fSPv9BjMTo3AkQWCq
         AHtRAHiQ1xoVhsM7i5AGMsEJ32a0xAsNeWLbMm+OXoNMmtTZN8oZ3SQM8nc/2HApCVYo
         Sv4g==
X-Forwarded-Encrypted: i=1; AFNElJ9qDGmOf8zhdyx5+cpQrcwExf56KVKuefg8BxRjD9GgYt0T/OBLX3FIuEg33rhJzUXHVH0vZrAYuf7XKOo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyv9s6bUpigvnki2msY5HgszGcOSPOwQ6ve3YFHZXHDVWxHdoQT
	NELIuLh64tCUVq+ptR0siFah579v3tsptRstEyQZBgI1MIZGz/rVWXUy1J8VvbHZsro=
X-Gm-Gg: AeBDietKEkhpujFIgrcnWo20EKtg+gXNTxOkirLtflXuMc+ybYZGOzoKmfajpCCr4Xl
	CiT3PamesffEFjQcmbiMp8pgMWf5SHaE430IBg/cXtCK4dCzxzE5C74QrYjuc+PSrOsHOJa3uhq
	lJj1VXR59Jeoy9dy8S3kZ23UcynILptjK7O66ev4Kh40LXmHzXwbayX+TJ7TYjqzlfEzJtizhRL
	/x9swGejlyPfaGYPLGpEqK+FIAly/GIoTwbHdTZ8t6gJRhVYM3wqqVJMgMjPjzPnDao6EE36dTR
	Yp28GMixpAHhXP+Jc6HUcdWcQZXjRBSNZ6BK4R132pqZUAcOljuBMLuK/ZMnvMRg1GbvRF7yROL
	xgVTXcSnXy+AXsfrgEOS5ENWRgQFN/5/yahJUgEvryClLlTbwgEZ8GTvdDlkntR+ojPXySJBhy9
	JKDMrntUQbo42beTneJ3UxUxCgi04bp0Emr2ZMQY1NkKE=
X-Received: by 2002:a05:600c:c09c:b0:48a:5363:8cac with SMTP id 5b1f17b1804b1-48a53638e07mr183977195e9.22.1777022864225;
        Fri, 24 Apr 2026 02:27:44 -0700 (PDT)
Received: from [192.168.178.64] ([84.246.200.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm59874331f8f.10.2026.04.24.02.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:27:43 -0700 (PDT)
Message-ID: <e6358476-d85a-441e-97e9-80abc9e1dee6@linaro.org>
Date: Fri, 24 Apr 2026 10:27:42 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched: Fix crash in sched stats diff due to
 uninitialized perf_data structure
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
 Shivani.Nittor@ibm.com, acme@kernel.org, jolsa@kernel.org,
 adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
 maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
References: <20260422173545.73144-1-atrajeev@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260422173545.73144-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/04/2026 18:35, Athira Rajeev wrote:
> perf sched stats diff fails sometimes with below logs:
> 
>   # perf sched stats record ls
> 
>   # perf sched stats diff
>    *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: terminated
>    Aborted (core dumped)
> 
> Also in some runs, perf sched stats tests fails
> 
>   ./perf test "perf sched stats tests"
>   92: perf sched stats tests                                          : FAILED!
> 
> ==172375== Conditional jump or move depends on uninitialised value(s)
> ==172375==    at 0x10393BD0: open_file_read (data.c:264)
> ==172375==    by 0x10393F63: open_file (data.c:317)
> ==172375==    by 0x10394067: open_file_dup (data.c:334)
> ==172375==    by 0x103942DF: perf_data__open (data.c:379)
> ==172375==    by 0x102F7CAF: __perf_session__new (session.c:169)
> ==172375==    by 0x100B5E63: perf_session__new (session.h:116)
> ==172375==    by 0x100D5D37: perf_sched__schedstat_diff (builtin-sched.c:4568)
> ==172375==    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
> ==172375==    by 0x1010231F: run_builtin (perf.c:348)
> ==172375==    by 0x1010262F: handle_internal_command (perf.c:398)
> ==172375==    by 0x1010286F: run_argv (perf.c:442)
> ==172375==    by 0x10102C67: main (perf.c:549)
> ==172375==
> ==172375== Conditional jump or move depends on uninitialised value(s)
> ==172375==    at 0x10393D20: open_file_read (data.c:282)
> ==172375==    by 0x10393F63: open_file (data.c:317)
> ==172375==    by 0x10394067: open_file_dup (data.c:334)
> ==172375==    by 0x103942DF: perf_data__open (data.c:379)
> ==172375==    by 0x102F7CAF: __perf_session__new (session.c:169)
> ==172375==    by 0x100B5E63: perf_session__new (session.h:116)
> ==172375==    by 0x100D5D37: perf_sched__schedstat_diff (builtin-sched.c:4568)
> ==172375==    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
> ==172375==    by 0x1010231F: run_builtin (perf.c:348)
> ==172375==    by 0x1010262F: handle_internal_command (perf.c:398)
> ==172375==    by 0x1010286F: run_argv (perf.c:442)
> ==172375==    by 0x10102C67: main (perf.c:549)
> 
> The valgrind logs and error message from the logs points to
> below snippet:
> 
>       static int open_file_read(struct perf_data *data)
>       {
>              int flags = data->in_place_update ? O_RDWR : O_RDONLY;
>              struct stat st;
>              int fd;
> 
>              fd = open(data->file.path, flags);
> 
> The "struct perf_data" is defined here :
> 
>      static int perf_sched__schedstat_diff(struct perf_sched *sched,
>                                        int argc, const char **argv)
>      {
>          struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
>          struct list_head cpu_head_ses0, cpu_head_ses1;
>          struct perf_session *session[2];
>          struct perf_data data[2];
>          int ret = 0, err = 0;
>          static const char *defaults[] = {
>                  "perf.data.old",
>                  "perf.data",
>          };
> 
> Here due to uninitialized "struct perf_data", the arguments to "open"
> is getting wrongly passed sometimes depending on value in stack.
> When perf_data__open() function calls open_file_read(),the
> "in_place_update" could contain garbage value.
> 
> After initializing "struct perf_data" in perf_sched__schedstat_diff() function,
> perf sched stats tests runs without issues in multiple attempts and also
> "perf sched stats diff" ran individual without issues.
> 
> for i in {0..20}; do ./perf test "perf sched stats tests"; done
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>   tools/perf/builtin-sched.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..5d2740099eed 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4538,7 +4538,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
>   	struct list_head cpu_head_ses0, cpu_head_ses1;
>   	struct perf_session *session[2];
> -	struct perf_data data[2];
> +	struct perf_data data[2] = { 0 };
>   	int ret = 0, err = 0;
>   	static const char *defaults[] = {
>   		"perf.data.old",

Reviewed-by: James Clark <james.clark@linaro.org>

I had a quick look for other instances of the same thing and didn't see any.


