Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F45C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 14:56:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3A12189D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucKcS+rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3A12189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JTMM4bpzzDrDZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 00:55:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ucKcS+rJ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JT7b1snXzDqXQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 00:45:46 +1000 (AEST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net
 [24.9.64.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E85EF2077B;
 Wed, 28 Aug 2019 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567003544;
 bh=vneSpYWc4gWpu4W6gxC/dr26+W3sYZi98+pPPJepJB0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ucKcS+rJhzYEk6AK3752Inb4Zx4CTZgBJG43fvi3Wdb+3+BkPSB+RUS8Zmie1Jzlu
 Hq9OuhmtffrrXHw2Ea3LeSm5kWb4cdvt3Ltm3G8h33of/sNQp19TtalYFb7isCAgwc
 sb8Xm3J+E60E8aA8fzkjhV2WzEH80FJ6yeUVfd7M=
Subject: Re: [PATCH] sefltest/ima: support appended signatures (modsig)
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <1566995946-6582-1-git-send-email-zohar@linux.ibm.com>
From: shuah <shuah@kernel.org>
Message-ID: <2f89d09f-1b69-3d77-6846-01bef7d20f39@kernel.org>
Date: Wed, 28 Aug 2019 08:45:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566995946-6582-1-git-send-email-zohar@linux.ibm.com>
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
Cc: shuah <shuah@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
 linux-kselftest@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mimi,

On 8/28/19 6:39 AM, Mimi Zohar wrote:
> Detect and allow appended signatures.
> 

Can you please add a couple of more sentences on the feature
and what happens without it? I know this is a test for the
feature, however, it will be useful for users and testers to
know more about this test and the feature it is testing.

Also, are there test skip conditions to be concerned about?

Is there a dependency on another tree or would like me to take
this through kselftest tree?

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   .../selftests/kexec/test_kexec_file_load.sh        | 38 +++++++++++++++++++---
>   1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
> index fa7c24e8eefb..2ff600388c30 100755
> --- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
> +++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
> @@ -37,11 +37,20 @@ is_ima_sig_required()
>   	# sequentially.  As a result, a policy rule may be defined, but
>   	# might not necessarily be used.  This test assumes if a policy
>   	# rule is specified, that is the intent.
> +
> +	# First check for appended signature (modsig), then xattr
>   	if [ $ima_read_policy -eq 1 ]; then
>   		check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
> -			"appraise_type=imasig"
> +			"appraise_type=imasig|modsig"
>   		ret=$?
> -		[ $ret -eq 1 ] && log_info "IMA signature required";
> +		if [ $ret -eq 1 ]; then
> +			log_info "IMA or appended(modsig) signature required"
> +		else
> +			check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
> +				"appraise_type=imasig"
> +			ret=$?
> +			[ $ret -eq 1 ] && log_info "IMA signature required";
> +		fi
>   	fi
>   	return $ret
>   }
> @@ -84,6 +93,22 @@ check_for_imasig()
>   	return $ret
>   }
>   
> +# Return 1 for appended signature (modsig) found and 0 for not found.
> +check_for_modsig()
> +{
> +	local module_sig_string="~Module signature appended~"
> +	local sig="$(tail --bytes $((${#module_sig_string} + 1)) $KERNEL_IMAGE)"
> +	local ret=0
> +
> +	if [ "$sig" == "$module_sig_string" ]; then
> +		ret=1
> +		log_info "kexec kernel image modsig signed"
> +	else
> +		log_info "kexec kernel image not modsig signed"
> +	fi
> +	return $ret
> +}
> +
>   kexec_file_load_test()
>   {
>   	local succeed_msg="kexec_file_load succeeded"
> @@ -98,7 +123,8 @@ kexec_file_load_test()
>   		# In secureboot mode with an architecture  specific
>   		# policy, make sure either an IMA or PE signature exists.
>   		if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] && \
> -			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ]; then
> +			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ] \
> +			  && [ $ima_modsig -eq 0 ]; then
>   			log_fail "$succeed_msg (missing sig)"
>   		fi
>   
> @@ -107,7 +133,8 @@ kexec_file_load_test()
>   			log_fail "$succeed_msg (missing PE sig)"
>   		fi
>   
> -		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
> +		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ] \
> +		     && [ $ima_modsig -eq 0 ]; then
>   			log_fail "$succeed_msg (missing IMA sig)"
>   		fi
>   
> @@ -204,5 +231,8 @@ pe_signed=$?
>   check_for_imasig
>   ima_signed=$?
>   
> +check_for_modsig
> +ima_modsig=$?
> +
>   # Test loading the kernel image via kexec_file_load syscall
>   kexec_file_load_test
> 

thanks,
-- Shuah
