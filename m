Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F7AC04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:19:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B1E208D9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5yQJjPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B1E208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YqXY1Xn6zF37p
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:19:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5yQJjPP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5yQJjPP"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YqTy0H57zF3CZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 07:16:53 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id 1-v6so9827142plv.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jm8fB0wVC8YkHOkSv8uX8/TXjvy9fnL7cXDYSdXQAck=;
 b=X5yQJjPP+pBY4TQoG/W/D39i8UVBjJFM2qB0+9jgztrjoGjQrUEd0T2NqHQPodx+WI
 ngBOG0/inIIoQKpmT2A5Fyw89GEoj2R6l8coBQQReq/StzGX6M3Dc+au1nPsWOtgeBpK
 ISGEGJEycZWpJtE/dSen1PVw1wF7JaKLJ+99U4XI61CrqWRaW4cutVHChAE9Ar+h1AyN
 stCSMNA/lUSUojQnQnOUyzBTbdyP4MEXGzaWjsw6WzVh6WL5WzxJ4m619GVMrFWLjZtR
 AlluUUuLucdaN8mgswCcU0k0RMa9lPToBzRCTcPGW6aeSiU62+OS5pXgBaKOr+0IE5ER
 GtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jm8fB0wVC8YkHOkSv8uX8/TXjvy9fnL7cXDYSdXQAck=;
 b=V3i53KO5pz/f5n8JW3d23Y6LPXvLkl2Kkx0Fm6Peva09HtZ9V5bblsaOPG8SA7Mc81
 996Q6BmZ1KKSTuEhXe4CpYkGtSV4jDSYHIQ4v9r+km5RyLv2HLOC7SfGXSjpFWkX8iQd
 uIoRKML6MQckJKMSTX3uRDJS5Fxgr2OI5hGUH7n3QPcxlGl72CjskrJT53eZQ5srAVbo
 S8hnIuk9DrAZO/GKvb4hS3B3GZ5GYnYuMwORzEsbNMQC0WqSWChKdBXDVKc4m8Hp+At+
 m9tVwyh72rKbGeugVz7XQGrUxEkRRK47xUxVJqocF1VpEDDnPJQ8GR5Wx+bnvTnJWOFQ
 km/A==
X-Gm-Message-State: ABuFfojJdnZRr3lQCLwz6rJqrMT2615O2Ey13r7+mkkPAWA3V1Gtj+Um
 5ZOwnV9D4UwDzFt8UwB6lV8=
X-Google-Smtp-Source: ACcGV63goaBoH9yMNm2vt5O+Wec7lNMu536nUxIAKS/CeAndAz98xdBJRIIWOA59gfmylKMb6tDHCw==
X-Received: by 2002:a17:902:286b:: with SMTP id
 e98-v6mr18405281plb.110.1539634611957; 
 Mon, 15 Oct 2018 13:16:51 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id h88-v6sm25968932pfa.184.2018.10.15.13.16.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Oct 2018 13:16:51 -0700 (PDT)
Subject: Re: [PATCH v3 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
To: Alan Tull <atull@kernel.org>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-10-git-send-email-frowand.list@gmail.com>
 <CANk1AXQNkYDA9hRCMR_MkOJiobPjmYoJN8Gv+3YN9ReV+q5XEw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <87525c4a-6c7d-5c1d-1f99-6784f315b89c@gmail.com>
Date: Mon, 15 Oct 2018 13:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXQNkYDA9hRCMR_MkOJiobPjmYoJN8Gv+3YN9ReV+q5XEw@mail.gmail.com>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/15/18 12:01, Alan Tull wrote:
> On Sun, Oct 14, 2018 at 7:26 PM <frowand.list@gmail.com> wrote:
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
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 272a0d1a5e18..ee66651db553 100644
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
>> +               check_for_non_overlay_node = true;
>>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>>                                                 new_prop);
>> -       else
>> +
>> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
>> +
> 
> Hi Frank,
> 
> If we get these ERROR messages, I suggest that this function should
> return an error so the overlay will be rejected.
> 
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> 
>                         *(u32 *)prop->value != *(u32 *)new_prop->value) {
> 
>> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
>> +                              target->np);
> 
>                        ret = -EINVAL;
>                 }
> 
> Otherwise there is an ERROR message, but it continues trying to apply
> the invalid overlay anyway and I get an oops.  By adding the ret =
> -EINVAL, the overlay gets rejected and the oops is avoided.

Yes, that sounds good.


>> +
>> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
>> +
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
>> +                              target->np);
> 
> Add the ret = -EINVAL here also.  This give me the following (if my
> overlay changes #address-cells):

Yes.


> [   21.167551] OF: overlay: ERROR: overlay and/or live tree
> #address-cells invalid in node /soc/base_fpga_region
> [   21.177442] OF: overlay: add_changeset_property ret=-22
> [   21.182656] create_overlay: Failed to create overlay (err=-22)
> 
> Also, I wonder if the ERROR message could be more direct.  Currently
> it says the #address-cells property is invalid but that doesn't say
> anything about why it's invalid.  How about something like:
> 
>  OF: overlay: ERROR: changing #address-cells not allowed (/soc/base_fpga_region)

That sounds like a more useful message, maybe a slight change
s/changing #address-cells/changing value of #address-cells/


> The 'OF: overlay' part still makes it clear it's overlay related.  The
> rest of it makes it clear *why* it's invalid.  This ERROR will be a
> surprise for people who have been using overlays, so that could be
> helpful to light the way a bit.
> 
> Alan
> 
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

