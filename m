Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7677BC520D3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 22:38:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB832080F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 22:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak5FriCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB832080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4300w71W3zzF3S4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 09:37:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak5FriCF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=mr.nuke.me@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak5FriCF"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4300sQ2jnDzF3MK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 09:35:37 +1100 (AEDT)
Received: by mail-ot1-x343.google.com with SMTP id u3so3228548ota.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 14:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f6e3NUzPk6E23/41NUbfQh9v7P2qiL3eVMmbh9RoicY=;
 b=Ak5FriCFZt5VJR+qtIQ8a/UiE7D4bGL08LLZqFaH+8E4ym5XI/PIjL61hYrgwqYKoO
 zQf3XM8UrtfYfpOrHI4rzLzx5Dfm41k0iNtJBPbQp2p9WN5iobXp6fTzoqRKWK91TnkP
 lYh0Ol6HpjqQCNsQAlw8o1uRexsV39ROpAhDka9OWZ5KRoKvKtFzloUuGLFmNoS2yJXb
 nrEf58pXoP6hOa2CQx3Ekz0MNOEJHO75+kCc8t27ytO96yIgu1LP9x8z/D2kf9JsMZSy
 099Iw/pup8y9HPXms1n+ZEJPoxEK03RR3msOIDqtBGk84zTlAoUE2JNY0YLi1UxUGu84
 Q6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f6e3NUzPk6E23/41NUbfQh9v7P2qiL3eVMmbh9RoicY=;
 b=sGm2hI5qiMvfw7NoCPqqHzPLyolkvasL6peIqOna0oXKemnQ3k0EeGkevL+lJTwzSN
 PifbvCj8lQr2svjOqTN9+F3FMHST9kIWGzHDeUMaRcUsYiD8CWCgh7wrmChGgHHfVepU
 sOT/6vccNocOrPqclt+K0zF6/qu1z2U2pG7l9XqxVZt5PAkNCMPr2QpwDqOVHuOTWnzS
 5azS38sGPzdaSkvIdSoe0is6ACkCm1ZGt5H7YoIj3QmcKOE2E4eYk0u1yWIpIW3o3Leu
 GYHDyEogC6Inrjsz8jY1C+r97Nei2kTqJg9yN45P0GVsz3p8bdxYqQI1w7LWJJtoIghQ
 HKzQ==
X-Gm-Message-State: AA+aEWZaVmNTe5BCkWyvha/YzIl5YqcyMbRey/jg9VoSFR9knNIcF9lV
 QYWQWq3KOCEa6aZgYmPD2pkq7Yq2lQo=
X-Google-Smtp-Source: AFSGD/UcY3SmSgFUsBhzA32ONPDix5NpCanc/tXefrFbm5RFdyI9a+c5r9DIuoEaG0J1n5Tu5bA+mg==
X-Received: by 2002:a9d:dd:: with SMTP id 29mr2413509otk.90.1542753335840;
 Tue, 20 Nov 2018 14:35:35 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net.
 [98.195.139.126])
 by smtp.gmail.com with ESMTPSA id s132-v6sm155467oif.4.2018.11.20.14.35.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Nov 2018 14:35:35 -0800 (PST)
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To: Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>
References: <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <20181120214243.GG26707@localhost.localdomain>
 <bace940c-70d9-6631-9818-43338d194327@kernel.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <ea1048ed-7e9c-4ab5-4a05-01cbddae5c19@gmail.com>
Date: Tue, 20 Nov 2018 16:35:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bace940c-70d9-6631-9818-43338d194327@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Alex_Gagniuc@Dellteam.com, baicar.tyler@gmail.com, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Shyam.Iyer@dell.com, linux-acpi@vger.kernel.org, lukas@wunner.de,
 oohall@gmail.com, Austin.Bolen@dell.com, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/20/2018 04:28 PM, Sinan Kaya wrote:
> On 11/20/2018 4:42 PM, Keith Busch wrote:
>> How does that work? If the OS takes control, it sets up MSIs that FW 
>> don't
>> react to, and disables system errors through PCIe Root Control. Aren't
>> those sys errs the mechanism FW knows it has something to do, which
>> means the OS can effectively fence it off?
> 
> I think this is all implementation detail and doesn't necessarily apply
> to all firmware-first implementation flavors.
> 
> Assumptions are:
> 1. both FW and OS are listening to MSI interrupts

On hax86, I'm not sure FW can listen to MSI interrups. FW only exists in 
SMM, not ring 1-4.

> 2. FW monitors the system errors
> 
> Some FF implementation could route the AER interrupt to a higher privilege
> level. Some other implementation could use INTx or a side-band channel 
> interrupt
> for firmware-interrupt too.
> 
> I have seen all 3 except MSI :) and also firmware never monitored the 
> system
> error bits. I was curious if anybody ever used those legacy bits. Now, I 
> know
> someone is using it.
