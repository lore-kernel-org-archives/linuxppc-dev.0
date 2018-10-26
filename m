Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A88ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 22:59:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772BD2085B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 22:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUajRP28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772BD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hfZw15YtzF3Jr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 09:59:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUajRP28";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUajRP28"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hfX62FYTzF3Hm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 09:57:26 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id v6-v6so914941pfm.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qYhiiBsdiphIM31dkqCZssb6s7m8hh19xyu69nIQijk=;
 b=nUajRP28YW/lUTe5kAFL1AKsNhuD2g6jwt08dUgxx2AWeINVRcfporhfSkDqLBbkuV
 Sj2MICowDB0J3thy5yZR0nhqJYYJ0wa7CAswHLKdoeyRVqSZJNxcAoPXgHv+IsMZYlE+
 SeJaXf1b28DsMeMFTxBKu1dvMbyjS7pN7k62G/KsN8jye1Yv2rgy29jg8znJ4I97e+0E
 lk9EMqACx8rJYbbjtZzN+TtGtKd4Kdv839tK7ZReeQ+qcsgrdygO2Px32/+xjV3WvPBI
 zBxw/28FgMi2M0gZABmGuimFiCbBbLim+yhNt5XxX9TQ/Bq+tswtS3A1rb33WLVINndO
 Wwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qYhiiBsdiphIM31dkqCZssb6s7m8hh19xyu69nIQijk=;
 b=tascaXmTEt+J7ulGDycqxoTs6U1TB2ikj1e1A0OvKL10KwhzlyIkZsEfL/A/IoFpBq
 t1VhVjnJ8tRwLs85pgSDsDq2X1Q9dvKIbx4nM0+t+TjSJ92na2ReoxJINU3S4uJE/WES
 UzS3LMguwf3cGBmvRgvBn62x2t9T+eERPkzsY7KVEEdeaGS/6Vx1/bd38VzLuTqtcZyR
 wnjmoel+ttRniMbGsN6SYfsIuaeGEzRAQ9obItklt1t7i6WSzoB6JbtQhov3qqOPuapB
 hFj208aJQWJkayogRcFvhCEOTwXL1JSBmFo8tPgfaX6W5cIti8wNpZQOj0iuMxe55V6D
 e4pg==
X-Gm-Message-State: AGRZ1gIKvqkNYvV9pZ5U9j1n+RWWl9suDt8hZj6+UJ68uk7dqzojdUn2
 MR1UKHCSxquTz8oBbkQl4g0=
X-Google-Smtp-Source: AJdET5eZhMw+VtSnkMbESBH/basCAgkUBB3dYbi4+9BmejOMGNYTiaIO0mqAheq5MX8Kk6DlcRU5EQ==
X-Received: by 2002:a63:9b09:: with SMTP id
 r9-v6mr5218655pgd.307.1540594643615; 
 Fri, 26 Oct 2018 15:57:23 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id
 y85-v6sm19515991pfa.120.2018.10.26.15.57.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Oct 2018 15:57:22 -0700 (PDT)
Subject: Re: ethernet "bus" number in DTS ?
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
 <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
 <694b6f4f6b66eb35176e3eb48bbec474c9647007.camel@infinera.com>
 <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
 <20181024082239.5ee41017@naga.suse.cz>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <27720d1a-a002-5090-d4fc-92ea59b5839a@gmail.com>
Date: Fri, 26 Oct 2018 15:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024082239.5ee41017@naga.suse.cz>
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
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 robh@kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/23/18 11:22 PM, Michal Suchánek wrote:
> On Tue, 23 Oct 2018 11:20:36 -0700
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> On 10/23/18 11:02 AM, Joakim Tjernlund wrote:
>>> On Tue, 2018-10-23 at 10:03 -0700, Florian Fainelli wrote:  
> 
>>>
>>> I also noted that using status = "disabled" didn't work either to
>>> create a fix name scheme. Even worse, all the eth I/F after gets
>>> renumbered. It seems to me there is value in having stability in
>>> eth I/F naming at boot. Then userspace(udev) can rename if need be. 
>>>
>>> Sure would like to known more about why this feature is not wanted ?
>>>
>>> I found
>>>   https://patchwork.kernel.org/patch/4122441/
>>> You quote policy as reason but surely it must be better to
>>> have something stable, connected to the hardware name, than
>>> semirandom naming?  
>>
>> If the Device Tree nodes are ordered by ascending base register
>> address, my understanding is that you get the same order as far as
>> platform_device creation goes, this may not be true in the future if
>> Rob decides to randomize that, but AFAICT this is still true. This
>> may not work well with status = disabled properties being inserted
>> here and there, but we have used that here and it has worked for as
>> far as I can remember doing it.
> 
> So this is unstable in several respects. First is changing the
> enabled/disabled status in the deivecetrees provided by the kernel.
> 
> Second is if you have hardware hotplug mechanism either by firmware or
> by loading device overlays.
> 
> Third is the case when the devicetree is not built as part of the
> kernel but is instead provided by firmware that initializes the
> low-level hardware details. Then the ordering by address is not
> guaranteed nor is that the same address will be used to access the same
> interface every time. There might be multiple ways to configure the
> hardware depending on firmware configuration and/or version.
> 
>  
>> Second, you might want to name network devices ethX, but what if I
>> want to name them ethernetX or fooX or barX? Should we be accepting a
>> mechanism in the kernel that would allow someone to name the
>> interfaces the way they want straight from a name being provided in
>> Device Tree?
> 
> Clearly if there is text Ethernet1 printed above the Ethernet port we
> should provide a mechanism to name the port Ethernet1 by default.

Yes, but then have a specific property that is flexible enough to
retrieve things like "vital product information". For DSA switches, we
have an optional "label" property which names the network device
directly like it would be found on the product's case. Ideally this
should be much more flexible such that it can point to the appropriate
node/firmware service/whatever to get that name, which is what some
people have been working on lately, see [1].

[1]: https://lkml.org/lkml/2018/8/14/1039

The point is don't re-purpose the aliases which is something that exists
within Device Tree to basically provide a shorter path to a specific set
of nodes for the boot program to mangle and muck with instead of having
to resolve a full path to a node. At least that is how I conceive it.

Now what complicates the matter is that some OSes like Linux tend to use
it to also generate seemingly stable index for peripherals that are
numbered by index such as SPI, I2C, etc buses, which is why we are
having this conversation here, see below for more.

> 
>>
>> Aliases are fine for providing relative stability within the Device
>> Tree itself and boot programs that might need to modify the Device
>> Tree (e.g: inserting MAC addresses) such that you don't have to
>> encode logic to search for nodes by compatible strings etc. but
>> outside of that use case, it seems to me that you can resolve every
>> naming decision in user-space.
> 
> However, this is pushing platform-specific knowledge to userspace. The
> way the Ethernet interface is attached and hence the device properties
> usable for identifying the device uniquely are platform-specific.

There is always going to be some amount of platform specific knowledge
to user-space, what matters is the level of abstraction that is
presented to you.

> 
> On the other hand, aliases are universal when provided. If they are
> good enough to assign a MAC address they are good enough to provide a
> stable default name.

We are not talking about the same aliases then. The special Device Tree
node named "aliases" is a way to create shorted Device Tree node paths,
it is not by any means an equivalent for what I would rather call a
"label", or "port name" or silk screen annotation on a PCB for instance.

> 
> I think this is indeed forcing the userspace to reinvent several wheels
> for no good reason.

udev or systemd will come up with some stable names for your network
device right off the bat. If you are deeply embedded maybe you don't
want those, but then use something like the full path in /sys to get
some stable names based on the SoC's topology.

> 
> What is the problem with adding the aliases?

aliases is IMHO the wrong tool for the job because it is too limiting,
you want it to be used to have Ethernet controller instance N to be
named "ethN", what if someone tomorrows says, no this is not good, I
want the aliases to automatically name my network devices
"ethernet-controllerN" or "blahblahN"? You see where I am getting with that?

And yes, I do realize that Linux has traditionally named Ethernet
adapters ethN, but also allows people to name interfaces just the way
they want even from within the drivers themselves.

Now imagine your platform uses ACPI, and there are no aliases there to
point a node with a shorter name, how we would go about naming your
Ethernet controller unless there is a specific VPD/label/sticker
property that can be somehow be retried?
-- 
Florian
