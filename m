Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4B2C43334
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jun 2022 07:47:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LQ7KN3wJTz3c8M
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jun 2022 17:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wanadoo.fr (client-ip=80.12.242.125; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=<UNKNOWN>)
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LQ7Jt4jLcz2yyS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2022 17:46:36 +1000 (AEST)
Received: from [192.168.1.18] ([90.11.190.129])
	by smtp.orange.fr with ESMTPA
	id 2T2lok3Aj26JC2T2loC0bc; Sat, 18 Jun 2022 09:39:00 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 18 Jun 2022 09:39:00 +0200
X-ME-IP: 90.11.190.129
Message-ID: <fe306bbf-288d-8d8e-1aae-08ad7d8c870c@wanadoo.fr>
Date: Sat, 18 Jun 2022 09:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] powerpc: powernv: Fix refcount leak bug in opal-powercap
Content-Language: en-US
To: Liang He <windhl@126.com>
References: <20220617042038.4003704-1-windhl@126.com>
 <0ca5ee14-a382-0935-66be-820975501f45@wanadoo.fr>
 <6a9bcf7d.3ab8.181702f264d.Coremail.windhl@126.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6a9bcf7d.3ab8.181702f264d.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: nick.child@ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 17/06/2022 à 07:42, Liang He a écrit :
> 
> 
> 
> At 2022-06-17 13:01:27, "Christophe JAILLET" <christophe.jaillet@wanadoo.fr> wrote:
>> Le 17/06/2022 à 06:20, Liang He a écrit :
>>> In opal_powercap_init(), of_find_compatible_node() will return
>>> a node pointer with refcount incremented. We should use of_node_put()
>>> in fail path or when it is not used anymore.
>>>
>>> Besides, for_each_child_of_node() will automatically *inc* and *dec*
>>> refcount during iteration. However, we should add the of_node_put()
>>> if there is a break.
>>
>> Hi,
>>
>> I'm not sure that your patch is right here. Because of this *inc* and
>> *dec* things, do we still need to of_node_put(powercap) once we have
>> entered for_each_child_of_node?
>>
>> I think that this reference will be released on the first iteration of
>> the loop.
>>
> 
> Hi, CJ,
> 
> Thanks for your reply and I want have a discuss.
> 
> Based on my review on the src of 'of_get_next_child',  there is only
> *inc* for next and *dec* for pre as follow.
> 
> (|node| == powercap)
> ======__of_get_next_child( |node|, prev)======
>       ...
>          next = prev? prev->sibling:|node|->child;
> 	of_node_get(next);
> 	of_node_put(prev);
>       ...
> =========================
> 
> However, there is no any code to release the |node| (i.e., *powercap*).
> 
> Am I right?   If I am wrong, please correct me, thanks.

You are right.
I mis-read __of_get_next_child(().

CJ


> 
>>
>> Maybe of_node_put(powercap) should be duplicated everywhere it is
>> relevant and removed from the error handling path?
>> Or an additional reference should be taken before the loop?
>> Or adding a new label with "powercap = NULL" and branching there when
>> needed?
>>
>> CJ
> 
> If my understanding is right, I think current patch is right.
> 
> Otherwise, I will make a new patch to handle that, Thanks.
> 
> Liang
> 
>>
>>>
>>> Signed-off-by: Liang He <windhl@126.com>
>>> ---
>>>    arch/powerpc/platforms/powernv/opal-powercap.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
>>> index 64506b46e77b..b102477d3f95 100644
>>> --- a/arch/powerpc/platforms/powernv/opal-powercap.c
>>> +++ b/arch/powerpc/platforms/powernv/opal-powercap.c
>>> @@ -153,7 +153,7 @@ void __init opal_powercap_init(void)
>>>    	pcaps = kcalloc(of_get_child_count(powercap), sizeof(*pcaps),
>>>    			GFP_KERNEL);
>>>    	if (!pcaps)
>>> -		return;
>>> +		goto out_powercap;
>>>    
>>>    	powercap_kobj = kobject_create_and_add("powercap", opal_kobj);
>>>    	if (!powercap_kobj) {
>>> @@ -236,6 +236,9 @@ void __init opal_powercap_init(void)
>>>    		kfree(pcaps[i].pg.name);
>>>    	}
>>>    	kobject_put(powercap_kobj);
>>> +	of_node_put(node);
>>>    out_pcaps:
>>>    	kfree(pcaps);
>>> +out_powercap:
>>> +	of_node_put(powercap);
>>>    }

