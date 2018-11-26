Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4477CC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:23:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B835F20664
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKntIye1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B835F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433R0c49vzzDqW2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 23:23:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OKntIye1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OKntIye1"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433QTb5cWjzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 23:00:19 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id 80so6083613pge.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 04:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rNViyPufrsfnnYANXiZFtrhhEUr5fQflgDkjdaVV2zk=;
 b=OKntIye1dh6Lg3/Ht5yWLABwot75nYxe8o2lpMwLHbUyeDsn6E1EzN8268hvDLvaHW
 /+tDHNU7qPol7ZSr+W93jXSprgFOKJjH4otTxCbbfd5uG5JfN0cVORdsEVdtZ6wmc57q
 0Ar3rF4ju0cOo2iBIPlb+E6wpBnEYQth5nZQ7FeH+1eVxrSK0z+OncVAufQdhNimGx2Y
 IiB8C3A4fJcIB444aQGBrBJtAPJu2EPQMOmpyW06W5MnlfzD6+tVatkj15JZI5SZj4GZ
 cDIsBF9AX2RHXPOOIry5abZSIQAeXWJZahEhfb2e8fiXOoObUwcb+LsvoRpzXpWcCVt3
 YOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rNViyPufrsfnnYANXiZFtrhhEUr5fQflgDkjdaVV2zk=;
 b=PPCfPm2mVw0E41tDJpLTG/Z78QYdgWQV1Mg5kzBWhGoOPIyaX1WdgbRiUzPuRUl8wh
 m9I3c9w/2Kcc9BjGyl2HOZcCTc7mWxCaDes1Pw2lQVVs1c8wTZ5Xlhh8DqELm/Dy5wOL
 KNSYC/qHmOs5Sy5T2FmyuhRKwceDrzWJ0ABNvNUinPBJt64BvFFoKkqZJtZQrGpXEfK1
 vTIggSRZQmkd1a5TzPWu/BhCayxzCMR2CY+78NL/D6588LudX4WZ24EsHUJqJ16PbTet
 MmtRV7h1eVXLrx7qVVCIUXdyJV08hFEfYWJiEnsUUYMSkmtUmQW+Nz0WuXeKFgqX0xOa
 fkUw==
X-Gm-Message-State: AA+aEWZnwVZz0SUWFSZ8LXxKdDwwCdZCRWVYhsnhtVFl+GGGCOJIH4sA
 hhCy0L8KF2t2GEN5GoRJr04=
X-Google-Smtp-Source: AFSGD/XJIzBAn3NniK4Dbx/mwuMX1WTbFZxugYVS5MLYLFfeVPGybPf7Z0DoXSxRBp7JEx3Vpk7Ebg==
X-Received: by 2002:a65:66ce:: with SMTP id c14mr24335146pgw.450.1543233617804; 
 Mon, 26 Nov 2018 04:00:17 -0800 (PST)
Received: from [10.231.245.170] ([125.29.25.186])
 by smtp.gmail.com with ESMTPSA id h134sm198548pfe.27.2018.11.26.04.00.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Nov 2018 04:00:17 -0800 (PST)
Subject: Re: [PATCH] of: add dtc annotations functionality to dtx_diff
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
References: <1543233248-8500-1-git-send-email-frowand.list@gmail.com>
Message-ID: <995152f6-3c92-8d94-308a-3da01a1def90@gmail.com>
Date: Mon, 26 Nov 2018 04:00:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543233248-8500-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Julia Lawall <julia.lawall@lip6.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

I got the cc: list wrong on this patch, please dis-regard.

I will resend (with unchanged version) to the correct cc: list.

-Frank


On 11/26/18 3:54 AM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add -T and --annotations command line arguments to dtx_diff.  These
> arguments will be passed through to dtc.  dtc will then add source
> location annotations to its output.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> This feature depends upon commit 5667e7ef9a9a ("annotations: add the
> annotation functionality") in the dtc git repository.  To use the
> new flags before the new version of dtc is imported to the linux
> kernel, download the dtc repository, compile dtc with the make command,
> then add the path of the dtc repository to the shell PATH variable.
> 
>  scripts/dtc/dtx_diff | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
> index 8c4fbad2055e..0d8572008729 100755
> --- a/scripts/dtc/dtx_diff
> +++ b/scripts/dtc/dtx_diff
> @@ -21,6 +21,7 @@ Usage:
>          diff DTx_1 and DTx_2
>  
>  
> +      --annotate    synonym for -T
>         -f           print full dts in diff (--unified=99999)
>         -h           synonym for --help
>         -help        synonym for --help
> @@ -28,6 +29,7 @@ Usage:
>         -s SRCTREE   linux kernel source tree is at path SRCTREE
>                          (default is current directory)
>         -S           linux kernel source tree is at root of current git repo
> +       -T           Annotate output .dts with input source file and line (-T -T for more details)
>         -u           unsorted, do not sort DTx
>  
>  
> @@ -174,6 +176,7 @@ compile_to_dts() {
>  
>  # -----  start of script
>  
> +annotate=""
>  cmd_diff=0
>  diff_flags="-u"
>  dtx_file_1=""
> @@ -208,6 +211,14 @@ while [ $# -gt 0 ] ; do
>  		shift
>  		;;
>  
> +	-T | --annotate )
> +		if [ "${annotate}"  = "" ] ; then
> +			annotate="-T"
> +		elif [ "${annotate}"  = "-T" ] ; then
> +			annotate="-T -T"
> +		fi
> +		shift
> +		;;
>  	-u )
>  		dtc_sort=""
>  		shift
> @@ -327,7 +338,7 @@ cpp_flags="\
>  DTC="\
>  	${DTC}                                     \
>  	-i ${srctree}/scripts/dtc/include-prefixes \
> -	-O dts -qq -f ${dtc_sort} -o -"
> +	-O dts -qq -f ${dtc_sort} ${annotate} -o -"
>  
>  
>  # -----  do the diff or decompile
> 

