Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E7EC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 04:55:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816AC20821
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 04:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="VzdmmCYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816AC20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZGzG5rYzzDqcm
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 15:55:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="VzdmmCYa"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZGxL75h5zDqcL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 15:53:56 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so2753731pgq.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 20:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5jfzFes+MOz7MRDNv+3a/YTg2jkzltQPqpGqYQqGPuo=;
 b=VzdmmCYa7WJyRXKYJ9xaWs2nESyNxkeZS9vKeU/aQro7F4IlLvhBAoHYPygV8fpqwH
 MnixgkyvOxjD+De1WKGn8nxzAnf8rxbkarrmYNI7X/B3eOlkZYsE8Nae30Al1Brrglyr
 N/rd6FQkFmbdLKHQAT4s5XtClFfvzyM5A8zPPFGPIFyrzc2dqDBaAdjl1dBJDGjxWwiG
 qoT7epbmsXrt7EsbcheM/lTfVXaBuvaJb+U+oesThREtPtpdpusOh+K3gFos9R4yxV4a
 5wCiXQWobhz4SsmXBW4tIWyuodUo85w/Fl+D0SblxBPn7mI6CoqvvMb9vlyXVHKiShOx
 JXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5jfzFes+MOz7MRDNv+3a/YTg2jkzltQPqpGqYQqGPuo=;
 b=EK5nZiRufqrgGvrEJi/yRFLSN79dftaKr3RmOqivHH1JLvqrYQA/7EkdGrC0JzBsSF
 GVn8uR/xtKa4kT52DN8h7zQ3Ic2jrYtpnZRF1WhRss/O6sn1vf1nFXLCB/UpQ++3vPAv
 1FvlWsNjstQ3vZ2siVQZhx8CVBYO2S92/WOkO311ke+rSf63h2olkneerU/oltdYGfSN
 niL7AlMaXYyX3AGT8Jpt2pOZPmeD+D++KSnkxjsc5f7ZnTs9P8XQA09F/NilaSXGhJIe
 N8s6i7KsS/bhALJdTekWJBUXN6wlJICrPdW3hOprNTmEkBQKgsIZ9M7hhsq7lLKeQAZc
 Nekw==
X-Gm-Message-State: AJcUukcg+LX6BC93t/EvnYTEtUQa/4tmJKg6NbdvigYZoXQ7UzIKGc6H
 8dZtzGU7OVd9I9jc9aD4zzS17A==
X-Google-Smtp-Source: ALg8bN7mZ5tit3uMCYOLYM9sfsF3zCUmVIa0taTszTULEh916mNenU3eE05+3XoqpnUy2VRvCO11xQ==
X-Received: by 2002:a62:36c1:: with SMTP id d184mr4567758pfa.242.1547009634648; 
 Tue, 08 Jan 2019 20:53:54 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v15sm101806396pfn.94.2019.01.08.20.53.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 20:53:53 -0800 (PST)
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Gibson <david@gibson.dropbear.id.au>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
 <20190104034401.GA2801@umbus.fritz.box> <20190105175116.GB14238@ziepe.ca>
 <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <06c4612c-8409-ea7d-4f7c-4c010d8ecc01@ozlabs.ru>
Date: Wed, 9 Jan 2019 15:53:46 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sbest@redhat.com,
 saeedm@mellanox.com, alex.williamson@redhat.com, paulus@samba.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, ogerlitz@mellanox.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, tariqt@mellanox.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 06/01/2019 09:43, Benjamin Herrenschmidt wrote:
> On Sat, 2019-01-05 at 10:51 -0700, Jason Gunthorpe wrote:
>>
>>> Interesting.  I've investigated this further, though I don't have as
>>> many new clues as I'd like.  The problem occurs reliably, at least on
>>> one particular type of machine (a POWER8 "Garrison" with ConnectX-4).
>>> I don't yet know if it occurs with other machines, I'm having trouble
>>> getting access to other machines with a suitable card.  I didn't
>>> manage to reproduce it on a different POWER8 machine with a
>>> ConnectX-5, but I don't know if it's the difference in machine or
>>> difference in card revision that's important.
>>
>> Make sure the card has the latest firmware is always good advice..
>>
>>> So possibilities that occur to me:
>>>   * It's something specific about how the vfio-pci driver uses D3
>>>     state - have you tried rebinding your device to vfio-pci?
>>>   * It's something specific about POWER, either the kernel or the PCI
>>>     bridge hardware
>>>   * It's something specific about this particular type of machine
>>
>> Does the EEH indicate what happend to actually trigger it?
> 
> In a very cryptic way that requires manual parsing using non-public
> docs sadly but yes. From the look of it, it's a completion timeout.
> 
> Looks to me like we don't get a response to a config space access
> during the change of D state. I don't know if it's the write of the D3
> state itself or the read back though (it's probably detected on the
> read back or a subsequent read, but that doesn't tell me which specific
> one failed).

It is write:

pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);


> 
> Some extra logging in OPAL might help pin that down by checking the InA
> error state in the config accessor after the config write (and polling
> on it for a while as from a CPU perspective I don't knw if the write is
> synchronous, probably not).


Extra logging gives these straight after that write:

nFir:        0000808000000000 0030006e00000000 0000800000000000

PhbSts:      0000001800000000 0000001800000000

Lem:         0000020000088000 42498e367f502eae 0000000000080000

OutErr:      0000002000000000 0000002000000000 0000000000000000
0000000000000000
InAErr:      0000000030000000 0000000020000000 8080000000000000
0000000000000000


Decoded (my fancy script):

nFir:        0000808000000000 0030006e00000000 0000800000000000

 |- PCI Nest Fault Isolation Register(FIR) NestBase+0x00 _BE_ =
0000808000000000h:
 |   [0..63] 00000000 00000000 10000000 10000000 00000000 00000000
00000000 00000000
 |   #16 set: The PHB had a severe error and has fenced the AIB
 |   #24 set: The internal SCOM to ASB bridge has an error
 |   #29..30: Error bit from SCOM FIR engine = 0h
 |- PCI Nest FIR Mask NestBase+0x03 _BE_ = 0030006e00000000h:
 |   [0..63] 00000000 00110000 00000000 01101110 00000000 00000000
00000000 00000000
 |   #10 set: Any PowerBus data hang poll error(Only checked for CI Stores)
 |   #11 set: Any PowerBus command hang error (domestic address range)
 |   #25 set: A command received ack_dead, foreign data hang, or
Link_chk_abort from the foreign interface
 |   #26 set: Any PowerBus command hang error (foreign address range)
 |   #28 set: Error bit from BARS SCOM engines, Nest domain
 |   #29..30: Error bit from SCOM FIR engine = 3h/[0..1] 11
 |- PCI Nest FIR WOF (“Who's on First”) NestBase+0x08 _BE_ =
0000800000000000h:
 |   [0..63] 00000000 00000000 10000000 00000000 00000000 00000000
00000000 00000000
 |   #16 set: The PHB had a severe error and has fenced the AIB
 |   #29..30: Error bit from SCOM FIR engine = 0h
 |
PhbSts:      0000001800000000 0000001800000000

 |- 0x0120 Processor Load/Store Status Register _BE_ = 0000001800000000h:
 |   [0..63] 00000000 00000000 00000000 00011000 00000000 00000000
00000000 00000000
 |   #27 set: One of the PHB3’s error status register bits is set
 |   #28 set: One of the PHB3’s first error status register bits is set
 |- 0x0110 DMA Channel Status Register _BE_ = 0000001800000000h:
 |   [0..63] 00000000 00000000 00000000 00011000 00000000 00000000
00000000 00000000
 |   #27 set: One of the PHB3’s error status register bits is set
 |   #28 set: One of the PHB3’s first error status register bits is set
 |
Lem:         0000020000088000 42498e367f502eae 0000000000080000

 |- 0xC00 LEM FIR Accumulator Register _BE_ = 0000020000088000h:
 |   [0..63] 00000000 00000000 00000010 00000000 00000000 00001000
10000000 00000000
 |   #22 set: CFG Access Error
 |   #44 set: PCT Timeout Error
 |   #48 set: PCT Unexpected Completion
 |- 0xC18 LEM Error Mask Register = 42498e367f502eaeh
 |- 0xC40 LEM WOF Register _BE_ = 0000000000080000h:
 |   [0..63] 00000000 00000000 00000000 00000000 00000000 00001000
00000000 00000000
 |   #44 set: PCT Timeout Error
 |
OutErr:      0000002000000000 0000002000000000 0000000000000000
0000000000000000
 |- 0xD00 Outbound Error Status Register _BE_ = 0000002000000000h:
 |   [0..63] 00000000 00000000 00000000 00100000 00000000 00000000
00000000 00000000
 |   #26 set: CFG Address/Enable Error
 |- 0xD08 Outbound First Error Status Register _BE_ = 0000002000000000h:
 |   [0..63] 00000000 00000000 00000000 00100000 00000000 00000000
00000000 00000000
 |   #26 set: CFG Address/Enable Error
 |
InAErr:      0000000030000000 0000000020000000 8080000000000000
0000000000000000
 |- 0xD80 InboundA Error Status Register _BE_ = 0000000030000000h:
 |   [0..63] 00000000 00000000 00000000 00000000 00110000 00000000
00000000 00000000
 |   #34 set: PCT Timeout
 |   #35 set: PCT Unexpected Completion
 |- 0xD88 InboundA First Error Status Register _BE_ = 0000000020000000h:
 |   [0..63] 00000000 00000000 00000000 00000000 00100000 00000000
00000000 00000000
 |   #34 set: PCT Timeout
 |- 0xDC0 InboundA Error Log Register 0 = 8080000000000000h


"A PCI completion timeout occurred for an outstanding PCI-E transaction"
it is.

This is how I bind the device to vfio:

echo vfio-pci > '/sys/bus/pci/devices/0000:01:00.0/driver_override'
echo vfio-pci > '/sys/bus/pci/devices/0000:01:00.1/driver_override'
echo '0000:01:00.0' > '/sys/bus/pci/devices/0000:01:00.0/driver/unbind'
echo '0000:01:00.1' > '/sys/bus/pci/devices/0000:01:00.1/driver/unbind'
echo '0000:01:00.0' > /sys/bus/pci/drivers/vfio-pci/bind
echo '0000:01:00.1' > /sys/bus/pci/drivers/vfio-pci/bind


and I noticed that EEH only happens with the last command. The order
(.0,.1  or .1,.0) does not matter, it seems that putting one function to
D3 is fine but putting another one when the first one is already in D3 -
produces EEH. And I do not recall ever seeing this on the firestone
machine. Weird.


-- 
Alexey
