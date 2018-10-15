Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA72C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 01:54:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CA820652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 01:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJuVbdVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CA820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YM2620yCzF1Pr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:54:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJuVbdVK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJuVbdVK"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YLzY0kS0zF1Hm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 12:52:25 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id f18-v6so8483350plr.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 18:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bUrhhPAQHKxvChH2N6KNc44klfA4B1coEO58r1NxXE8=;
 b=KJuVbdVK59gIqkR+1tLrHTmyIjBCyO6hyFkm+9xlQMjI9F235y5rSk+C0OFxH/h9V2
 dyckwEKKJjKPRbnMh8Nb9GhZpIUTUDFeRRrptQps+N1cqDqohCOhgrtQVMkhbl6oojx1
 1WgIZ6aDdakr+1/rZnyuBedSVJ2sUmalRZ35RhDEi1VADN1Ka8feDy6oFwBel3KZzIh5
 uK78KeVvRtGAsdVTW2aZXuJwwDdYZ9aTEr94mJBxxzc+ARIBMJ406hMlcksmFOfHImXy
 lcr1wZKPmLsZrL1a4wcXz5y7wgoZpt+JgyvMZEDDm0e7AEX7mOidN65qZ79rSYDLif6+
 8jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bUrhhPAQHKxvChH2N6KNc44klfA4B1coEO58r1NxXE8=;
 b=maEsscjaANaIB3MYoevEA/UTFE4uNApzfMcHPWsL2X06YVq2/WRt/7K1lTbaNahQ8C
 u9yHn3BxopGzlmwGUB+KQxXRiBl2KKPKK7yCYDj3E+wNE14JZAbcWp4kbJI5YTgWGBu1
 GA+ZtdJchhyJmR1eNKsYkZWFXfHp0DJdA5xGcCmcDFfazbqP271zafaFI8JsB1oeUNFs
 aV3UN9qtcCInZwf6wT/929n0vKgvpEjgPc+auGgTPNOsvAKkfu5YarW1yUplZlN0sfKr
 IwIx2CW4QVDVxVnFbVy9Aj7eOxl+uoXec7DpyWSbFrX9x9ywABwRonTv9vddiV2t36T6
 VgQA==
X-Gm-Message-State: ABuFfoiTjXYNL/dYbl+mIAF55+HWPcvodE/pSG/pI8dQKJDDGHo0M7XR
 uQhiBZNxbfNdFZxTVpz0shk=
X-Google-Smtp-Source: ACcGV61W/5FqMss+k1fm713ta5l6Nwfweb0KbNsiACiJIDR18r7500/41nV+SRrEeSSWmR2a2zg7Vw==
X-Received: by 2002:a17:902:9f97:: with SMTP id
 g23-v6mr14907990plq.68.1539568343349; 
 Sun, 14 Oct 2018 18:52:23 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id k72-v6sm15734479pfj.63.2018.10.14.18.52.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Oct 2018 18:52:22 -0700 (PDT)
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
To: Joe Perches <joe@perches.com>, Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
 <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
Date: Sun, 14 Oct 2018 18:52:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/14/18 18:06, Joe Perches wrote:
> On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add test case of two fragments updating the same property.  After
>> adding the test case, the system hangs at end of boot, after
>> after slub stack dumps from kfree() in crypto modprobe code.
> []
>> -static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
>> +static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
>>  {
>> -	struct of_changeset_entry *ce_1, *ce_2;
>> -	char *fn_1, *fn_2;
>> -	int name_match;
>> +	struct of_changeset_entry *ce_1;
>> +	int dup_entry = 0;
>>  
>>  	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
>> -
>> -		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
>> -		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
>> -
>> -			ce_2 = ce_1;
>> -			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
>> -				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
>> -				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
>> -					/* inexpensive name compare */
>> -					if (!of_node_cmp(ce_1->np->full_name,
>> -					    ce_2->np->full_name)) {
>> -						/* expensive full path name compare */
>> -						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>> -						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>> -						name_match = !strcmp(fn_1, fn_2);
>> -						kfree(fn_1);
>> -						kfree(fn_2);
>> -						if (name_match) {
>> -							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
>> -							       ce_1->np);
>> -							return -EINVAL;
>> -						}
>> -					}
>> -				}
>> -			}
>> -		}
>> +		dup_entry |= find_dup_cset_node_entry(ovcs, ce_1);
>> +		dup_entry |= find_dup_cset_prop(ovcs, ce_1);
> 
> I think this is worse performance than before.
> 
> This now walks all entries when before it would
> return -EINVAL directly when it found a match.

Yes, it is worse performance, but that is OK.

This is a check that is done when a devicetree overlay is applied.
If an error occurs then that means that the overlay was incorrectly
specified.  The file drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
in this patch provides an example of how a bad overlay can be created.

Once an error was detected, the check could return immediately, or it
could continue to give a complete list of detected errors.  I chose to
give the complete list of detected errors.

-Frank
