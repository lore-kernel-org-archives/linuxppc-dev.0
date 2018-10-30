Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC0C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 07:30:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A612080A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 07:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="fjtipNI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A612080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kjmj2wSvzDrNX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 18:30:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="fjtipNI0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::6; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kjjt0hsDzDrMD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 18:27:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540884456;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Rf/Awe2SiSSwOyiA2+FWXwDZ+xLEzS9v5HNW8pUQhe0=;
 b=fjtipNI0SaeVmXOeGIBHrAyWEbFjc+rMHB/Dwi9hmK9O6Y8DUJpz94n3vTkacRWxJq
 cSRc1UDrV/RqMCG3J0mg3mc1Qd1xf5kdoQojYLg8iafBkDZySbdtG8VqbQJax/uklyhy
 iAm1twGKgrm3vaKoxko/3xaIAYicKBvgonBtBZMPKnYAx4NwM+iI80RZmN39RJnzP+Sn
 RAq7bE4C8wsQDhcDh6L1i7WzJRRNApdy3EJzumTW+GFbZ1SHV3D3wkm0bFI8tqRmChH+
 nAnwsfOQMm/9hGemsk045xp+qpvdPhMnSCke2A8CGMScyYPXDcSbWIBtHMo6yjmYOnJB
 uRHw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkH2j1Q+d/Q+fCR7cS2d2AoFrcY2w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:8d41:d9f3:c983:3fbc]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cu9U7RQAVg
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 30 Oct 2018 08:27:26 +0100 (CET)
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Scott Wood <oss@buserror.net>, LEROY Christophe <christophe.leroy@c-s.fr>
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
 <20181029191321.Horde.fxo4MJUhTstCq8zaw1lK7Q3@messagerie.si.c-s.fr>
 <77061E9A-AFC9-437A-AB42-F47266FD9721@xenosoft.de>
 <074997be051a5684b5b8593c3c3ce2a2e06147fa.camel@buserror.net>
 <d13090a2-902e-e18c-c97f-79cddb277454@xenosoft.de>
 <7595e349-d925-9d03-c234-5070873e48d3@xenosoft.de>
 <ca934ae822ddae764736004972273ca8397184bd.camel@kernel.crashing.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <95aab857-7bc5-8585-e426-7a0e60792934@xenosoft.de>
Date: Tue, 30 Oct 2018 08:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ca934ae822ddae764736004972273ca8397184bd.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 30 October 2018 at 02:59AM, Benjamin Herrenschmidt wrote:
> On Tue, 2018-10-30 at 02:42 +0100, Christian Zigotzky wrote:
>> OF patch for the latest Git kernel: http://www.xenosoft.de/of_v2.patch
> This just seems to revert a whole bunch of stuff, not really the right
> way to go. Why is of_get_next_cpu_node() not finding your CPUs ? There
> must be something wrong with the device-tree...
Maybe we need a new dtb for QEMU ppce500 and P50XX machines. I don't 
know. For us it is good to have this patch because we can test further. 
(other updates)
With this patch, SMP works again on virtual QEMU ppce500 and P50XX 
machines. If you have another code, then I will test it with QEMU and my 
P5020 board.

Thanks,
Christian
>
>> ----------------------------- of_v2.patch -----------------------------
>>
>> diff -rupN a/drivers/of/base.c b/drivers/of/base.c
>> --- a/drivers/of/base.c    2018-10-30 02:19:30.827089495 +0100
>> +++ b/drivers/of/base.c    2018-10-30 02:18:51.666856715 +0100
>> @@ -395,7 +395,7 @@ struct device_node *of_get_cpu_node(int
>>    {
>>        struct device_node *cpun;
>>
>> -    for_each_of_cpu_node(cpun) {
>> +    for_each_node_by_type(cpun, "cpu") {
>>            if (arch_find_n_match_cpu_physical_id(cpun, cpu, thread))
>>                return cpun;
>>        }
>> @@ -750,45 +750,6 @@ struct device_node *of_get_next_availabl
>>    EXPORT_SYMBOL(of_get_next_available_child);
>>
>>    /**
>> - *    of_get_next_cpu_node - Iterate on cpu nodes
>> - *    @prev:    previous child of the /cpus node, or NULL to get first
>> - *
>> - *    Returns a cpu node pointer with refcount incremented, use
>> of_node_put()
>> - *    on it when done. Returns NULL when prev is the last child. Decrements
>> - *    the refcount of prev.
>> - */
>> -struct device_node *of_get_next_cpu_node(struct device_node *prev)
>> -{
>> -    struct device_node *next = NULL;
>> -    unsigned long flags;
>> -    struct device_node *node;
>> -
>> -    if (!prev)
>> -        node = of_find_node_by_path("/cpus");
>> -
>> -    raw_spin_lock_irqsave(&devtree_lock, flags);
>> -    if (prev)
>> -        next = prev->sibling;
>> -    else if (node) {
>> -        next = node->child;
>> -        of_node_put(node);
>> -    }
>> -    for (; next; next = next->sibling) {
>> -        if (!(of_node_name_eq(next, "cpu") ||
>> -              (next->type && !of_node_cmp(next->type, "cpu"))))
>> -            continue;
>> -        if (!__of_device_is_available(next))
>> -            continue;
>> -        if (of_node_get(next))
>> -            break;
>> -    }
>> -    of_node_put(prev);
>> -    raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> -    return next;
>> -}
>> -EXPORT_SYMBOL(of_get_next_cpu_node);
>> -
>> -/**
>>     * of_get_compatible_child - Find compatible child node
>>     * @parent:    parent node
>>     * @compatible:    compatible string
>> diff -rupN a/include/linux/of.h b/include/linux/of.h
>> --- a/include/linux/of.h    2018-10-30 02:19:32.047096634 +0100
>> +++ b/include/linux/of.h    2018-10-30 02:18:51.666856715 +0100
>> @@ -347,7 +347,6 @@ extern const void *of_get_property(const
>>                    const char *name,
>>                    int *lenp);
>>    extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
>> -extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
>>
>>    #define for_each_property_of_node(dn, pp) \
>>        for (pp = dn->properties; pp != NULL; pp = pp->next)
>> @@ -757,11 +756,6 @@ static inline struct device_node *of_get
>>        return NULL;
>>    }
>>
>> -static inline struct device_node *of_get_next_cpu_node(struct
>> device_node *prev)
>> -{
>> -    return NULL;
>> -}
>> -
>>    static inline int of_n_addr_cells(struct device_node *np)
>>    {
>>        return 0;
>> @@ -1239,10 +1233,6 @@ static inline int of_property_read_s32(c
>>        for (child = of_get_next_available_child(parent, NULL); child !=
>> NULL; \
>>             child = of_get_next_available_child(parent, child))
>>
>> -#define for_each_of_cpu_node(cpu) \
>> -    for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
>> -         cpu = of_get_next_cpu_node(cpu))
>> -
>>    #define for_each_node_with_property(dn, prop_name) \
>>        for (dn = of_find_node_with_property(NULL, prop_name); dn; \
>>             dn = of_find_node_with_property(dn, prop_name))
>

