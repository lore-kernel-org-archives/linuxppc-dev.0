Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CDC5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 19:15:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B382E208E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 19:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnFY9ePt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B382E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bdzd4SyfzF3KN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 06:15:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pnFY9ePt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pnFY9ePt"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bdx024LczF3FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 06:13:08 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id s4-v6so14756035plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QF/LrY7iuL/AJgxskEfZ1z5Dz2J5Os8EfJ/RaKbgPVQ=;
 b=pnFY9ePt8LIwvV6bnejjjQHDnPGo/nBouYD0Rck4HJJi+YgAg8NNgD1IDPLbVb8Rkf
 9xUDJG5d4tiBLNSPC8+E4YDl6W1bZ2H5NhOeNpOKVXfDUdzQVSLutECVh/uCOgBbExbs
 JoEqOUIW9JtJvYC3TRehXL/UuEn5L9ie7LZv/fcWjd3Nuei/wioLqtNc/74DY2BQcsxO
 O8vXEda8QnWmCbg3Xb+K0pvm28qiT30XatVvl2TdKn3Wfece4HqGm1Nd2kXk6+4SzirB
 PEJ4Uk1iS6ngMThTPQ3W6m/YnMRFzQm74LCS8GgsUCyThooXYZc1bluvbakwuE8TXo5K
 dohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QF/LrY7iuL/AJgxskEfZ1z5Dz2J5Os8EfJ/RaKbgPVQ=;
 b=nXdOk7/+khAKMQfZHUQijct7adcSRUaBk/5ZNPIiw2WOuv4GlU/9xsoi0k3le+RV48
 YtYu6hA2EhR1l8ZSc/kcgHdmbfhR4/EXPstHs0khnKty9Nbh5jWoRdS7/cnkceaJjc57
 R98zcdqq/dtNjQx3zmkEo6UMl1zzXKBS4HQaLavH1WPmMolTaciNUftTtxCJKE7ajYRB
 QmNmzxOeWqEO3SvxLV8dz6hnRaF4DBTlOJRbrck5AistNAlcSEihsBNNMHvkeA6T5kS5
 rBcXa93rkZsRLVcpJix4dxHB6LkCEN8rK2FWgyheEMDxMMBRGhQ6pDvkzIS9Fik7QZ1L
 eLRw==
X-Gm-Message-State: ABuFfoh2fJ72XP0Fs62RA9y1eKmsxljyjPZokio9BiXiW8TMZZb62q/4
 wvLR9U0HU20ROLvsLsxhlyk=
X-Google-Smtp-Source: ACcGV61vCE0ZwCYVrWt4ggVKaQd2SaX1lI2I5hvx6jI+0dIOMQozHakxBBOsX1H0sVlhQ5jQZbqHLw==
X-Received: by 2002:a17:902:bf44:: with SMTP id
 u4-v6mr2975568pls.48.1539889986567; 
 Thu, 18 Oct 2018 12:13:06 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id 25-v6sm45982117pfm.36.2018.10.18.12.13.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Oct 2018 12:13:06 -0700 (PDT)
Subject: Re: [PATCH v4 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
To: Rob Herring <robh@kernel.org>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-10-git-send-email-frowand.list@gmail.com>
 <20181018181338.GD15557@bogus>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <b6c378d0-19db-5426-7c3a-dbbc5907c37c@gmail.com>
Date: Thu, 18 Oct 2018 12:13:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018181338.GD15557@bogus>
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
 linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/18/18 11:13, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 07:37:29PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> If overlay properties #address-cells or #size-cells are already in
>> the live devicetree for any given node, then the values in the
>> overlay must match the values in the live tree.
>>
>> If the properties are already in the live tree then there is no
>> need to create a changeset entry to add them since they must
>> have the same value.  This reduces the memory used by the
>> changeset and eliminates a possible memory leak.  This is
>> verified by 12 fewer warnings during the devicetree unittest,
>> as the possible memory leak warnings about #address-cells and
> 
> Still missing the rest...
> 
> And what about my other comments too?

Apologies, paper bag.  Will fix all.

-Frank

> 
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>> Changes since v3:
>>   - for errors of an overlay changing the value of #size-cells or
>>     #address-cells, return -EINVAL so that overlay apply will fail
>>   - for errors of an overlay changing the value of #size-cells or
>>     #address-cells, make the message more direct.
>>     Old message:
>>       OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
>>     New message:
>>       OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed
>>
>>  drivers/of/overlay.c | 42 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 39 insertions(+), 3 deletions(-)
> 

