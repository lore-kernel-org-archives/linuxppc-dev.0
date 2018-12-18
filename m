Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269B3C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 20:36:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEF720675
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 20:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlQifCRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEF720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K8vV0s8qzDqWY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 07:36:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qlQifCRx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qlQifCRx"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K8qQ1fmkzDqXZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 07:33:21 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id q1so8671921pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 12:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zreIIbL+3MU68nvyzHBRLGe/WzUlqPgB+0qC4jO7Klg=;
 b=qlQifCRxQf01GN5Fl+wjIEsJX8MdYfgOLDuaB0lUlyc3d+ltm4uDT5zJ7HZhLhlPoQ
 amVN/58vNcRu9TWV+gNOGk09m8dIhQOEDXuJOzI3/Fet9Ida3J/6cO0hwI19lurDG3lZ
 TlMXQ7GlN9IbSdZxt8Xv4TEtsXHNKoGySoLn6f7rv+MmC8BqYiYVqeVe1l94kqJR+gBU
 zLfGNCe3D5FQg6Sy6BncgacitVDhzfdjf3zdMnGPwudBePVwFWooK2h/HybedQclpyFl
 JPPRSclanRwgnm9/taguO/69oTdyJqOJi6WyZkzdR0JMiE7Q6e2fEF6hsJzGKCyjo2Wl
 I//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zreIIbL+3MU68nvyzHBRLGe/WzUlqPgB+0qC4jO7Klg=;
 b=sIjYmze+e0mjonnadbv9J0xpnXKVx0I5Rgaq6QimRYFFu31GduX2J8CzRREnSbTcvo
 SMwxF2saHxT6HVodqXxI+Q/NyhuV6dGrpZBSnWTzciOjNYfeEa7wdSgYoTxTUY93yGjR
 eceJyn58zBL1iGiIC0aFlNTETVv6ceEuGC2t4wCBsNJKNst94WRhDlppF9aNKL1wcWpw
 v797CKjMDSQkbSnr7X5cLLmC+NcktHa/eOw87BbKa0GSmozVJPfIBavzdlBTxf32hKUV
 Dq5wXqw2GDCF+dpqGWLpVFG04tnWLfuk6/ApC6fqyTBlFj81ai0x+dDcarH7bFo7c4wS
 sX5g==
X-Gm-Message-State: AA+aEWaoE9dprF6OPTV3AHG4ZD9wu/9ULo2W0I/dYMzRkhTJVlGS8zWZ
 fA4qVM7Jn7ub5BMi1hfSJ1o=
X-Google-Smtp-Source: AFSGD/X/hsJAIpS/yYvmfQSfaOlsru/WUTfRbk2Xhs8s11grPBRPdt2Kwk2kuSwhUfrsw2HLwoC5nw==
X-Received: by 2002:a63:4665:: with SMTP id v37mr577436pgk.425.1545165200203; 
 Tue, 18 Dec 2018 12:33:20 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id n66sm23909508pfk.19.2018.12.18.12.33.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 12:33:19 -0800 (PST)
Subject: Re: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle
 cache
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
 <871s6gv30z.fsf@concordia.ellerman.id.au>
 <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
 <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
 <893d9327-4353-066d-2efa-414a3db4c282@gmail.com>
Message-ID: <6b6a3d11-e60a-f55c-04fa-deafdd58ccec@gmail.com>
Date: Tue, 18 Dec 2018 12:33:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <893d9327-4353-066d-2efa-414a3db4c282@gmail.com>
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/18/18 12:09 PM, Frank Rowand wrote:
> On 12/18/18 12:01 PM, Rob Herring wrote:
>> On Tue, Dec 18, 2018 at 12:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 12/17/18 2:52 AM, Michael Ellerman wrote:
>>>> Hi Frank,
>>>>
>>>> frowand.list@gmail.com writes:
>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>
>>>>> Non-overlay dynamic devicetree node removal may leave the node in
>>>>> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
>>>>> will incorrectly find the stale entry.  Remove the node from the
>>>>> cache.
>>>>>
>>>>> Add paranoia checks in of_find_node_by_phandle() as a second level
>>>>> of defense (do not return cached node if detached, do not add node
>>>>> to cache if detached).
>>>>>
>>>>> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>>> ---
>>>>
>>>> Similarly here can we add:
>>>>
>>>> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
>>>
>>> Yes, thanks.
>>>
>>>
>>>> Cc: stable@vger.kernel.org # v4.17+
>>>
>>> Nope, 0b3ce78e90fc does not belong in stable (it is a feature, not a bug
>>> fix).  So the bug will not be in stable.
>>
>> 0b3ce78e90fc landed in v4.17, so Michael's line above is correct.
>> Annotating it with 4.17 only saves Greg from trying and then emailing
>> us to backport this patch as it wouldn't apply.
> 
> Thanks for the correction.  I was both under-thinking and over-thinking,
> ending up with an incorrect answer.
> 
> Can you add the Cc: to version 3 patch comments (both 1/2 and 2/2) or do
> you want me to re-spin?

Now that my thinking has been straightened out, a little bit more checking
for the other pre-requisite patches show:

  v4.18: commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
  v4.19: commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")

These can be addressed by changing the "Cc:" to ... # v4.19+
because stable v4.17.* and v4.18.* are end of life.

Or the pre-requisites can be listed:

   # v4.17: b9952b5218ad of: overlay: update phandle cache
   # v4.17: e54192b48da7 of: fix phandle cache creation
   # v4.17

   # v4.18: e54192b48da7 of: fix phandle cache creation
   # v4.18

   # v4.19+

Do you have a preference?

-Frank
> 
> -Frank
> 
>>
>> Rob
>>
> 
> 

