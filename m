Return-Path: <SRS0=EHb9=YY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC30CA9ECB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 17:04:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E309208C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F5KUaId1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E309208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473s9y4LmvzF5t6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 04:04:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473s7T4hH5zF3rq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2019 04:02:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.b="F5KUaId1"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 473s7S5Rktz8t81
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2019 04:02:12 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 473s7S2yxvz9sPj; Fri,  1 Nov 2019 04:02:12 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.b="F5KUaId1"; dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by ozlabs.org (Postfix) with ESMTP id 473s7R2d2Kz9sNw;
 Fri,  1 Nov 2019 04:02:11 +1100 (AEDT)
Received: from [10.137.112.108] (unknown [131.107.174.108])
 by linux.microsoft.com (Postfix) with ESMTPSA id 7345C20B7192;
 Thu, 31 Oct 2019 10:02:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7345C20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1572541329;
 bh=+yw069kNCIFvQ9q593dZHSUXcrJqX0PS1XrQekoDjV8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=F5KUaId1DG62vIws92rMTnOXvOMq/EocYz9ZBbzt129yzTa7rB/zbvgDTru+DVlOS
 B/Y9a8ePOFA4zKDrEDP0CYJtW1i3HFRuMEMpM7mUoLducIQj8AB9CgdMRs655eGHUK
 cCitxXwEuH5J6zqs4agM2xQKrfUtY6asHfTFZwiA=
Subject: Re: [PATCH v10 5/9] ima: make process_buffer_measurement() generic
To: Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
 <1572492694-6520-6-git-send-email-zohar@linux.ibm.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <de6077ad-6d45-ef99-3ba7-79b3c48ae944@linux.microsoft.com>
Date: Thu, 31 Oct 2019 10:02:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572492694-6520-6-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/30/19 8:31 PM, Mimi Zohar wrote:

>   void ima_kexec_cmdline(const void *buf, int size)
>   {
> -	u32 secid;
> -
> -	if (buf && size != 0) {
> -		security_task_getsecid(current, &secid);
> +	if (buf && size != 0)

Open brace { is missing in the above if statement.

>   		process_buffer_measurement(buf, size, "kexec-cmdline",
> -					   current_cred(), secid);
> -	}
> +					   KEXEC_CMDLINE, 0);
>   }

  -lakshmi
