Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E44C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:09:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C809204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="FI5DmV/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C809204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kvxq6m6DzF1Cr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:09:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="FI5DmV/H";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::11; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="FI5DmV/H"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kvsv0TLTzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 02:05:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540911931;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=w75lYCYy5BvQOwB/5lL6fnGEFGi7Pbm2fDJREpTF+Zs=;
 b=FI5DmV/HFuc+Rh5ugXXOpDA236MmRUPrvGFr6NqeRt72Daq/JLC1Y4t03E7phw6ZPx
 gZfPxrty6a4Q5W0NrE8jM5DKPI+shWiX24xgfppYzZ7xtuL+rf14AXFEtoeqtBon4oPO
 1qGUGiUNECJ3mYPh5piWoTy0JGMbolTygAOc0r8G/Ag39rabLgI0D7s9DIMcNOqJfbMx
 OppweMYMMsHPnE6V95IIaj9XxRKrWRl3Qvm23sjPDAP3Ql1zVgM5AgOOUZFX86LDhnJW
 XfcIZKR9I311viGTK2NPZaPuD0Q771fvIOrI2cDmjdAAG4c07SpmnwAElZHBYjE88sM9
 Mi6w==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CleivLNq/UFVxBXIOZxQ4X9VQesgg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:a485:2d5d:7000:7d2f]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cu9UF5JDu3
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 30 Oct 2018 16:05:19 +0100 (CET)
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
From: Christian Zigotzky <chzigotzky@xenosoft.de>
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
 <95aab857-7bc5-8585-e426-7a0e60792934@xenosoft.de>
Message-ID: <4fceca56-f4c9-1bda-7504-3c82f862a522@xenosoft.de>
Date: Tue, 30 Oct 2018 16:05:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <95aab857-7bc5-8585-e426-7a0e60792934@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 30 October 2018 at 08:27AM, Christian Zigotzky wrote:
> On 30 October 2018 at 02:59AM, Benjamin Herrenschmidt wrote:
>> On Tue, 2018-10-30 at 02:42 +0100, Christian Zigotzky wrote:
>>> OF patch for the latest Git kernel: http://www.xenosoft.de/of_v2.patch
>> This just seems to revert a whole bunch of stuff, not really the right
>> way to go. Why is of_get_next_cpu_node() not finding your CPUs ? There
>> must be something wrong with the device-tree...
> Maybe we need a new dtb for QEMU ppce500 and P50XX machines. I don't 
> know. For us it is good to have this patch because we can test 
> further. (other updates)
> With this patch, SMP works again on virtual QEMU ppce500 and P50XX 
> machines. If you have another code, then I will test it with QEMU and 
> my P5020 board.
>
> Thanks,
> Christian
We use the 'cyrus_p5020.dts' file for creating the dtb file for our 
P5020 board. You can find it in the official kernel source code. 
(arch/powerpc/boot/dts/cyrus_p5020.dts)
For the virtual ppce500 machine I don't need to add a dtb file to the 
QEMU command. But maybe there is a solution:

On 30 October 2018 at 3:18PM, Michael Ellerman wrote:
> Hi Rob,
>
> Sorry I missed this when you posted it.
>
> Rob Herring <robh@kernel.org> writes:
>> Iterating thru cpu nodes is a common pattern. Create a common iterator
>> which can find child nodes either by node name or device_type == cpu.
>> Using the former will allow for eventually dropping device_type
>> properties which are deprecated for FDT.
> Device trees we see on powerpc generally don't (never?) use "cpu" as the
> node name for CPU nodes. And many of those device trees come from
> firmware, so we can't update them.
>
> So dropping support for device_type is a non-starter from our POV.
>
> cheers
>
>
>>
>>> ----------------------------- of_v2.patch -----------------------------
>>>
>>> diff -rupN a/drivers/of/base.c b/drivers/of/base.c
>>> --- a/drivers/of/base.c    2018-10-30 02:19:30.827089495 +0100
>>> +++ b/drivers/of/base.c    2018-10-30 02:18:51.666856715 +0100
>>> @@ -395,7 +395,7 @@ struct device_node *of_get_cpu_node(int
>>>    {
>>>        struct device_node *cpun;
>>>
>>> -    for_each_of_cpu_node(cpun) {
>>> +    for_each_node_by_type(cpun, "cpu") {
>>>            if (arch_find_n_match_cpu_physical_id(cpun, cpu, thread))
>>>                return cpun;
>>>        }
>>> @@ -750,45 +750,6 @@ struct device_node *of_get_next_availabl
>>>    EXPORT_SYMBOL(of_get_next_available_child);
>>>
>>>    /**
>>> - *    of_get_next_cpu_node - Iterate on cpu nodes
>>> - *    @prev:    previous child of the /cpus node, or NULL to get first
>>> - *
>>> - *    Returns a cpu node pointer with refcount incremented, use
>>> of_node_put()
>>> - *    on it when done. Returns NULL when prev is the last child. 
>>> Decrements
>>> - *    the refcount of prev.
>>> - */
>>> -struct device_node *of_get_next_cpu_node(struct device_node *prev)
>>> -{
>>> -    struct device_node *next = NULL;
>>> -    unsigned long flags;
>>> -    struct device_node *node;
>>> -
>>> -    if (!prev)
>>> -        node = of_find_node_by_path("/cpus");
>>> -
>>> -    raw_spin_lock_irqsave(&devtree_lock, flags);
>>> -    if (prev)
>>> -        next = prev->sibling;
>>> -    else if (node) {
>>> -        next = node->child;
>>> -        of_node_put(node);
>>> -    }
>>> -    for (; next; next = next->sibling) {
>>> -        if (!(of_node_name_eq(next, "cpu") ||
>>> -              (next->type && !of_node_cmp(next->type, "cpu"))))
>>> -            continue;
>>> -        if (!__of_device_is_available(next))
>>> -            continue;
>>> -        if (of_node_get(next))
>>> -            break;
>>> -    }
>>> -    of_node_put(prev);
>>> -    raw_spin_unlock_irqrestore(&devtree_lock, flags);
>>> -    return next;
>>> -}
>>> -EXPORT_SYMBOL(of_get_next_cpu_node);
>>> -
>>> -/**
>>>     * of_get_compatible_child - Find compatible child node
>>>     * @parent:    parent node
>>>     * @compatible:    compatible string
>>> diff -rupN a/include/linux/of.h b/include/linux/of.h
>>> --- a/include/linux/of.h    2018-10-30 02:19:32.047096634 +0100
>>> +++ b/include/linux/of.h    2018-10-30 02:18:51.666856715 +0100
>>> @@ -347,7 +347,6 @@ extern const void *of_get_property(const
>>>                    const char *name,
>>>                    int *lenp);
>>>    extern struct device_node *of_get_cpu_node(int cpu, unsigned int 
>>> *thread);
>>> -extern struct device_node *of_get_next_cpu_node(struct device_node 
>>> *prev);
>>>
>>>    #define for_each_property_of_node(dn, pp) \
>>>        for (pp = dn->properties; pp != NULL; pp = pp->next)
>>> @@ -757,11 +756,6 @@ static inline struct device_node *of_get
>>>        return NULL;
>>>    }
>>>
>>> -static inline struct device_node *of_get_next_cpu_node(struct
>>> device_node *prev)
>>> -{
>>> -    return NULL;
>>> -}
>>> -
>>>    static inline int of_n_addr_cells(struct device_node *np)
>>>    {
>>>        return 0;
>>> @@ -1239,10 +1233,6 @@ static inline int of_property_read_s32(c
>>>        for (child = of_get_next_available_child(parent, NULL); child !=
>>> NULL; \
>>>             child = of_get_next_available_child(parent, child))
>>>
>>> -#define for_each_of_cpu_node(cpu) \
>>> -    for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
>>> -         cpu = of_get_next_cpu_node(cpu))
>>> -
>>>    #define for_each_node_with_property(dn, prop_name) \
>>>        for (dn = of_find_node_with_property(NULL, prop_name); dn; \
>>>             dn = of_find_node_with_property(dn, prop_name))
>>
>
>

