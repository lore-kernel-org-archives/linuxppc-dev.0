Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93826C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 19:14:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167C22084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 19:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZHX/7wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167C22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rfb31WXtzDqdd
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 05:14:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bZHX/7wf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bZHX/7wf"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RfSR1s5GzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 05:09:11 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id g2-v6so5113015pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gSCa6qDpcon9k244TFOFHwaXaUdRj7V+ii+TFFiVhdQ=;
 b=bZHX/7wfbMAskGGgHetrbI0X4CXTsv3ajvmfXYV/7jsTlNbCrDl1IDTGYiN7jR1aQ9
 DEGSxl4txsFl4+Wvp6ejkOSedtKIxIDY5GPmGRYvx9ej1CN0/qzWgFFgqucomcNGrIU7
 /LhKH3UH75YBsvqw1THDUGh9nuJzethM+4uuww9/Sffgf5l482j05IRdv1Mh2X3vJGnG
 sYR3GOgUhNG1a4MioiAnkpX/LBUGjLMKgvRSiQ9hhx1Gd0vK6/Ni0eAOksi9xy8zlRkr
 KqCCSSkLftM/cqWPaxcun6sT8T/5ih9RVqa1op1jPk863qgkijPIj3qyqKdZHC+7/bXa
 3xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gSCa6qDpcon9k244TFOFHwaXaUdRj7V+ii+TFFiVhdQ=;
 b=j1bdCfqxHU0LOAKFjSYOx4UyNAVbknXXr4feCEIti7Fzk3MzmscBf7nHBbyH12AGSI
 OkktBypJMBem+5Og0qQBqel52vvMaeWA5+v67Wt61CaveuxAUPADZFqsci7RRbu1a81i
 COwDO4MT8zN8z5aExPdjpYVBNocvEMIFlBeuSr2crR9mcYLtYLIngbGWORyYGsnlf4zL
 T0jSCDp3LLaXXxA/uMX5vxxbklwPY+TjV5Hd+VBLKYd4Zy6iD6knaXgHK5K6qKrkuklV
 QI4VpsBhrgL8F2T/qTm8R794HtfDw+wq/4liQJ7CP/zPTnHXYFRvSVEBjsFCT2OMONEk
 U9OQ==
X-Gm-Message-State: ABuFfoi0dtJBTxHNIbcrnI0rn66ts5BJzH1xmzNVKE8ow1NWmqfQ8wx9
 E+h6OudAw1HeMKiFZjRNMxM=
X-Google-Smtp-Source: ACcGV60Hc89meiLiv6oiMz6/lxaFfLNmJ2aGnBFdEh4GLFtkwb3huScwcj01iHOC3MAkGv/X2d5zuQ==
X-Received: by 2002:a62:9e52:: with SMTP id
 s79-v6mr13625594pfd.110.1538766549073; 
 Fri, 05 Oct 2018 12:09:09 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id s133-v6sm3669729pgc.78.2018.10.05.12.09.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 12:09:08 -0700 (PDT)
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
To: Rob Herring <robh+dt@kernel.org>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
 <f39a84d3-f706-d31e-db22-4e3ebc72c447@gmail.com>
 <CAL_Jsq+53znm=LHxH8bZZJ2wN4uUez8D7E2V03+Zc9nvYBNjrg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <c3a72a61-01f9-955c-8bcf-7845cd6c993a@gmail.com>
Date: Fri, 5 Oct 2018 12:09:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+53znm=LHxH8bZZJ2wN4uUez8D7E2V03+Zc9nvYBNjrg@mail.gmail.com>
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
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/05/18 12:04, Rob Herring wrote:
> On Fri, Oct 5, 2018 at 1:53 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/05/18 08:07, Rob Herring wrote:
>>> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>>>>
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> If overlay properties #address-cells or #size-cells are already in
>>>> the live devicetree for any given node, then the values in the
>>>> overlay must match the values in the live tree.
>>>>
>>>> If the properties are already in the live tree then there is no
>>>> need to create a changeset entry to add them since they must
>>>> have the same value.  This reduces the memory used by the
>>>> changeset and eliminates a possible memory leak.  This is
>>>> verified by 12 fewer warnings during the devicetree unittest,
>>>> as the possible memory leak warnings about #address-cells and
>>>
>>> and...?
>>
>> #size-cells no longer occur.
>>
>> (Thanks for catching that.)
>>
>>
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>>> index 29c33a5c533f..e6fb3ffe9d93 100644
>>>> --- a/drivers/of/overlay.c
>>>> +++ b/drivers/of/overlay.c
>>>> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
>>>>   * @target may be either in the live devicetree or in a new subtree that
>>>>   * is contained in the changeset.
>>>>   *
>>>> - * Some special properties are not updated (no error returned).
>>>> + * Some special properties are not added or updated (no error returned):
>>>> + * "name", "phandle", "linux,phandle".
>>>> + *
>>>> + * Properties "#address-cells" and "#size-cells" are not updated if they
>>>> + * are already in the live tree, but if present in the live tree, the values
>>>> + * in the overlay must match the values in the live tree.
>>>
>>> Perhaps this should be generalized to apply to any property? We can't
>>> really deal with property values changing on the fly anyways.
>>
>> That is a bigger discussion.  I'd prefer to not hold up this series for that
>> question to be resolved.  It will be easy enough to generalize in an add-on
>> patch later.
> 
> Fair enough.
> 
>>>> +               if (prop->length != 4 || new_prop->length != 4 ||
>>>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>>>
>>> Technically these are __be32 types. This could use a helper (of_prop_val_eq).
>>
>> These are in a unpacked form, so cpu byte order, not FDT byte order.
> 
> You sure about that? Unpacking doesn't change the order. It can't
> because the type is unknown. The value of 'value' is the address of
> the data in the FDT.

Aargh.  You are totally right.


>>> I'm not sure we really need to validate the length here as dtc does
>>> that (but yes, not everything is from dtc).
>>
>> Since I'm accessing 4 bytes of the values, I need to be sure the lengths
>> are at least 4.  For #address-cells and #size-cells the property is
>> specified as four bytes, so I could simplify the code for the specific case.
>>
>> If this gets extended to any arbitrary property then a new of_prop_val_eq()
>> would check that the lengths are equal and the values (of size length) are
>> also equal.
> 
> Right, that's what I was thinking. Check lengths are equal and then
> you can just do a memcmp().

Based on all of this it seems better that I create of_prop_val_eq(), as you
suggested, and change to use that.


> 
> Rob
> 

