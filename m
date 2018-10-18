Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7122ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 19:04:24 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0A22054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 19:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJwsiw+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0A22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bdks5wg9zDqhb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 06:04:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJwsiw+a";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJwsiw+a"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bdh22V2yzF36F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 06:01:53 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id c25-v6so15307390pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c8c/YKFOurrxuiYDsv6SSbr24JEeZeRwF7ACeKHdCY0=;
 b=AJwsiw+aoRtddCxQF4kA7SKieSMjBM1gi4pLvBpP7Wyh17aMiGdz1Ikc6pkX7tVtm4
 8wnEj0SJwOi5+3I/Brg76gZTzyJJCk1qpRNtNjKc+rFhsGAxylKYbygRc0U1EcXLAg1q
 /K9LeWVw6MM2G54sCdrc5zDmgPqIO0VAFqjy9lj+95hoPkL6Wb1E/vHuUJ0HHR99mv46
 r6mQeV3pZH/gLGWw2LYbTwz9YSKBHen8o4RMsH2rwoql9ywB7IADczTE9aq+px4FZzDH
 xyK1q5qcTYy5+ehYa6vJ8K4G0PonQU/ItAVFGATyP9rsYbBDDg5An5DXnjGLqnrU8NzN
 RNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c8c/YKFOurrxuiYDsv6SSbr24JEeZeRwF7ACeKHdCY0=;
 b=rk0prgw8gbjWEowIX0u7ByYW0ij2MYGgJm/20M883wM2WSaZkIwc0CNa2eGbTfyd7o
 fGHZow0ZN56KTjQu58PkN7EiuTtnxtZrm+PtqroyNGJ0XUGU1zc3bDLkg6NkI3R/ijZQ
 LToAIu9eKkSWSogA1MdOw4pCMMHEF8F1K6zujGQ2uHYnzx6OGs8y4cuwa9Ifsj62ePMM
 eIoTC13MMffSz79nrx9bVWj06f8QSAGfRM4LIxtpAWSg+cXvm/P9B7kBjpLdq0AvIrhu
 xkn3I6BDj397693zjTPaiZfk++gyt6pJCktZAup6K+nG9TDOjGFBAz/ijdAt4bDaCKZE
 D/vQ==
X-Gm-Message-State: ABuFfogiqZ0meGvcrh9rpOQigJFNuBN8ShxPYirldw7t3h/HXE45loc8
 r/yztYOveyqnEuElXGPkFLk=
X-Google-Smtp-Source: ACcGV63J0hRNaPnkYdhN7pK+spiOnUI3NCscZBief4XvI51YV88TsVlqM7kfY0s8B6dkdA+KmD5l1A==
X-Received: by 2002:a63:5605:: with SMTP id
 k5-v6mr29957478pgb.189.1539889312064; 
 Thu, 18 Oct 2018 12:01:52 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id e22-v6sm22474840pfi.61.2018.10.18.12.01.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Oct 2018 12:01:51 -0700 (PDT)
Subject: Re: [PATCH v4 01/18] of: overlay: add tests to validate kfrees from
 overlay removal
To: Rob Herring <robh@kernel.org>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
 <20181018170303.GA15557@bogus>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <f6aaf5be-ed08-a055-c270-4284ed6532a9@gmail.com>
Date: Thu, 18 Oct 2018 12:01:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018170303.GA15557@bogus>
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

On 10/18/18 10:03, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 07:37:21PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add checks:
>>   - attempted kfree due to refcount reaching zero before overlay
>>     is removed
>>   - properties linked to an overlay node when the node is removed
>>   - node refcount > one during node removal in a changeset destroy,
>>     if the node was created by the changeset
>>
>> After applying this patch, several validation warnings will be
>> reported from the devicetree unittest during boot due to
>> pre-existing devicetree bugs. The warnings will be similar to:
>>
>>   OF: ERROR: of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest11/test-unittest111 contains unexpected properties
>>   OF: ERROR: memory leak - destroy cset entry: attach overlay node /testcase-data-2/substation@100/hvac-medium-2 expected refcount 1 instead of 2.  of_node_get() / of_node_put() are unbalanced for this node.
> 
> These messages could be formatted more consistently. Put the path either 
> at the beginning (after any prefix) or end. Beginning is more like a 
> compiler error. End puts what the problem is before it's off the edge of 
> the screen. 

The inconsistency makes the word flow more natural, but I agree that
consistency is more important.  I think I can make all the messages
say the problem first, then provide the path at the end.


>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>> Changes since v3:
>>   - Add expected value of refcount for destroy cset entry error.  Also
>>     explain the cause of the error.
>>
>>  drivers/of/dynamic.c | 29 +++++++++++++++++++++++++++++
>>  drivers/of/overlay.c |  1 +
>>  include/linux/of.h   | 15 ++++++++++-----
>>  3 files changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>> index f4f8ed9b5454..24c97b7a050f 100644
>> --- a/drivers/of/dynamic.c
>> +++ b/drivers/of/dynamic.c
>> @@ -330,6 +330,25 @@ void of_node_release(struct kobject *kobj)
>>  	if (!of_node_check_flag(node, OF_DYNAMIC))
>>  		return;
>>  
>> +	if (of_node_check_flag(node, OF_OVERLAY)) {
>> +
>> +		if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {
> 
> I worry the flags are getting unwieldy.

I considered that.  I think we are still ok, and I don't have a better
solution than adding flag values.  (I did have some Rube Goldberg
variations.)


> 
>> +			/* premature refcount of zero, do not free memory */
>> +			pr_err("ERROR: memory leak %s() overlay node %pOF before free overlay changeset\n",
>> +			       __func__, node);
>> +			return;
>> +		}
>> +
>> +		/*
>> +		 * If node->properties non-empty then properties were added
>> +		 * to this node either by different overlay that has not
>> +		 * yet been removed, or by a non-overlay mechanism.
>> +		 */
>> +		if (node->properties)
>> +			pr_err("ERROR: %s() overlay node %pOF contains unexpected properties\n",
>> +			       __func__, node);
>> +	}
>> +
>>  	property_list_free(node->properties);
>>  	property_list_free(node->deadprops);
>>  
>> @@ -434,6 +453,16 @@ struct device_node *__of_node_dup(const struct device_node *np,
>>  
>>  static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
>>  {
>> +	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
>> +	    of_node_check_flag(ce->np, OF_OVERLAY)) {
>> +		if (kref_read(&ce->np->kobj.kref) > 1) {
>> +			pr_err("ERROR: memory leak - destroy cset entry: attach overlay node %pOF expected refcount 1 instead of %d.  of_node_get() / of_node_put() are unbalanced for this node.\n",
>> +			       ce->np, kref_read(&ce->np->kobj.kref));
>> +		} else {
>> +			of_node_set_flag(ce->np, OF_OVERLAY_FREE_CSET);
>> +		}
>> +	}
>> +
>>  	of_node_put(ce->np);
>>  	list_del(&ce->node);
>>  	kfree(ce);
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index eda57ef12fd0..1176cb4b6e4e 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -373,6 +373,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>>  			return -ENOMEM;
>>  
>>  		tchild->parent = target_node;
>> +		of_node_set_flag(tchild, OF_OVERLAY);
>>  
>>  		ret = of_changeset_attach_node(&ovcs->cset, tchild);
>>  		if (ret)
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 4d25e4f952d9..aa1dafaec6ae 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -138,11 +138,16 @@ static inline void of_node_put(struct device_node *node) { }
>>  extern struct device_node *of_stdout;
>>  extern raw_spinlock_t devtree_lock;
>>  
>> -/* flag descriptions (need to be visible even when !CONFIG_OF) */
>> -#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
>> -#define OF_DETACHED	2 /* node has been detached from the device tree */
>> -#define OF_POPULATED	3 /* device already created for the node */
>> -#define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
>> +/*
>> + * struct device_node flag descriptions
>> + * (need to be visible even when !CONFIG_OF)
>> + */
>> +#define OF_DYNAMIC		1 /* (and properties) allocated via kmalloc */
>> +#define OF_DETACHED		2 /* detached from the device tree */
>> +#define OF_POPULATED		3 /* device already created */
>> +#define OF_POPULATED_BUS	4 /* platform bus created for children */
>> +#define OF_OVERLAY		5 /* allocated for an overlay */
>> +#define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
>>  
>>  #define OF_BAD_ADDR	((u64)-1)
>>  
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
>>
> 

