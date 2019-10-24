Return-Path: <SRS0=A5Gh=YR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958EECA9EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466C12166E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OSCT2Wjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466C12166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46zdCG0fK5zDqVJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 06:50:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46zZ0n335XzDqVF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 04:26:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.b="OSCT2Wjd"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46zZ0m3snQz8svl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 04:26:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 46zZ0m2jrbz9sR0; Fri, 25 Oct 2019 04:26:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.b="OSCT2Wjd"; dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by ozlabs.org (Postfix) with ESMTP id 46zZ0l5x7Bz9sQv;
 Fri, 25 Oct 2019 04:26:31 +1100 (AEDT)
Received: from [10.137.112.111] (unknown [131.107.147.111])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3B2552007698;
 Thu, 24 Oct 2019 10:26:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B2552007698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1571937990;
 bh=5R3b8oxPvTR6qGGx7vVi+OuiVSZNkllUsHU4qd/a/nE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OSCT2WjdmQ1xniyUn2/peoWgE9ycpc8Wc2ZzDicCH9kewV38vZAm5RmcKcKk8JDul
 vNhWVweVtxUsfZF4xhG/qHuI8Rd7EwsQ+Nok8m5DqU4EetWGl4pOiPxKH5SORqCBkb
 rOGzLTADWSqaGBt2UxTEU3rZBd/6AnlKTOr8YOeI=
Subject: Re: [PATCH v9 1/8] powerpc: detect the secure boot mode of the system
To: Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20191024034717.70552-1-nayna@linux.ibm.com>
 <20191024034717.70552-2-nayna@linux.ibm.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b0282ef2-f75c-a139-9991-01eba15adb22@linux.microsoft.com>
Date: Thu, 24 Oct 2019 10:26:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024034717.70552-2-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 25 Oct 2019 06:41:16 +1100
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
 Eric Ricther <erichte@linux.ibm.com>, Prakhar Srivastava <prsriva02@gmail.com>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 Elaine Palmer <erpalmer@us.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/23/2019 8:47 PM, Nayna Jain wrote:
> This patch defines a function to detect the secure boot state of a
> PowerNV system.

> +bool is_ppc_secureboot_enabled(void)
> +{
> +	struct device_node *node;
> +	bool enabled = false;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-v1");
> +	if (!of_device_is_available(node)) {
> +		pr_err("Cannot find secure variable node in device tree; failing to secure state\n");
> +		goto out;

Related to "goto out;" above:

Would of_find_compatible_node return NULL if the given node is not found?

If of_device_is_available returns false (say, because node is NULL or it 
does not find the specified node) would it be correct to call of_node_put?

> +
> +out:
> +	of_node_put(node);

  -lakshmi
