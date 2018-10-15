Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E008BC070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 01:21:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496B320652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 01:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/hxWOO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496B320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YLHf6dCTzF2Pq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:21:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/hxWOO8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/hxWOO8"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YK7f1JpHzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 11:29:17 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id g2-v6so8286740pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5o/wKl0UtRTrSQOwevxWhjE/eXwm/pLu6WI0xVrkfhU=;
 b=T/hxWOO8E5u3HVWvvdtbdRbYnHWDdh4TV+5oPFRxr24Wvrbqfg1XJzsyg+PW4G02QE
 tG/M0J9pucc3+j0xhf9Lrc5Zi+HxHuxW8jdOxne5avJZUlhWHa+bymPp0WTVnMpGpaL1
 QrHAivmzf71YK4hlq5U+1vMk/yefOzCGIScke7DqdQ2oEZ92ujL6cU/2YLfge8gFrRSv
 apTvCDb9g4r1hpkqIiXiy1MUgTAOwbk/+qJ9VTAL62GiyPLTg5S3q2B7uxvd291aqxFL
 jk5LOeNiM85fFlJQhwrEn4G6cV2mM0cgYpal0cJCMUhPe+Z+B+IlpGCHo7KIYvYv+M7p
 0XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5o/wKl0UtRTrSQOwevxWhjE/eXwm/pLu6WI0xVrkfhU=;
 b=JWr7hbZvs1L7sEiK8MfBMsEdighCYqXf6WedsRrZKIIXHs0u86jiUCpEZzxYwuW/W9
 xiOx4/Dou2Bg7L1RGzZPaSYvQtROr9iyrphWdCpERVB32ZJNWcxJN/EV2aILEY2FD8cl
 yrB1YpoKf06ByPdfPzjh0XAImhs3tghoLKWfFOelBp3ctoZfu1ZTWIFrQcGBf2Jjh/7c
 egGJU9IQeu8GBVHf5VTonHKM8QyJq7CRbwveEln4ZjYw9eRposLmTDvKGq20dMq17Wyt
 VIwllxcA4EQM1LLR6F+JHzVtWV/opijDkRVfsit3NZegxNBL58ztNPbQc56CUpIcddy6
 YGyA==
X-Gm-Message-State: ABuFfoiJbpeL+qXEMzZQyxygJIvVQLbNadicAjO5/hvx6kc19z1h5hhN
 HxKyOdY9/BajTSlCppoGCi8=
X-Google-Smtp-Source: ACcGV604mIqkHeaB14gcPNus6R31NLhilnJ9cIc5Q7XE83z/1r3tFRmkByauVV1eES7kTpDLBn+L1g==
X-Received: by 2002:a63:214d:: with SMTP id
 s13-v6mr14112721pgm.148.1539563356354; 
 Sun, 14 Oct 2018 17:29:16 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id f1-v6sm14901470pgc.4.2018.10.14.17.29.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Oct 2018 17:29:15 -0700 (PDT)
Subject: Re: [PATCH v2 12/18] of: overlay: check prevents multiple fragments
 add or delete same node
From: Frank Rowand <frowand.list@gmail.com>
To: Joe Perches <joe@perches.com>, Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
 <1539406418-18162-13-git-send-email-frowand.list@gmail.com>
 <97b26203e6792795bdc0a66ce4cdb47571ff16c1.camel@perches.com>
 <651a8488-caec-b153-43c7-1fb81f641f1a@gmail.com>
Message-ID: <06898888-59dc-c37f-5013-a58fc73df2e1@gmail.com>
Date: Sun, 14 Oct 2018 17:29:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <651a8488-caec-b153-43c7-1fb81f641f1a@gmail.com>
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

On 10/13/18 11:21, Frank Rowand wrote:
> On 10/13/18 05:51, Joe Perches wrote:
>> On Fri, 2018-10-12 at 21:53 -0700, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> Multiple overlay fragments adding or deleting the same node is not
>>> supported.  Replace code comment of such, with check to detect the
>>> attempt and fail the overlay apply.
>>>
>>> Devicetree unittest where multiple fragments added the same node was
>>> added in the previous patch in the series.  After applying this patch
>>> the unittest messages will no longer include:
>>>
>>>    Duplicate name in motor-1, renamed to "controller#1"
>>>    OF: overlay: of_overlay_apply() err=0
>>>    ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
>>>    ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed
>>>
>>>    ...
>>>
>>>    ### dt-test ### end of unittest - 210 passed, 1 failed
>>>
>>> but will instead include:
>>>
>>>    OF: overlay: ERROR: multiple overlay fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
>>>
>>>    ...
>>>
>>>    ### dt-test ### end of unittest - 211 passed, 0 failed
>> []
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> []
>>> @@ -523,6 +515,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
>>>  }
>>>  
>>>  /**
>>> + * check_changeset_dup_add_node() - changeset validation: duplicate add node
>>> + * @ovcs:	Overlay changeset
>>> + *
>>> + * Check changeset @ovcs->cset for multiple add node entries for the same
>>> + * node.
>>> + *
>>> + * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
>>> + * invalid overlay in @ovcs->fragments[].
>>> + */
>>> +static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
>>> +{
>>> +	struct of_changeset_entry *ce_1, *ce_2;
>>> +	char *fn_1, *fn_2;
>>> +	int name_match;
>>> +
>>> +	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
>>> +
>>> +		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
>>> +		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
>>> +
>>> +			ce_2 = ce_1;
>>> +			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
>>> +				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
>>> +				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
>>> +					/* inexpensive name compare */
>>> +					if (!of_node_cmp(ce_1->np->full_name,
>>> +					    ce_2->np->full_name)) {
>>
>> A bit of odd indentation here.
>> This line is normally aligned to the second ( on the line above.
> 
> Yes, thanks.

This line gets joined into a single line in version 3, so I will leave
the bad formatting in patch 12 to make my life easier when moving
to version 3.


>>
>>> +						/* expensive full path name compare */
>>> +						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>>> +						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>>> +						name_match = !strcmp(fn_1, fn_2);
>>> +						kfree(fn_1);
>>> +						kfree(fn_2);
>>> +						if (name_match) {
>>> +							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
>>> +							       ce_1->np);
>>> +							return -EINVAL;
>>> +						}
>>> +					}
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> Style trivia:
>>
>> Using inverted tests and continue would reduce indentation.
> 
> Yes, thanks.

In version 3, fixed in patch 13/18 instead of 12/18, where this pattern
has been split into two functions.

-Frank


> 
> -Frank
> 
> 
>>
>> 	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
>> 		if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
>> 		    ce_1->action != OF_RECONFIG_DETACH_NODE)
>> 			continue;
>>
>> 		ce_2 = ce_1;
>> 		list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
>> 			if (ce_2->action != OF_RECONFIG_ATTACH_NODE &&
>> 			    ce_2->action != OF_RECONFIG_DETACH_NODE)
>> 				continue;
>>
>> 			/* inexpensive name compare */
>> 			if (of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
>> 				continue;
>>
>> 			/* expensive full path name compare */
>> 			fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>> 			fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>> 			name_match = !strcmp(fn_1, fn_2);
>> 			kfree(fn_1);
>> 			kfree(fn_2);
>> 			if (name_match) {
>> 				pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
>> 				       ce_1->np);
>> 				return -EINVAL;
>> 			}
>> 		}
>> 	}
>>
>>
>>
> 
> 

