Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75782C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 20:10:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D3D20671
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 20:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsKyF8TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D3D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fkyR4nY3zF38q
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:10:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BsKyF8TG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BsKyF8TG"; 
 dkim-atps=neutral
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fkvh0CJczDrcP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 07:07:43 +1100 (AEDT)
Received: by mail-wr1-x431.google.com with SMTP id u1-v6so3081228wrn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WODuBDzGsRXEnPUpvka9vMQ8ULOK280yv439QBCY2CM=;
 b=BsKyF8TG9GUwOkODwZGROL8huzvNUSAk8tV7drEnpUEqQgco7bpVPrbbL4Xv5ZRCKh
 sCFj1x7/NbHpuMsQiynePjt/Q+bkoBVQO1VsLaazLwPkqWDIRf5jD+NH1Rf28AAS7XVU
 sAAzHKQkHFOkPcSivhWo15PjJn2cEtuFaonMptIX1mdXkZqIOdahoQqxvvV1AkaC3sfm
 q/q73GqK/9uw5SL3Uc/WID2orcUoAU0Vuy5//BZ+Y27BkGvjw8nJNzCyQyNzKO7J2Pre
 a8FEi/6R3ES2Ez/CmNPO+tzYZyAFhvSwUMSt0/wCae2Ze7pq1Mvj8kuNB3BE2DQCKF5H
 zEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WODuBDzGsRXEnPUpvka9vMQ8ULOK280yv439QBCY2CM=;
 b=DC/ZTv0eTMTzQ6lapAFBmNfHbQ2lbQQQAg+Oc5KSi8+kMU98ArLE6seZFpfpF3QzB/
 PuyoclHZ+2PlxuMkuZNQze2Okc/9bdyx9+AnhMIsD5NFjXSNcmV8Hd9G38oYNaBkqzcd
 7eTxQxdjgCUOK7jHG+p2L5bwkmgYJ/EedtWIAqGL42GzrA1032SI0UzBlKqStMD/rzU7
 EbngI72t6/JOIPsM3aVriQDRTVSWu6BvnO2dxfhEuhitkhAJuNWxxjuJO42gasEiADsm
 QAQ4o3kdvF1VKBaSonnS6V5BCuoWzl5vyxVTdRXH3LfXDY+GSpXain0oYO5FiDGkiLtL
 m2rA==
X-Gm-Message-State: ABuFfohhSLrLHXtQi1Oewh0Xs5gDsQqEd0UAtUVAQLq9VFApr3B72c3u
 /SAaMbAFAEMO9LD45yyqmqQ=
X-Google-Smtp-Source: ACcGV62Bd4i/RqOVb/JNlZo5kxjo0yiwA9/nUV5fDWl1klyDO973bvMlsvYsAl1KNwqElqrJUuHvIA==
X-Received: by 2002:adf:92a6:: with SMTP id
 35-v6mr54268515wrn.137.1540325260310; 
 Tue, 23 Oct 2018 13:07:40 -0700 (PDT)
Received: from [10.67.51.150] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id
 y64-v6sm2781203wmy.35.2018.10.23.13.07.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Oct 2018 13:07:39 -0700 (PDT)
Subject: Re: ethernet "bus" number in DTS ?
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
 <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
 <694b6f4f6b66eb35176e3eb48bbec474c9647007.camel@infinera.com>
 <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
 <af78570fc7874ca656ee2d81c3841f789fc7d0eb.camel@infinera.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <adaad568-bbaf-fd5d-a2c3-ae7bf1be3d31@gmail.com>
Date: Tue, 23 Oct 2018 13:07:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <af78570fc7874ca656ee2d81c3841f789fc7d0eb.camel@infinera.com>
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
Cc: "andrew@lunn.ch" <andrew@lunn.ch>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/23/18 1:02 PM, Joakim Tjernlund wrote:
> On Tue, 2018-10-23 at 11:20 -0700, Florian Fainelli wrote:
>>
>> On 10/23/18 11:02 AM, Joakim Tjernlund wrote:
>>> On Tue, 2018-10-23 at 10:03 -0700, Florian Fainelli wrote:
>>>>
>>>>
>>>> On 10/23/18 9:49 AM, Joakim Tjernlund wrote:
>>>>> SPI (and others) has a way to define bus number in a aliases:
>>>>>       aliases {
>>>>>               ethernet4 = &enet4;
>>>>>               ethernet0 = &enet0;
>>>>>               ethernet1 = &enet1;
>>>>>               ethernet2 = &enet2;
>>>>>               ethernet3 = &enet3;
>>>>>               spi0 = &spi0
>>>>>       };
>>>>> The 0 in the spi0 alias will translate to bus num 0 so one can control the /dev nodes, like /dev/spidev0
>>>>> I am looking for the same for ethernet devices:
>>>>>  ethernet4 = &enet4;  /* should become eth4 */
>>>>>  ethernet0 = &enet0;  /* should become eth0 */
>>>>> but I cannot find something like that for eth devices.
>>>>>
>>>>> Could such functionality be added?
>>>>
>>>> It could, do we want and need to, no. You have the Ethernet alias in
>>>> /sys/class/net/*/device/uevent already that would allow you to perform
>>>> that (re)naming in user-space:
>>>>
>>>> # cat /sys/class/net/eth0/device/uevent
>>>> DRIVER=bcmgenet
>>>> OF_NAME=ethernet
>>>> OF_FULLNAME=/rdb/ethernet@f0480000
>>>> OF_TYPE=network
>>>> OF_COMPATIBLE_0=brcm,genet-v5
>>>> OF_COMPATIBLE_N=1
>>>> OF_ALIAS_0=eth0                 <==================
>>>> MODALIAS=of:NethernetTnetworkCbrcm,genet-v5
>>>
>>> Yes, one can if one uses udev and can find something to identify the hw I/F with, my
>>> cat /sys/class/net/eth0/device/uevent looks like:
>>> DRIVER=fsl_dpa
>>> MODALIAS=platform:dpaa-ethernet
>>
>> Does not dpaa have a notion of Ethernet ports and those should have
>> proper information? Maybe that is part of your problem here, it should
>> have the OF_ALIAS information somehow available.
> 
> I cannot say ATM, but this lack of standard does not make it easier to rename I/F's in udev.
> 
>>
>>> not sure mdev supports this, does it?
>>> Our simple installer FS(initramfs) doesn't have either udev or mdev.
>>
>> I don't know, but you could have a simple shell script that looks at
>> specific network device properties to decide on the naming and call
>> ifrename.
> 
> This reinventing of the wheel is what I am trying to avoid.

Embedded is all about being a special snowflake and re-inventing the
wheel, but having some desktop-like distribution user-space would
certainly allow you to re-invent other parts of the wheel.

> 
>>
>>> I also noted that using status = "disabled" didn't work either to create a fix name scheme.
>>> Even worse, all the eth I/F after gets renumbered. It seems to me there
>>> is value in having stability in eth I/F naming at boot.
>>> Then userspace(udev) can rename if need be.
>>>
>>> Sure would like to known more about why this feature is not wanted ?
>>>
>>> I found
>>>   https://patchwork.kernel.org/patch/4122441/
>>> You quote policy as reason but surely it must be better to
>>> have something stable, connected to the hardware name, than semirandom naming?
>>
>> If the Device Tree nodes are ordered by ascending base register address,
>> my understanding is that you get the same order as far as
>> platform_device creation goes, this may not be true in the future if Rob
>> decides to randomize that, but AFAICT this is still true. This may not
>> work well with status = disabled properties being inserted here and
>> there, but we have used that here and it has worked for as far as I can
>> remember doing it.
> 
> I recall it is the order in which the eth alias appear that controls the naming,
> not 100% sure though.

Aliases are not looked up at all by the platform bus code other that
with of_get_alias() and friends, it is the order in which the nodes are
declared in the Device Tree, preferably ordered by base address that
dictates the order in which platform devices are created.

> 
>>
>> Second, you might want to name network devices ethX, but what if I want
>> to name them ethernetX or fooX or barX? Should we be accepting a
>> mechanism in the kernel that would allow someone to name the interfaces
>> the way they want straight from a name being provided in Device Tree?
> 
> I just want to have stable boot names, aka ethX, which can defined in
> the platforms DT. Then userspace can go from there to whatever it needs,
> udev could possibly use these stable boot names to identify the I/F's to rename.
> 
> ATM, it is pretty hard to even use udev when /sys/class/net/eth0/device/uevent
> can look different even for OF created interfaces.

network devices have a gazillion of other sysfs attributes that all make
them unique enough to create stable names.

> 
>>
>> Aliases are fine for providing relative stability within the Device Tree
>> itself and boot programs that might need to modify the Device Tree (e.g:
>> inserting MAC addresses) such that you don't have to encode logic to
>> search for nodes by compatible strings etc. but outside of that use
>> case, it seems to me that you can resolve every naming decision in
>> user-space.
> 
> Well, you can resolve MAC address assignment in user space too but most
> will agree that is not convenient. I suggest it is also handy to have
> some control of I/F enumeration(ethX that is) from platform code like DT.

If that is what you desire because you do not want to use user-space to
do that job, that is probably fine, it's open source after all, an not
every patch is a candidate for being included upstream. A patch doing
what you describe would likely be rejected again.
-- 
Florian
