Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8EDC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 04:04:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFE32145D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 04:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFzpM/rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFE32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43088r0MpfzF3ZL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 15:04:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VFzpM/rj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=viresh.kumar@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="VFzpM/rj"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43086C5MY4zF3cr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 15:02:11 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id e5so3458887plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 20:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jD4EvHrCedZPR1eexDzPL2ORdf7F23ZT49Cve3Do4Jk=;
 b=VFzpM/rj99cZDp3qxZIIexfY6MTuhoR1JaSE5kx7ieQNUZRAhWc9EBtlpfK12IN8Lw
 7V8mvks/IQdAw+FBdU6iaLfSsFIu4W5nJ+856AvK6OdGEWtCru/JE79pKqI/7/CG1YHA
 AV4YQ2peacZ5dmHOxHOjbKpp56Ow6O84Tl734=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jD4EvHrCedZPR1eexDzPL2ORdf7F23ZT49Cve3Do4Jk=;
 b=pD1Y5w5Jg1pCjyi79EA/UR33JNFsLgQqvTvoZAuKeDAeT+nyJUeX1wHvMDc6Mt7Lab
 /PI/8nLAWzc3SCzLl5qFi0OmJ5e1LzDPaUG1+bvKWkckq0z1fIWA3nSrVnOQg/un/PYk
 3PlUUsda9oR6T2WyYpQHHj0w+kXnXhOpuXhLTLNUcw1RYDxLoh1eCzlCJGX8cXq9vWEJ
 dE7yfXwueK9mxp0kLZd29EIBjNCEiebowDg+aCPdY/B4tEtHdOnNSwefNyqiTxe/xv66
 E3OpGK+xOm6DKdcI/ocSf7q7H4zu9AX1sODstXljIvmMYwGfDGVVb3Mv2UlRPTSCo2ZY
 z4ZA==
X-Gm-Message-State: AGRZ1gJ87WGkSs1hT5SSjRGXhmmMAXmiCio/8mEnzlZYetrFHofYzp8B
 p1ReqVpfkMhvPi57T3Zu9fHquw==
X-Google-Smtp-Source: AJdET5dSYVv/OYuLZcPm682fOnYbEGXb48aLJ5I+vClFCRu/muv+BzGEIYtFozKmakVA82Owt2SSyQ==
X-Received: by 2002:a62:d449:: with SMTP id
 u9-v6mr5181318pfl.116.1542772929966; 
 Tue, 20 Nov 2018 20:02:09 -0800 (PST)
Received: from localhost ([122.172.88.116])
 by smtp.gmail.com with ESMTPSA id t78-v6sm80135659pfk.59.2018.11.20.20.02.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Nov 2018 20:02:09 -0800 (PST)
Date: Wed, 21 Nov 2018 09:32:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v2] cpufreq: powernv: add of_node_put()
Message-ID: <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
References: <20181120160530.21015-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120160530.21015-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
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
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 20-11-18, 11:05, Yangtao Li wrote:
> The of_find_node_by_path() returns a node pointer with refcount
> incremented,but there is the lack of use of the of_node_put() when
> done.Add the missing of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2
> -update changelog
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
