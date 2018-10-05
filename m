Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5521C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:56:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA9220834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQyIbIWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA9220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Rf9g6xF5zF3dL
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:56:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQyIbIWa";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQyIbIWa"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Rf6j6r8dzDqVF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 04:53:49 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id y18-v6so5126243pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ghk/Vg/V7vqswhgv++QqPn2eTXQmOf4Jw4JSP1UZmIg=;
 b=hQyIbIWaCQF7mI/FUakxhjXbWrPeFxSFY5U1Xz13cC4z57F1vusu6AM31FTuKyZ57c
 gqItLWA1LYy5XIU/Xnaw8SzQHsI3JganDf9FWgLZipeO9xu/Ts2uqa1QP77Zcxr5YOkL
 6oylO1X9+2wKsVmS+2Tgjv3twyEk0iOLPFE5Vk6P3MFZlZupbRWUXEiSi/+YCp4vmU3g
 m92LPs5tAcXD3NU+M0d3WAp9f3yodRyCCxoc9tdnz/uAxooj+4dbsDBXK9LKGpPneP17
 8rUSvkw9JU3fG7fb5sRL1CShil71wU8E8ktQ47M+MZprkxEWrxH1PEoWw2O7YbI0a3sE
 zrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ghk/Vg/V7vqswhgv++QqPn2eTXQmOf4Jw4JSP1UZmIg=;
 b=PC43/dnPQ52aVSZl/XIEPSz9V+4bFpr+p6E94wJ3qNlNTVN0N3D2h8Gh3OsSt103DA
 s8p0Tlo1DSgtgUevH0r4GCL9kzZiTIFD87Vk95+Mvc18lTOZx59x2VKGxGt7CQ7UsZEK
 2E6yh+w9//A/12aXw2TlUWdXBbRVEoJzQopZzuvuvJJPzlyBQfepEASTxaYSnzySUeQ9
 GQ5hrXXA8GwBmWiXEVCduyeRb5cpRZVKiAe64WSs+0eSHRwmI/VAoLp66ZVSFNa8oIEQ
 /5iG/v+B9462ct21M/jnpMiutiYSRsRinOdvbJVv+IdgIorlsBEpl+gRs8kN6WVZQ5W0
 ujeg==
X-Gm-Message-State: ABuFfogIza5dazYrL9exnHIDp8mhsI2bLQMBvCPwqP+JHrXUzz8/iHw+
 G6cinkISTiN0pwkwSfMRgMo=
X-Google-Smtp-Source: ACcGV62rVsZEojQh1DkNJ/f9gUcGjTdHHgWK05PWh5fTIYYLqbwJjApJLszxwWMSeOywvFtvJ1unBw==
X-Received: by 2002:a62:c08b:: with SMTP id
 g11-v6mr13303728pfk.72.1538765627852; 
 Fri, 05 Oct 2018 11:53:47 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id j75-v6sm11711334pfk.125.2018.10.05.11.53.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 11:53:47 -0700 (PDT)
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
To: Rob Herring <robh+dt@kernel.org>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <f39a84d3-f706-d31e-db22-4e3ebc72c447@gmail.com>
Date: Fri, 5 Oct 2018 11:53:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
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

On 10/05/18 08:07, Rob Herring wrote:
> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>>
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
> and...?

#size-cells no longer occur.

(Thanks for catching that.)


>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 29c33a5c533f..e6fb3ffe9d93 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
>>   * @target may be either in the live devicetree or in a new subtree that
>>   * is contained in the changeset.
>>   *
>> - * Some special properties are not updated (no error returned).
>> + * Some special properties are not added or updated (no error returned):
>> + * "name", "phandle", "linux,phandle".
>> + *
>> + * Properties "#address-cells" and "#size-cells" are not updated if they
>> + * are already in the live tree, but if present in the live tree, the values
>> + * in the overlay must match the values in the live tree.
> 
> Perhaps this should be generalized to apply to any property? We can't
> really deal with property values changing on the fly anyways.

That is a bigger discussion.  I'd prefer to not hold up this series for that
question to be resolved.  It will be easy enough to generalize in an add-on
patch later.


>>   *
>>   * Update of property in symbols node is not allowed.
>>   *
>> @@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>  {
>>         struct property *new_prop = NULL, *prop;
>>         int ret = 0;
>> +       bool check_for_non_overlay_node = false;
>>
>>         if (!of_prop_cmp(overlay_prop->name, "name") ||
>>             !of_prop_cmp(overlay_prop->name, "phandle") ||
>> @@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>         if (!new_prop)
>>                 return -ENOMEM;
>>
>> -       if (!prop)
>> +       if (!prop) {
>> +
> 
> Remove the extra blank lines.

Will do.

> 
>> +               check_for_non_overlay_node = true;
>>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>>                                                 new_prop);
>> -       else
>> +
>> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
>> +
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> 
> Technically these are __be32 types. This could use a helper (of_prop_val_eq).

These are in a unpacked form, so cpu byte order, not FDT byte order.

> 
> I'm not sure we really need to validate the length here as dtc does
> that (but yes, not everything is from dtc).

Since I'm accessing 4 bytes of the values, I need to be sure the lengths
are at least 4.  For #address-cells and #size-cells the property is
specified as four bytes, so I could simplify the code for the specific case.

If this gets extended to any arbitrary property then a new of_prop_val_eq()
would check that the lengths are equal and the values (of size length) are
also equal.


> 
>> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
>> +                              target->np);
>> +
>> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
>> +
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
>> +                              target->np);
>> +
>> +       } else {
>> +
>> +               check_for_non_overlay_node = true;
>>                 ret = of_changeset_update_property(&ovcs->cset, target->np,
>>                                                    new_prop);
>>
>> +       }
>> +
>> +       if (check_for_non_overlay_node &&
>> +           !of_node_check_flag(target->np, OF_OVERLAY))
>> +               pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
>> +                      __func__, target->np, new_prop->name);
>> +
>>         if (ret) {
>>                 kfree(new_prop->name);
>>                 kfree(new_prop->value);
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>
> 

