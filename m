Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FCCC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 21:57:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE002084F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 21:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzeYz4Jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE002084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pmkR0YxZzF35p
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 08:57:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OzeYz4Jn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OzeYz4Jn"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pmgk6TnwzF1wq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 08:55:14 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id w22-v6so1779611plk.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 13:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dTx0MyxMvJWBg5FgKXcvGw8UE6R9YlJFE4cTpyv6Hk0=;
 b=OzeYz4Jn507e8ZnCNYLV3fbItQs7vbYXycLbt7GelK6MRcmWh7L28Waz0WMcTHqngb
 4KMQEflM8ui/OQgikeGlmPfaQYsm/fHRsdsynhUbm85ssHV2LWdbuGrfBcjY1HUdnL8u
 S5h3l83dDuXKVBSS4IcYROGZSGez1UJJ3SVN1OCnkpxiv81JxQfnnjI6SnInSs4r1H2a
 kpe+dcgNEDsfbXGwDhhMx/EcMP57ZCpaqXQRIstwyQKfXgBa3vz6qa+nmL3w0W8waERJ
 BQkvVhBpFXJTPivAhBdFEThafvjjW6DVWtj5riy2DZuvtzztGlwLI7lSxIIhaFNqtAot
 Lo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dTx0MyxMvJWBg5FgKXcvGw8UE6R9YlJFE4cTpyv6Hk0=;
 b=aYjo1UKJbpFULrGB4bB4eUDdDb4KHHUR+ZSylA4O20z1RUQB6BaOdIJIh8malYIRN4
 ceCoHL6a7yRCqNi8OCw56DqgqzmHmnvQZ51BWfMteRjgV+ED7AP0pIO1wC/gxRxYZpjN
 b4lGCOho568OAjkjUylcvi6O0dhH8hgJlODOfPt7C3NmWHp68m0ZYoiEZF3ldP9uWRw8
 lwqYUSigDlgZgzCafgH6tHMZWd1oxzNVaVB6zXSbYEJuX/aLK5epo9IBUicfrRHt3MIQ
 gni2iR4Vf1BL2v1dHi1x80BopR3t6D6rX6dQVflhVxTX1VpN7yqgz73wsEF3H1Tds0Xd
 Ob5w==
X-Gm-Message-State: AGRZ1gKmBsduqVGVpouffOYGHY6CHBrIFYjh4YLd/eLcjomsFWOZDzLZ
 NG1cGYSFRgsn+nOYmfyLVao=
X-Google-Smtp-Source: AJdET5fsEio7H+3d9hnXIjkpWArjkCv+s50ekmErvJfDcFyC+4UUHM2UczKdGNNikG1Icoy63QLOPg==
X-Received: by 2002:a17:902:bc8c:: with SMTP id
 bb12-v6mr22797774plb.275.1541454912854; 
 Mon, 05 Nov 2018 13:55:12 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id f193-v6sm53474546pfc.74.2018.11.05.13.55.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Nov 2018 13:55:12 -0800 (PST)
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
To: Rob Herring <robh+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
Date: Mon, 5 Nov 2018 13:55:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
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
Cc: devicetree@vger.kernel.org, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Moritz Fischer <mdf@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael, Ben, Paul,

Do you know if anyone has tried this series on PowerPC?

Thanks,

-Frank


On 11/5/18 11:24 AM, Rob Herring wrote:
> On Mon, Nov 5, 2018 at 9:26 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add checks to (1) overlay apply process and (2) memory freeing
>> triggered by overlay release.  The checks are intended to detect
>> possible memory leaks and invalid overlays.
>>
>> The checks revealed bugs in existing code.  Fixed the bugs.
>>
>> While fixing bugs, noted other issues, which are fixed in
>> separate patches.
>>
>> *****  Powerpc folks: I was not able to test the patches that
>> *****  directly impact Powerpc systems that use dynamic
>> *****  devicetree.  Please review that code carefully and
>> *****  test.  The specific patches are: 03/16, 04/16, 07/16
> 
> I'm waiting for this to happen. Send me a pull req when it does or
> when you give up waiting for a response.
> 
> Rob
> 

