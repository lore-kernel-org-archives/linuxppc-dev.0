Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409B7C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Nov 2021 11:01:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68FC60F55
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Nov 2021 11:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A68FC60F55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HrFy017Cpz304t
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Nov 2021 22:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rPJXglKC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=85.215.255.81;
 helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=rPJXglKC; 
 dkim-atps=neutral
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HrFxF0wDNz2xBx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Nov 2021 22:00:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636714823;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=pIgmmX2bC3EX44bW2c5iZqPR05KitHfzE33dDVBbknM=;
 b=rPJXglKCY4Um/cMy4SmA/CGb4+8TvRsts3nEHlV2ipxfVhEfWB4JMbAMlH/GIQUKue
 9NwnWszF3wV7T4WCAelxD38moiYjFAkB78eJxmFJVu4X+UVSjTdKNGOpRxPQV779hEFR
 c2fNTvPZZ5ZahRjFW1BMThJR3KzaQx3ztLmVOIwIiVPUfCVZwbGlg10Hp3MPTGPZEUkd
 J7LXyWYrq6nQwigyFID80Uc1m78VDjE2t41zlVE6zUCdYtBPLp+f5/Y715xM5rclLy8S
 +zEuuL1dDWV5s1wdVmMgpAiP5Ru9o7A+4+BOHTnhwC1/3F56kHkcSzhHHPEzDYSrP5tc
 QjQA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgGI+hs5tAvjn+88DfkT7ELd1ArCg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a02:8109:89c0:ebfc:e52a:1ea0:c574:c7ab]
 by smtp.strato.de (RZmta 47.34.5 AUTH)
 with ESMTPSA id N03801xACB0MSqc
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 12 Nov 2021 12:00:22 +0100 (CET)
Message-ID: <c9cac845-c196-9ea4-0df5-91acd1fb84f5@xenosoft.de>
Date: Fri, 12 Nov 2021 12:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Marc Zyngier <maz@kernel.org>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
 <15731ad7-83ff-c7ef-e4a1-8b11814572c2@xenosoft.de>
 <17e37b22-5839-0e3a-0dbf-9c676adb0dec@xenosoft.de>
 <3b210c92-4be6-ce49-7512-bb194475eeab@xenosoft.de>
 <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
 <87mtma8udh.wl-maz@kernel.org>
 <c95c9b58-347e-d159-3a82-bf5f9dbf91ac@xenosoft.de>
 <1e2dc4c6-f286-f16b-4546-5cf2b1ca3123@xenosoft.de>
In-Reply-To: <1e2dc4c6-f286-f16b-4546-5cf2b1ca3123@xenosoft.de>
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
Cc: axboe@kernel.dk, Rob Herring <robh@kernel.org>, lorenzo.pieralisi@arm.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Arnd Bergmann <arnd@arndb.de>, kw@linux.com,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 damien.lemoal@opensource.wdc.com, Olof Johansson <olof@lixom.net>,
 Darren Stevens <darren@stevens-zone.net>, mad skateman <madskateman@gmail.com>,
 "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
 robert@swiecki.net, Matthew Leaman <matthew@a-eon.biz>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12 November 2021 at 11:11 am, Christian Zigotzky wrote:
> On 12 November 2021 at 10:40 am, Christian Zigotzky wrote:
>> On 11 November 2021 at 06:39 pm, Marc Zyngier wrote:
>>> On Wed, 10 Nov 2021 18:07:24 +0000,
>>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>> On 09 November 2021 at 03:45 pm, Christian Zigotzky wrote:
>>>>> Hello,
>>>>>
>>>>> The Nemo board [1] doesn't recognize any ATA disks with the
>>>> pci-v5.16 updates [2].
>>>>> Error messages:
>>>>>
>>>>> ata4.00: gc timeout cmd 0xec
>>>>> ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>>> ata1.00: gc timeout cmd 0xec
>>>>> ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>>> ata3.00: gc timeout cmd 0xec
>>>>> ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>>>
>>>>> I was able to revert the new pci-v5.16 updates [2]. After a new
>>>> compiling, the kernel recognize all ATA disks correctly.
>>>>> Could you please check the pci-v5.16 updates [2]?
>>>>>
>>>>> Please find attached the kernel config.
>>>>>
>>>>> Thanks,
>>>>> Christian
>>>>>
>>>>> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
>>>>> [2]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4 
>>>>
>>>>
>>>> Hi All,
>>>>
>>>> Many thanks for your nice responses.
>>>>
>>>> I bisected today [1]. 0412841812265734c306ba5ef8088bcb64d5d3bd
>>>> (of/irq: Allow matching of an interrupt-map local to an interrupt
>>>> controller) [2] is the first bad commit.
>>> Can you please give the following hack a go and post the result
>>> (including the full dmesg)?
>>>
>>> Thanks,
>>>
>>>     M.
>>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>>> index 32be5a03951f..8cf0cc9b7caf 100644
>>> --- a/drivers/of/irq.c
>>> +++ b/drivers/of/irq.c
>>> @@ -156,14 +156,15 @@ int of_irq_parse_raw(const __be32 *addr, 
>>> struct of_phandle_args *out_irq)
>>>         /* Now start the actual "proper" walk of the interrupt tree */
>>>       while (ipar != NULL) {
>>> +        bool intc = of_property_read_bool(ipar, 
>>> "interrupt-controller");
>>> +
>>>           /*
>>>            * Now check if cursor is an interrupt-controller and
>>>            * if it is then we are done, unless there is an
>>>            * interrupt-map which takes precedence.
>>>            */
>>>           imap = of_get_property(ipar, "interrupt-map", &imaplen);
>>> -        if (imap == NULL &&
>>> -            of_property_read_bool(ipar, "interrupt-controller")) {
>>> +        if (imap == NULL && intc) {
>>>               pr_debug(" -> got it !\n");
>>>               return 0;
>>>           }
>>> @@ -244,8 +245,14 @@ int of_irq_parse_raw(const __be32 *addr, struct 
>>> of_phandle_args *out_irq)
>>>                 pr_debug(" -> imaplen=%d\n", imaplen);
>>>           }
>>> -        if (!match)
>>> +        if (!match) {
>>> +            if (intc) {
>>> +                pr_info("%pOF interrupt-map failed, using 
>>> interrupt-controller\n", ipar);
>>> +                return 0;
>>> +            }
>>> +
>>>               goto fail;
>>> +        }
>>>             /*
>>>            * Successfully parsed an interrrupt-map translation; copy 
>>> new
>>>
>> The detecting of the ATA disks works with this patch! Well done! 
>> Thanks a lot!
>>
> Sorry, I have read the patch more carefully and I have seen that it is 
> an analyse patch. It's not a fix. I was too quick with my joy.
>
> - Christian
OK, perhaps a fix after all.

if (imap == NULL && intc) // If the return value isn't NULL then there 
isn't an interrupt-map. That means, this part was successfully (&&) and 
"intc" will evaluated (Testing of interrupt-controller). OK, perhaps it 
is a fix after all.

Output:

[    0.072659] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072682] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072701] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072720] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072741] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072762] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072784] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072805] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072824] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072843] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072861] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.072929] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073167] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073191] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073211] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073232] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073252] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073272] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073292] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073319] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073339] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073371] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073392] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073412] OF: /pxp@0,e0000000 interrupt-map failed, using 
interrupt-controller
[    0.073426] PCI: Probing PCI hardware done
