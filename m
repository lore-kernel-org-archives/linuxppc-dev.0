Return-Path: <linuxppc-dev+bounces-21173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DF8CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 16:05:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKffT6Gm1z3brM;
	Wed, 20 May 2026 02:05:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779206753;
	cv=none; b=geKpkeZ6dInZ/dUaG5vSE/F0aqhxT2cF5tb84qgbLsmsqEk0uYzz63r5zxeUxd0UKISorkmuAe26PHakVBl7kOpSTPM1YAM9rN67rZa9e42udwV/bROh+wMKqPedgUFQgOMSaC+ZCSENOLlm8X7r6sQMx6LFWWTYNA9VCvxAvjMU8DOgjPG6DIJ/e6+iOEbGUEbbkJFlbssob5mUph/5V0zW8/xoINI7nA3CgsRFbztu0kUKu4mzFUOZ7NEEZtflkzMWJRWaSkRyWaI4gme6GHcyJ1r6xPKJMTJOgoiImmzMiwP1th/rO1bkmLPzklddE5vfiziZJEYoxsxr3xioaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779206753; c=relaxed/relaxed;
	bh=ZU0ykn9hyq36acl9/eenJu6rY5Hc5ratI3S9NDiutnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcD+LMPuyEXFmoCEHW8MWI6i15cLomo3goYg8BlUQkbFaOZuugrO7+tWBs2fIppSdVnuCChKcxpA1obRy5Wo30xqxULoQAzXdkPwjpbiDHtZRRLIipju5l2yYZu9XxVLpUS9Ro/LSrG86U83io8q+gWsZipyqFAyV4x6MjxjCMPH/lONLErsEdslFyXcGqE3mpRZh34GOcl/C6KkWQ9CLJBt42CQFtqJ46fBbL2YH+KZ6mKz3gjUZPScdUVggLvOZwQW6R+fWVceBaR3ZgGalvDmgCF3Y//9ujLi0nwgQUkhmc7Y8XIByXKm73r1buyBm7AoAcfDwzmIUjOKnu8k2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=SZEHgxoF; dkim-atps=neutral; spf=temperror (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=SZEHgxoF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=arista.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKffN3jTMz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 02:05:27 +1000 (AEST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso31137775e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779206724; x=1779811524; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZU0ykn9hyq36acl9/eenJu6rY5Hc5ratI3S9NDiutnY=;
        b=SZEHgxoF7dAS011JXbF3G7Xeyx3QT/3funHdn6YmtxwPFc5xN+VDj9HI6JbHSUKz5J
         iNVWx2KJv950GkAFmxPryZl25F+i7poSTSOzo0VYLFrX9vodruRUJqlzkqX4PBs+Fulk
         KvBz1RlhRpZHHsLF5228SKrTGrpMmtsdigq7DnlETHdMKo2v88E3wkK1KyAKR082OSmn
         rd4hQLpNduth/2Iy9AmFM5Saczkmkszam5kg9kNJoNH0GUxesoA40JPahYP4KRoN7gV3
         kIz1bBxmFO26KHcfHdnE1bPzSAiCeV7neFNk+hYPNMR6CATNNEYqYNuV0knO0SczlWXp
         KYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206724; x=1779811524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZU0ykn9hyq36acl9/eenJu6rY5Hc5ratI3S9NDiutnY=;
        b=SsA/jTzPtzsRTUZkLfvCmynQhjhTUIXa0kkMLgASvwSYTbhJICwY2zJLbuBCXUXGh3
         R2V+vqyTbMWx/CXQtPCdMEbjM7MiSS1NxgK6GJdkMoB3ZD6IR7rA3e7fQJcvUlDFjjKE
         VKjeB6//wwT/7uggA8pcm2p3tZKHBVCKDVGJsVdYzDeWd1Z77V+lfyeNZg1aGkJ94wxd
         Z3G+aTt1qberEGHAyPKSkMSvIxjXombV9TT8j3FHGKeIcb5u3Em78i1s6pIiIP0xxlgR
         K0UQ8YxE7m6hDbW32CvL10tCtbtTrGpS6/USQ+G0AEEokifyY7m52yWZnEHFLZOGb1mM
         E2Wg==
X-Forwarded-Encrypted: i=1; AFNElJ9y0NCUfjhvMprvnqZ2DF1oq/jrRbVDaTGpGyOQPd/7Nqk0qmohKhQhpqMsqjmjbtSQ6itMaHZyVE3x69o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwYqQdqYxkzd4Gs38RoloX4tjDhFWNePOc9K1Exog2eIqFDKqry
	VqDV9i8bNQiEr5cZlCYIWjK/DyAnQpIZiRrL0Fph1CakdjAfFq9VfWO+o3+exThVvw==
X-Gm-Gg: Acq92OFYkfQhcpdCaVPcVymirMzWDMxkXCu39t8GH/2R7aFFS7wcajrEFk/ndG1fZ22
	devlk2w9owuvPsHBwkY+Y+jfvH+YemRGBkCBPaS8ra6f6a2BjL0IdP4YHFFMVpqOnFne2yy8J5H
	lgHCa0LmeFgB5247vWhnioEiKa7Jjoo1HmNyqOP4g3fCjwa3ka0ck/mvM0TqVblfI8bE6IkyzuQ
	flFEz/rdueO5kKPiUAIuTpCpR4ICfQlLPRsLHPqVftMpmlICqaN9BenWilQzTJT7TjNFsWIzR7Y
	QZXUJtkn80pU8NH5A4w+6xuJ/racZTzl6dyC5on4TLnHtOC73jPw3e9+CsBcuvoMxuPZjh32l9e
	o5LfDGOnEecFcWoWcvCsJZB5y0Aoau4u7uu7SKx+UMVL/GRNKwKpmLPCc6zojAQQwud7JTUmWOR
	pCLUsYC0KlqSMo3TQNWbzDD/xd7AtEullsMg==
X-Received: by 2002:a05:600c:1505:b0:48f:ed68:6760 with SMTP id 5b1f17b1804b1-48fed6867famr164849395e9.29.1779206723016;
        Tue, 19 May 2026 09:05:23 -0700 (PDT)
Received: from [10.83.43.186] ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88e5asm358448345e9.6.2026.05.19.09.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 09:05:21 -0700 (PDT)
Message-ID: <3633b587-5782-4cfa-b967-997de86866bb@arista.com>
Date: Tue, 19 May 2026 17:05:20 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
 <agwzHzF3bpPM6jcC@wunner.de>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <agwzHzF3bpPM6jcC@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1 OzLabs 8
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Root port can detect AER error with source 0000:00:00.0.

In this case, we call find_source_device -> find_device_iter. The 
'multi-error' flag is not set, and we are looking for the first error 
(not all). This means that for any error with the 0000:00:00.0 source on 
the root port, we will report the error for the first device on the bus. 
If AER recovery fails for this device, we will never do an error 
cleanup. AER recovery can fail because some devices on the bus report 
PCI_ERS_RESULT_NO_AER_DRIVER, but I am sure there are other reasons.

Please find the requested PCIe info below.

In my case, an AER error reported by 0000:06:08.0 will be logged as an 
error reported by 0000:06:07.0 if AER recovery constantly fails.

Logs:

[  475.568144] pcieport 0000:00:03.0: AER: Uncorrectable (Non-Fatal) 
error message received from 0000:00:00.0
[  475.568255] pcieport 0000:06:07.0: PCIe Bus Error: 
severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
[  475.703860] pcieport 0000:06:07.0:   device [11f8:8533] error 
status/mask=00100000/04400000
[  475.727967] pcieport 0000:52:02.0: Unable to change power state from 
D3hot to D0, device inaccessible
[  475.804002] pcieport 0000:06:07.0:    [20] UnsupReq      (First)
[  475.804008] pcieport 0000:06:07.0: AER:   TLP Header: 60000001 
0000010f 0000380e 00000068
[  475.916817] tg3 0000:49:00.0 lc3: PCI I/O error detected
[  476.094461] eth0: port 3(lc4) entered disabled state#8 #11 #1  #3  
#4  #7  #9 #10
[  476.096010] br1: port 14(lc4.42) entered disabled state
[  476.097188] eth0: port 3(lc4) entered disabled state
[  476.097485] lc4.42 (unregistering): left allmulticast modC
[  476.097491] tg3 0000:54:00.0 lc4 (unregistering): left allmulticast mode
[  476.097494] lc4.42 (unregistering): left promiscuous mode
[  476.097508] tg3 0000:54:00.0 lc4 (unregistering): left promiscuous 
modeS)
[  476.097513] br1: port 14(lc4.42) entered disabled state
[  476.224325] pci 0000:46:00.1: AER: can't recover (no error_detected 
callback)
[  476.224333] pci 0000:46:00.2: AER: can't recover (no error_detected 
callback)
[  476.224335] pci 0000:46:00.3: AER: can't recover (no error_detected 
callback)
[  476.224338] pci 0000:46:00.4: AER: can't recover (no error_detected 
callback)
[  476.224371] pcieport 0000:06:07.0: AER: device recovery failedy

lspci output: # lspci -vt
-+-[0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DMI2
  |           +-01.0-[01]--
  |           +-01.1-[02]--
  |           +-02.0-[03]--+-00.0  Intel Corporation Xeon Processor D 
Family QuickData Technology Register DMA Channel 0
  |           |            +-00.1  Intel Corporation Xeon Processor D 
Family QuickData Technology Register DMA Channel 1
  |           |            +-00.2  Intel Corporation Xeon Processor D 
Family QuickData Technology Register DMA Channel 2
  |           |            \-00.3  Intel Corporation Xeon Processor D 
Family QuickData Technology Register DMA Channel 3
  |           +-02.2-[04]--+-00.0  Intel Corporation Ethernet Connection 
X552 10 GbE Backplane
  |           |            \-00.1  Intel Corporation Ethernet Connection 
X552 10 GbE Backplane
  | 
  +-03.0-[05-9e]--+-00.0-[06-9d]--+-00.0-[07-10]--+-00.0-[08-10]--+-01.0-[09-0c]----00.0 
Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |               |         
      +-02.0-[0d-0f]--
  |           |               |               |               |         
      \-03.0-[10]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |  +-00.1  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.2  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.3  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  \-00.4  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-01.0-[11-1a]--+-00.0-[12-1a]--+-01.0-[13-16]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |               |         
      +-02.0-[17-19]--
  |           |               |               |               |         
      \-03.0-[1a]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |  +-00.1  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.2  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.3  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  \-00.4  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-02.0-[1b-24]--+-00.0-[1c-24]--+-01.0-[1d-20]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |               |         
      +-02.0-[21-23]--
  |           |               |               |               |         
      \-03.0-[24]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |  +-00.1  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.2  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.3  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  \-00.4  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-03.0-[25-2e]--+-00.0-[26-2e]--+-01.0-[27-2a]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |               |         
      +-02.0-[2b-2d]--
  |           |               |               |               |         
      \-03.0-[2e]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |  +-00.1  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.2  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.3  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  \-00.4  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-04.0-[2f-38]--+-00.0-[30-38]--+-01.0-[31-34]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |               |         
      +-02.0-[35-37]--
  |           |               |               |               |         
      \-03.0-[38]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |  +-00.1  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.2  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.3  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  \-00.4  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-05.0-[39-42]--+-00.0-[3a-42]--+-01.0-[3b-3e]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |               |         
      +-02.0-[3f-41]--
  |           |               |               |               |         
      \-03.0-[42]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |  +-00.1  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.2  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.3  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  \-00.4  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               +-06.0-[43-45]--
  |           |               | 
  +-07.0-[46-50]--+-00.0-[47-50]--+-02.0-[48]--
  |           |               |               |               |         
      \-0d.0-[49-50]----00.0  Broadcom Inc. and subsidiaries NetXtreme 
BCM57762 Gigabit Ethernet PCIe
  |           |               |               |  +-00.1  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.2  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.3  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  \-00.4  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-08.0-[51-5b]--+-00.0-[52-5b]--+-02.0-[53]--
  |           |               |               |               |         
      \-0d.0-[54-5b]----00.0  Broadcom Inc. and subsidiaries NetXtreme 
BCM57762 Gigabit Ethernet PCIe
  |           |               |               |  +-00.1  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.2  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  +-00.3  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               |  \-00.4  PLX Technology, 
Inc. PEX PCI Express Switch DMA interface
  |           |               |               +-09.0-[5c-66]--
  |           |               |               +-0a.0-[67-71]--
  |           |               |               +-0b.0-[72-7c]--
  |           |               |               +-0c.0-[7d-87]--
  |           |               |               +-0d.0-[88-92]--
  |           |               |               \-0e.0-[93-9d]--
  |           |               \-00.1  Microchip Technology PM8533 PFX 
48xG3 PCIe Fanout Switch
  |           +-05.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Map/VTd_Misc/System Management
  |           +-05.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D IIO Hot Plug
  |           +-05.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D IIO RAS/Control Status/Global Errors
  |           +-05.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D I/O APIC
  |           +-14.0  Intel Corporation 8 Series/C220 Series Chipset 
Family USB xHCI
  |           +-1a.0  Intel Corporation 8 Series/C220 Series Chipset 
Family USB EHCI #2
  |           +-1c.0-[9f]----00.0  Arista Networks, Inc. Device 0001
  |           +-1c.1-[a0]--+-00.0  Broadcom Inc. and subsidiaries 
NetXtreme BCM5720 Gigabit Ethernet PCIe
  |           |            \-00.1  Broadcom Inc. and subsidiaries 
NetXtreme BCM5720 Gigabit Ethernet PCIe
  |           +-1c.2-[a1]--
  |           +-1d.0  Intel Corporation 8 Series/C220 Series Chipset 
Family USB EHCI #1
  |           +-1f.0  Intel Corporation C224 Series Chipset Family 
Server Standard SKU LPC Controller
  |           +-1f.2  Intel Corporation 8 Series/C220 Series Chipset 
Family 6-port SATA Controller 1 [AHCI mode]
  |           +-1f.3  Intel Corporation 8 Series/C220 Series Chipset 
Family SMBus Controller
  |           \-1f.6  Intel Corporation 8 Series Chipset Family Thermal 
Management Controller
  \-[0000:ff]-+-0b.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D R3 QPI Link 0/1
              +-0b.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D R3 QPI Link 0/1
              +-0b.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D R3 QPI Link 0/1
              +-0b.3  Arista Networks, Inc. Device 0001
              +-0c.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0c.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0c.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0c.3  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0c.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0c.5  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0f.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0f.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0f.5  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-0f.6  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Caching Agent
              +-10.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D R2PCIe Agent
              +-10.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D R2PCIe Agent
              +-10.5  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Ubox
              +-10.6  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Ubox
              +-10.7  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Ubox
              +-12.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Home Agent 0
              +-12.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Home Agent 0
              +-13.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Target Address/Thermal/RAS
              +-13.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Target Address/Thermal/RAS
              +-13.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel Target Address Decoder
              +-13.3  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel Target Address Decoder
              +-13.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel Target Address Decoder
              +-13.5  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel Target Address Decoder
              +-13.6  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DDRIO Channel 0/1 Broadcast
              +-13.7  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DDRIO Global Broadcast
              +-14.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel 0 Thermal Control
              +-14.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel 1 Thermal Control
              +-14.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel 0 Error
              +-14.3  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel 1 Error
              +-14.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DDRIO Channel 0/1 Interface
              +-14.5  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DDRIO Channel 0/1 Interface
              +-14.6  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DDRIO Channel 0/1 Interface
              +-14.7  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DDRIO Channel 0/1 Interface
              +-15.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel 2 Thermal Control
              +-15.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel 3 Thermal Control
              +-15.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel 2 Error
              +-15.3  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Memory Controller 0 - Channel 3 Error
              +-1e.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Power Control Unit
              +-1e.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Power Control Unit
              +-1e.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Power Control Unit
              +-1e.3  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Power Control Unit
              +-1e.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Power Control Unit
              +-1f.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Power Control Unit
              \-1f.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D Power Control Unit
# lspci -vvvv
00:00.0 Host bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DMI2 (rev 03)
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 0
     IOMMU group: 0
     Capabilities: [90] Express (v2) Root Port (Slot-), IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x4, ASPM L1, Exit 
Latency L1 <16us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         RootCap: CRSVisible-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd-
              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [e0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 
Len=00c <?>
     Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 
Len=03c <?>
     Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 
Len=00a <?>
     Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 
Len=018 <?>
     Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 
Len=038 <?>

00:01.0 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D PCI Express Root Port 1 (rev 03) (prog-if 00 [Normal decode])
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 26
     IOMMU group: 1
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: f000-0fff [disabled] [16-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
         Address: fee07000  Data: 0020
         Masking: 00000002  Pending: 00000000
     Capabilities: [90] Express (v2) Root Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit 
Latency L1 <16us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #2, PowerLimit 0W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet+ LinkState-
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [e0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 
Len=00c <?>
     Capabilities: [110 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [148 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 
Len=00a <?>
     Capabilities: [250 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 
Len=018 <?>
     Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 
Len=038 <?>
     Kernel driver in use: pcieport

00:01.1 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D PCI Express Root Port 1 (rev 03) (prog-if 00 [Normal decode])
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 27
     IOMMU group: 2
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: f000-0fff [disabled] [16-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
         Address: fee02000  Data: 0020
         Masking: 00000002  Pending: 00000000
     Capabilities: [90] Express (v2) Root Port (Slot-), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x4, ASPM L1, Exit 
Latency L1 <16us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [e0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 
Len=00c <?>
     Capabilities: [110 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [148 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 
Len=00a <?>
     Capabilities: [250 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 
Len=018 <?>
     Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 
Len=038 <?>
     Kernel driver in use: pcieport

00:02.0 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D PCI Express Root Port 2 (rev 03) (prog-if 00 [Normal decode])
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 28
     IOMMU group: 3
     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: f000-0fff [disabled] [16-bit]
     Memory behind bridge: fb900000-fb9fffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
         Address: fee04000  Data: 0020
         Masking: 00000002  Pending: 00000000
     Capabilities: [90] Express (v2) Root Port (Slot-), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L1, Exit 
Latency L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [e0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 
Len=00c <?>
     Capabilities: [110 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [148 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 
Len=038 <?>
     Kernel driver in use: pcieport

00:02.2 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D PCI Express Root Port 2 (rev 03) (prog-if 00 [Normal decode])
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 29
     IOMMU group: 4
     Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
     I/O behind bridge: f000-0fff [disabled] [16-bit]
     Memory behind bridge: fba00000-fbafffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: 381e00800000-381e00ffffff 
[size=8M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
         Address: fee06000  Data: 0020
         Masking: 00000002  Pending: 00000000
     Capabilities: [90] Express (v2) Root Port (Slot-), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L1, Exit 
Latency L1 <16us
             ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
         DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis- ARIFwd+
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [e0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 
Len=00c <?>
     Capabilities: [110 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [148 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 
Len=038 <?>
     Kernel driver in use: pcieport

00:03.0 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D PCI Express Root Port 3 (rev 03) (prog-if 00 [Normal decode])
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 30
     IOMMU group: 5
     Bus: primary=00, secondary=05, subordinate=9e, sec-latency=0
     I/O behind bridge: f000-0fff [disabled] [16-bit]
     Memory behind bridge: ce900000-fb8fffff [size=720M] [32-bit]
     Prefetchable memory behind bridge: 380000000000-381e003fffff 
[size=122884M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR+ <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Subsystem: Intel Corporation Device 0000
     Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
         Address: fee08000  Data: 0020
         Masking: 00000002  Pending: 00000000
     Capabilities: [90] Express (v2) Root Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #7, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <16us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #1, PowerLimit 0W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range BCD, TimeoutDis+ NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
         DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [e0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 
Len=00c <?>
     Capabilities: [110 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [148 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 
Len=00a <?>
     Capabilities: [250 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 
Len=018 <?>
     Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 
Len=038 <?>
     Kernel driver in use: pcieport

00:05.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Map/VTd_Misc/System Management (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 6
     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, 
IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE- FLReset- TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-

00:05.1 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D IIO Hot Plug (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 7
     Capabilities: [40] Express (v1) Root Complex Integrated Endpoint, 
IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE- FLReset- TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [100 v1] Vendor Specific Information: ID=0006 Rev=1 
Len=010 <?>
     Capabilities: [110 v1] Vendor Specific Information: ID=0006 Rev=1 
Len=010 <?>
     Capabilities: [120 v1] Vendor Specific Information: ID=0006 Rev=1 
Len=010 <?>
     Capabilities: [130 v1] Vendor Specific Information: ID=0006 Rev=1 
Len=010 <?>

00:05.2 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D IIO RAS/Control Status/Global Errors (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 8
     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, 
IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE- FLReset- TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-

00:05.4 PIC: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D 
I/O APIC (rev 03) (prog-if 20 [IO(X)-APIC])
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     IOMMU group: 9
     Region 0: Memory at fbd10000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: [44] Express (v1) Root Complex Integrated Endpoint, 
IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE- FLReset- TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
     Capabilities: [e0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB xHCI (rev 05) (prog-if 30 [XHCI])
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin D routed to IRQ 49
     IOMMU group: 10
     Region 0: Memory at fbd00000 (64-bit, non-prefetchable) [size=64K]
     Capabilities: [70] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee04000  Data: 0022
     Kernel driver in use: xhci_hcd
     Kernel modules: xhci_pci

00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB EHCI #2 (rev 05) (prog-if 20 [EHCI])
     Subsystem: Intel Corporation Device 7270
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 18
     IOMMU group: 11
     Region 0: Memory at fbd13800 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci
     Kernel modules: ehci_pci

00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])
     Subsystem: Intel Corporation Device 7270
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 31
     IOMMU group: 12
     Bus: primary=00, secondary=9f, subordinate=9f, sec-latency=0
     I/O behind bridge: 2000-2fff [size=4K] [16-bit]
     Memory behind bridge: fbb00000-fbbfffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: 381e00400000-381e005fffff 
[size=2M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #0, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCap: CRSVisible-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee09000  Data: 0020
     Capabilities: [90] Subsystem: Intel Corporation Device 7270
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #2 (rev d5) (prog-if 00 [Normal decode])
     Subsystem: Intel Corporation Device 7270
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 32
     IOMMU group: 13
     Bus: primary=00, secondary=a0, subordinate=a0, sec-latency=0
     I/O behind bridge: 3000-3fff [size=4K] [16-bit]
     Memory behind bridge: 90200000-903fffff [size=2M] [32-bit]
     Prefetchable memory behind bridge: 381e01000000-381e010fffff 
[size=1M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #0, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCap: CRSVisible-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee05000  Data: 0020
     Capabilities: [90] Subsystem: Intel Corporation Device 7270
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset 
Family PCI Express Root Port #3 (rev d5) (prog-if 00 [Normal decode])
     Subsystem: Intel Corporation Device 7270
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin C routed to IRQ 33
     IOMMU group: 14
     Bus: primary=00, secondary=a1, subordinate=a1, sec-latency=0
     I/O behind bridge: 4000-4fff [size=4K] [16-bit]
     Memory behind bridge: 90400000-905fffff [size=2M] [32-bit]
     Prefetchable memory behind bridge: 381e00600000-381e007fffff 
[size=2M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #0, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCap: CRSVisible-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
              IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0b000  Data: 0020
     Capabilities: [90] Subsystem: Intel Corporation Device 7270
     Capabilities: [a0] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset 
Family USB EHCI #1 (rev 05) (prog-if 20 [EHCI])
     Subsystem: Intel Corporation Device 7270
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 18
     IOMMU group: 15
     Region 0: Memory at fbd13c00 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP-
     Kernel driver in use: ehci-pci
     Kernel modules: ehci_pci

00:1f.0 ISA bridge: Intel Corporation C224 Series Chipset Family Server 
Standard SKU LPC Controller (rev 05)
     Subsystem: Intel Corporation Device 7270
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     IOMMU group: 16
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: lpc_ich
     Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series Chipset 
Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
     Subsystem: Intel Corporation Device 7270
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 50
     IOMMU group: 16
     Region 0: I/O ports at 1068 [size=8]
     Region 1: I/O ports at 1080 [size=4]
     Region 2: I/O ports at 1070 [size=8]
     Region 3: I/O ports at 1084 [size=4]
     Region 4: I/O ports at 1000 [size=32]
     Region 5: Memory at fbd13000 (32-bit, non-prefetchable) [size=2K]
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee06000  Data: 0022
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
     Kernel driver in use: ahci
     Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family 
SMBus Controller (rev 05)
     Subsystem: Intel Corporation Device 7270
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 18
     IOMMU group: 16
     Region 0: Memory at fbd14000 (64-bit, non-prefetchable) [size=256]
     Region 4: I/O ports at 1020 [size=32]
     Kernel driver in use: i801_smbus
     Kernel modules: i2c_i801

00:1f.6 Signal processing controller: Intel Corporation 8 Series Chipset 
Family Thermal Management Controller (rev 05)
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 18
     IOMMU group: 16
     Region 0: Memory at fbd12000 (64-bit, non-prefetchable) [size=4K]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Kernel driver in use: intel_pch_thermal
     Kernel modules: intel_pch_thermal

03:00.0 System peripheral: Intel Corporation Xeon Processor D Family 
QuickData Technology Register DMA Channel 0
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 17
     Region 0: Memory at fb900000 (64-bit, non-prefetchable) [size=8K]
     Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 256 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM not supported
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis+ 
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [80] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [90] MSI: Enable- Count=1/1 Maskable+ 64bit-
         Address: 00000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [ac] MSI-X: Enable+ Count=1 Masked-
         Vector table: BAR=0 offset=00001000
         PBA: BAR=0 offset=00001800
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 14, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 04000001 0010000f 03040000 00000000
     Capabilities: [150 v1] Multicast
         McastCap: MaxGroups 16, WindowSz 0 (1 bytes) McastCtl: 
NumGroups 1, Enable-
         McastBAR: IndexPos 12, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: ioatdma
     Kernel modules: ioatdma

03:00.1 System peripheral: Intel Corporation Xeon Processor D Family 
QuickData Technology Register DMA Channel 1
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 17
     IOMMU group: 17
     Region 0: Memory at fb902000 (64-bit, non-prefetchable) [size=8K]
     Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 256 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM not supported
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis+ 
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [80] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [90] MSI: Enable- Count=1/1 Maskable+ 64bit-
         Address: 00000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [ac] MSI-X: Enable+ Count=1 Masked-
         Vector table: BAR=0 offset=00001000
         PBA: BAR=0 offset=00001800
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 14, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 04000001 0010000f 03040000 00000000
     Capabilities: [150 v1] Multicast
         McastCap: MaxGroups 16, WindowSz 0 (1 bytes) McastCtl: 
NumGroups 1, Enable-
         McastBAR: IndexPos 12, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: ioatdma
     Kernel modules: ioatdma

03:00.2 System peripheral: Intel Corporation Xeon Processor D Family 
QuickData Technology Register DMA Channel 2
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 18
     IOMMU group: 17
     Region 0: Memory at fb904000 (64-bit, non-prefetchable) [size=8K]
     Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 256 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM not supported
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis+ 
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [80] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [90] MSI: Enable- Count=1/1 Maskable+ 64bit-
         Address: 00000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [ac] MSI-X: Enable+ Count=1 Masked-
         Vector table: BAR=0 offset=00001000
         PBA: BAR=0 offset=00001800
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 14, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 04000001 0010000f 03040000 00000000
     Capabilities: [150 v1] Multicast
         McastCap: MaxGroups 16, WindowSz 0 (1 bytes) McastCtl: 
NumGroups 1, Enable-
         McastBAR: IndexPos 12, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: ioatdma
     Kernel modules: ioatdma

03:00.3 System peripheral: Intel Corporation Xeon Processor D Family 
QuickData Technology Register DMA Channel 3
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin D routed to IRQ 19
     IOMMU group: 17
     Region 0: Memory at fb906000 (64-bit, non-prefetchable) [size=8K]
     Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 256 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM not supported
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis+ 
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [80] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [90] MSI: Enable- Count=1/1 Maskable+ 64bit-
         Address: 00000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [ac] MSI-X: Enable+ Count=1 Masked-
         Vector table: BAR=0 offset=00001000
         PBA: BAR=0 offset=00001800
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 14, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 04000001 0010000f 03040000 00000000
     Capabilities: [150 v1] Multicast
         McastCap: MaxGroups 16, WindowSz 0 (1 bytes) McastCtl: 
NumGroups 1, Enable-
         McastBAR: IndexPos 12, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: ioatdma
     Kernel modules: ioatdma

04:00.0 Ethernet controller: Intel Corporation Ethernet Connection X552 
10 GbE Backplane
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 18
     Region 0: Memory at 381e00800000 (64-bit, prefetchable) [size=2M]
     Region 4: Memory at 381e00c00000 (64-bit, prefetchable) [size=16K]
     Expansion ROM at fba00000 [disabled] [size=512K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
         Vector table: BAR=4 offset=00000000
         PBA: BAR=4 offset=00002000
     Capabilities: [a0] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v2] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [140 v1] Device Serial Number 00-00-c9-ff-ff-00-00-00
     Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
         ARICap:    MFVC- ACS-, Next Function: 1
         ARICtl:    MFVC- ACS-, Function Group: 0
     Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
         IOVCap:    Migration- 10BitTagReq- IntMsgNum 0
         IOVCtl:    Enable- Migration- Interrupt- MSE- ARIHierarchy+ 
10BitTagReq-
         IOVSta:    Migration-
         Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function 
Dependency Link: 00
         VF offset: 128, stride: 2, Device ID: 15a8
         Supported Page Size: 00000553, System Page Size: 00000001
         Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
         Region 3: Memory at 0000000000000000 (64-bit, non-prefetchable)
         VF Migration: offset: 00000000, BIR: 0
     Capabilities: [1b0 v1] Access Control Services
         ACSCap:    SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
     Capabilities: [1c0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Kernel driver in use: ixgbe
     Kernel modules: ixgbe

04:00.1 Ethernet controller: Intel Corporation Ethernet Connection X552 
10 GbE Backplane
     Subsystem: Intel Corporation Device 0000
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 17
     IOMMU group: 19
     Region 0: Memory at 381e00a00000 (64-bit, prefetchable) [size=2M]
     Region 4: Memory at 381e00c04000 (64-bit, prefetchable) [size=16K]
     Expansion ROM at fba80000 [disabled] [size=512K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
         Vector table: BAR=4 offset=00000000
         PBA: BAR=4 offset=00002000
     Capabilities: [a0] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v2] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [140 v1] Device Serial Number 00-00-c9-ff-ff-00-00-00
     Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
         ARICap:    MFVC- ACS-, Next Function: 0
         ARICtl:    MFVC- ACS-, Function Group: 0
     Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
         IOVCap:    Migration- 10BitTagReq- IntMsgNum 0
         IOVCtl:    Enable- Migration- Interrupt- MSE- ARIHierarchy- 
10BitTagReq-
         IOVSta:    Migration-
         Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function 
Dependency Link: 01
         VF offset: 128, stride: 2, Device ID: 15a8
         Supported Page Size: 00000553, System Page Size: 00000001
         Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
         Region 3: Memory at 0000000000000000 (64-bit, non-prefetchable)
         VF Migration: offset: 00000000, BIR: 0
     Capabilities: [1b0 v1] Access Control Services
         ACSCap:    SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
     Kernel driver in use: ixgbe
     Kernel modules: ixgbe

05:00.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     IOMMU group: 20
     Bus: primary=05, secondary=06, subordinate=9d, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: ce900000-fb8fffff [size=720M] [32-bit]
     Prefetchable memory behind bridge: 380000000000-381dffffffff 
[size=120G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR+ <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable- Count=1/8 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [1b8 v1] Access Control Services
         ACSCap:    SrcValid- TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd- EgressCtrl- DirectTrans+
         ACSCtl:    SrcValid- TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd- EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

05:00.1 Memory controller: Microchip Technology PM8533 PFX 48xG3 PCIe 
Fanout Switch
     Subsystem: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout Switch
     Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 21
     Region 0: Memory at 381e00000000 (64-bit, prefetchable) [size=4M]
     Capabilities: [40] MSI: Enable- Count=1/4 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [50] MSI-X: Enable- Count=4 Masked-
         Vector table: BAR=0 offset=00076000
         PBA: BAR=0 offset=00077000
     Capabilities: [5c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [144 v1] Access Control Services
         ACSCap:    SrcValid- TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd- EgressCtrl- DirectTrans+
         ACSCtl:    SrcValid- TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd- EgressCtrl- DirectTrans-

06:00.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 34
     IOMMU group: 22
     Bus: primary=06, secondary=07, subordinate=10, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: ce900000-d18fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 380000000000-3801ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #1, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee0a000  Data: 0020
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:01.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 35
     IOMMU group: 23
     Bus: primary=06, secondary=11, subordinate=1a, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: d1900000-d48fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 380200000000-3803ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #2, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee00000  Data: 0020
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:02.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 36
     IOMMU group: 24
     Bus: primary=06, secondary=1b, subordinate=24, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: d4900000-d78fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 380400000000-3805ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #3, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee01000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:03.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 37
     IOMMU group: 25
     Bus: primary=06, secondary=25, subordinate=2e, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: d7900000-da8fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 380600000000-3807ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #4, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #4, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee03000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:04.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 38
     IOMMU group: 26
     Bus: primary=06, secondary=2f, subordinate=38, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: da900000-dd8fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 380800000000-3809ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #5, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #5, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee07000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:05.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 39
     IOMMU group: 27
     Bus: primary=06, secondary=39, subordinate=42, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: dd900000-e08fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 380a00000000-380bffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #6, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #6, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee02000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:06.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 40
     IOMMU group: 28
     Bus: primary=06, secondary=43, subordinate=45, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: e0900000-e38fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 380c00000000-380dffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #7, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #7, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee04000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:07.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 41
     IOMMU group: 29
     Bus: primary=06, secondary=46, subordinate=50, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: e3900000-e68fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 380e00000000-380fffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #8, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #8, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee06000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq+ ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 14, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 60000001 0000000f 0000380e 04000068
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:08.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 42
     IOMMU group: 30
     Bus: primary=06, secondary=51, subordinate=5b, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: e6900000-e98fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 381000000000-3811ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #9, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #9, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee08000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq+ ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 14, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 60000001 0000000f 00003810 04000068
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:09.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 43
     IOMMU group: 31
     Bus: primary=06, secondary=5c, subordinate=66, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: e9900000-ec8fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 381200000000-3813ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #10, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #10, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee09000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:0a.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 44
     IOMMU group: 32
     Bus: primary=06, secondary=67, subordinate=71, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: ec900000-ef8fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 381400000000-3815ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #11, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #11, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee05000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:0b.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 45
     IOMMU group: 33
     Bus: primary=06, secondary=72, subordinate=7c, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: ef900000-f28fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 381600000000-3817ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #12, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #12, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee0b000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:0c.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 46
     IOMMU group: 34
     Bus: primary=06, secondary=7d, subordinate=87, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: f2900000-f58fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 381800000000-3819ffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #13, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #13, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee0a000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:0d.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 47
     IOMMU group: 35
     Bus: primary=06, secondary=88, subordinate=92, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: f5900000-f88fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 381a00000000-381bffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #14, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #14, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee00000  Data: 0021
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

06:0e.0 PCI bridge: Microchip Technology PM8533 PFX 48xG3 PCIe Fanout 
Switch (prog-if 00 [Normal decode])
     Subsystem: Microchip Technology Device beef
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 48
     IOMMU group: 36
     Bus: primary=06, secondary=93, subordinate=9d, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: f8900000-fb8fffff [size=48M] [32-bit]
     Prefetchable memory behind bridge: 381c00000000-381dffffffff 
[size=8G] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #15, Speed 8GT/s, Width x16, ASPM L1, Exit 
Latency L1 <64us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #15, PowerLimit 0W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt+ 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [7c] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee01000  Data: 0022
     Capabilities: [8c] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [94] Subsystem: Microchip Technology Device beef
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked+ DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [148 v1] Multicast
         McastCap: MaxGroups 63, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [178 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [1a4 v1] Device Serial Number 50-0e-00-4a-00-00-00-01
     Capabilities: [1b0 v1] Downstream Port Containment
         DpcCap:    IntMsgNum 0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO 
Log 0, DL_ActiveErr+
         DpcCtl:    Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
         DpcSta:    Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
         Source:    0000
     Capabilities: [1bc v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [7f8 v1] Vendor Specific Information: ID=ffff Rev=1 
Len=808 <?>
     Kernel driver in use: pcieport

07:00.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Physical Slot: 1
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 50
     Region 0: Memory at ce900000 (32-bit, non-prefetchable) [size=256K]
     Bus: primary=07, secondary=08, subordinate=10, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380000000000-38000bffffff 
[size=192M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [b00 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

07:00.1 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 1
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 50
     Region 0: Memory at ce940000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

07:00.2 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 1
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 50
     Region 0: Memory at ce942000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

07:00.3 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 1
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 50
     Region 0: Memory at ce944000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

07:00.4 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 1
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 50
     Region 0: Memory at ce946000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

08:01.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 88
     IOMMU group: 50
     Bus: primary=08, secondary=09, subordinate=0c, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380000000000-380003ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee08000  Data: 0023
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #1, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

08:02.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 89
     IOMMU group: 50
     Bus: primary=08, secondary=0d, subordinate=0f, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380004000000-380007ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee09000  Data: 0023
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #2, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending+ InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

08:03.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 90
     IOMMU group: 50
     Bus: primary=08, secondary=10, subordinate=10, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380008000000-38000bffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 00ef
         Masking: 000000ff  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #3, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

09:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Physical Slot: 1-2
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 122
     IOMMU group: 50
     Region 0: Memory at 380000800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380000000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee0b000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

10:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 115
     IOMMU group: 50
     Region 0: Memory at 380008800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380008000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee07000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

11:00.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Physical Slot: 2
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 17
     IOMMU group: 51
     Region 0: Memory at d1900000 (32-bit, non-prefetchable) [size=256K]
     Bus: primary=11, secondary=12, subordinate=1a, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380200000000-38020bffffff 
[size=192M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [b00 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

11:00.1 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 2
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 51
     Region 0: Memory at d1940000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

11:00.2 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 2
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 51
     Region 0: Memory at d1942000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

11:00.3 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 2
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 51
     Region 0: Memory at d1944000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

11:00.4 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 2
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 51
     Region 0: Memory at d1946000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

12:01.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 91
     IOMMU group: 51
     Bus: primary=12, secondary=13, subordinate=16, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380200000000-380203ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee05000  Data: 0023
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #1, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

12:02.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 92
     IOMMU group: 51
     Bus: primary=12, secondary=17, subordinate=19, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380204000000-380207ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee0b000  Data: 0023
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #2, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending+ InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

12:03.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 93
     IOMMU group: 51
     Bus: primary=12, secondary=1a, subordinate=1a, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380208000000-38020bffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 00ef
         Masking: 000000ff  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #3, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

13:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Physical Slot: 1-3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 118
     IOMMU group: 51
     Region 0: Memory at 380200800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380200000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee06000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

1a:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 119
     IOMMU group: 51
     Region 0: Memory at 380208800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380208000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee08000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

1b:00.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Physical Slot: 3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 18
     IOMMU group: 53
     Region 0: Memory at d4900000 (32-bit, non-prefetchable) [size=256K]
     Bus: primary=1b, secondary=1c, subordinate=24, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380400000000-38040bffffff 
[size=192M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [b00 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

1b:00.1 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 3
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 53
     Region 0: Memory at d4940000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

1b:00.2 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 3
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 53
     Region 0: Memory at d4942000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

1b:00.3 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 3
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 53
     Region 0: Memory at d4944000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

1b:00.4 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 3
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 53
     Region 0: Memory at d4946000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

1c:01.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 97
     IOMMU group: 53
     Bus: primary=1c, secondary=1d, subordinate=20, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380400000000-380403ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee01000  Data: 0024
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #1, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

1c:02.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 98
     IOMMU group: 53
     Bus: primary=1c, secondary=21, subordinate=23, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380404000000-380407ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee03000  Data: 0024
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #2, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending+ InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

1c:03.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 99
     IOMMU group: 53
     Bus: primary=1c, secondary=24, subordinate=24, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380408000000-38040bffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 00ef
         Masking: 000000ff  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #3, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

1d:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Physical Slot: 1-5
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 116
     IOMMU group: 53
     Region 0: Memory at 380400800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380400000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee02000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

24:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 121
     IOMMU group: 53
     Region 0: Memory at 380408800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380408000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee05000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

25:00.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Physical Slot: 4
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 19
     IOMMU group: 54
     Region 0: Memory at d7900000 (32-bit, non-prefetchable) [size=256K]
     Bus: primary=25, secondary=26, subordinate=2e, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380600000000-38060bffffff 
[size=192M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [b00 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

25:00.1 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 4
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 54
     Region 0: Memory at d7940000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

25:00.2 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 4
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 54
     Region 0: Memory at d7942000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

25:00.3 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 4
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 54
     Region 0: Memory at d7944000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

25:00.4 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 4
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 54
     Region 0: Memory at d7946000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

26:01.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 100
     IOMMU group: 54
     Bus: primary=26, secondary=27, subordinate=2a, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380600000000-380603ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee07000  Data: 0024
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #1, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

26:02.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 101
     IOMMU group: 54
     Bus: primary=26, secondary=2b, subordinate=2d, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380604000000-380607ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee02000  Data: 0024
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #2, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending+ InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

26:03.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 102
     IOMMU group: 54
     Bus: primary=26, secondary=2e, subordinate=2e, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380608000000-38060bffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 00ef
         Masking: 000000ff  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #3, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

27:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Physical Slot: 1-6
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 120
     IOMMU group: 54
     Region 0: Memory at 380600800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380600000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee09000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

2e:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 117
     IOMMU group: 54
     Region 0: Memory at 380608800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380608000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee04000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

2f:00.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Physical Slot: 5
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 52
     Region 0: Memory at da900000 (32-bit, non-prefetchable) [size=256K]
     Bus: primary=2f, secondary=30, subordinate=38, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380800000000-38080bffffff 
[size=192M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [b00 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

2f:00.1 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 5
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 52
     Region 0: Memory at da940000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

2f:00.2 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 5
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 52
     Region 0: Memory at da942000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

2f:00.3 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 5
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 52
     Region 0: Memory at da944000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

2f:00.4 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 5
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 52
     Region 0: Memory at da946000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

30:01.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 94
     IOMMU group: 52
     Bus: primary=30, secondary=31, subordinate=34, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380800000000-380803ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee0a000  Data: 0023
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #1, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

30:02.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 95
     IOMMU group: 52
     Bus: primary=30, secondary=35, subordinate=37, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380804000000-380807ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 0023
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #2, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending+ InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

30:03.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 96
     IOMMU group: 52
     Bus: primary=30, secondary=38, subordinate=38, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380808000000-38080bffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 00ef
         Masking: 000000ff  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #3, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

31:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Physical Slot: 1-4
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 125
     IOMMU group: 52
     Region 0: Memory at 380800800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380800000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee01000  Data: 0026
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

38:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 124
     IOMMU group: 52
     Region 0: Memory at 380808800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380808000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

39:00.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Physical Slot: 6
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 17
     IOMMU group: 49
     Region 0: Memory at dd900000 (32-bit, non-prefetchable) [size=256K]
     Bus: primary=39, secondary=3a, subordinate=42, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380a00000000-380a0bffffff 
[size=192M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [b00 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

39:00.1 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 6
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 49
     Region 0: Memory at dd940000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

39:00.2 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 6
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 49
     Region 0: Memory at dd942000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

39:00.3 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 6
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 49
     Region 0: Memory at dd944000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

39:00.4 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 6
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 49
     Region 0: Memory at dd946000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

3a:01.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 85
     IOMMU group: 49
     Bus: primary=3a, secondary=3b, subordinate=3e, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380a00000000-380a03ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee04000  Data: 0023
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #1, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=8
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

3a:02.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 86
     IOMMU group: 49
     Bus: primary=3a, secondary=3f, subordinate=41, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380a04000000-380a07ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee06000  Data: 0023
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ 
Surprise-
             Slot #2, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn+ PwrFlt- MRL- PresDet- CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Off, PwrInd Off, Power+ Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL+ CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending+ InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

3a:03.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 87
     IOMMU group: 49
     Bus: primary=3a, secondary=42, subordinate=42, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380a08000000-380a0bffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 00ef
         Masking: 000000ff  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #3, PowerLimit 25W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
         VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

3b:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Physical Slot: 1-1
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 123
     IOMMU group: 49
     Region 0: Memory at 380a00800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380a00000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee0a000  Data: 0025
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

42:00.0 Ethernet controller: Broadcom Inc. and subsidiaries Device 8797 
(rev 11)
     Subsystem: Broadcom Inc. and subsidiaries Device 8797
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 126
     IOMMU group: 49
     Region 0: Memory at 380a08800000 (64-bit, prefetchable) [size=32K]
     Region 2: Memory at 380a08000000 (64-bit, prefetchable) [size=8M]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [58] MSI: Enable+ Count=1/32 Maskable+ 64bit+
         Address: 00000000fee03000  Data: 0026
         Masking: fffffffe  Pending: 00000000
     Capabilities: [a0] MSI-X: Enable- Count=64 Masked-
         Vector table: BAR=2 offset=00300000
         PBA: BAR=2 offset=00301000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x4, ASPM not supported
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest+
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-00-00-00-00-00-00
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Vendor Specific Information: ID=0000 Rev=0 
Len=028 <?>
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [240 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
               PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [250 v1] Multicast
         McastCap: MaxGroups 1, WindowSz 0 (1 bytes) McastCtl: NumGroups 
1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
     Kernel driver in use: linux-kernel-bde
     Kernel modules: linux_kernel_bde

46:00.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Physical Slot: 8
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 19
     IOMMU group: 56
     Region 0: Memory at e3900000 (32-bit, non-prefetchable) [size=256K]
     Bus: primary=46, secondary=47, subordinate=50, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380e00000000-380e07ffffff 
[size=128M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=8
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [b00 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

46:00.1 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 8
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 56
     Region 0: Memory at e3940000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

46:00.2 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 8
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 56
     Region 0: Memory at e3942000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

46:00.3 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 8
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 56
     Region 0: Memory at e3944000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

46:00.4 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 8
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 56
     Region 0: Memory at e3946000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

47:02.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 109
     IOMMU group: 56
     Bus: primary=47, secondary=48, subordinate=48, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380e00000000-380e03ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 00ef
         Masking: 000000ff  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot-), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

47:0d.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 110
     IOMMU group: 56
     Bus: primary=47, secondary=49, subordinate=50, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 380e04000000-380e07ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee0b000  Data: 0024
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #13, Speed 8GT/s, Width x1, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #0, PowerLimit 0W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

49:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme 
BCM57762 Gigabit Ethernet PCIe (rev 01)
     Subsystem: Broadcom Inc. and subsidiaries NetXtreme BCM57762 
Gigabit Ethernet PCIe
     Physical Slot: 0-4
     Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 56
     Region 0: Memory at 380e04000000 (64-bit, prefetchable) [size=64K]
     Region 2: Memory at 380e04010000 (64-bit, prefetchable) [size=64K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] Vital Product Data
         Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
         Read-only fields:
             [PN] Part number: BCM957762
             [EC] Engineering changes: 106679-15
             [SN] Serial number: 0123456789
             [MN] Manufacture ID: 14e4
             [VR] Vendor specific: 03
             [RV] Reserved: checksum good, 22 byte(s) reserved
         Read/write fields:
             [YA] Asset tag: XYZ01234567
             [RW] Read-write area: 107 byte(s) free
         End
     Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [a0] MSI-X: Enable+ Count=6 Masked-
         Vector table: BAR=2 offset=00000000
         PBA: BAR=2 offset=00000120
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <2us, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-d4-af-f7-2f-10-91
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Kernel driver in use: tg3
     Kernel modules: tg3

51:00.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Physical Slot: 9
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 55
     Region 0: Memory at e6900000 (32-bit, non-prefetchable) [size=256K]
     Bus: primary=51, secondary=52, subordinate=5b, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 381000000000-381007ffffff 
[size=128M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W 
TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ 
EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=8
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=03 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64+ WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=WRR64 TC/VC=ff
             Status:    NegoPending- InProgress-
             Port Arbitration Table <?>
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [b00 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

51:00.1 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 9
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 55
     Region 0: Memory at e6940000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

51:00.2 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 9
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 55
     Region 0: Memory at e6942000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

51:00.3 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 9
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 55
     Region 0: Memory at e6944000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

51:00.4 System peripheral: PLX Technology, Inc. PEX PCI Express Switch 
DMA interface (rev ca)
     Subsystem: PLX Technology, Inc. PEX PCI Express Switch DMA interface
     Physical Slot: 9
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 0
     IOMMU group: 55
     Region 0: Memory at e6946000 (32-bit, non-prefetchable) [disabled] 
[size=8K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [68] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [1f0 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=0c4 <?>
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>

52:02.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 103
     IOMMU group: 55
     Bus: primary=52, secondary=53, subordinate=53, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 381000000000-381003ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00000  Data: 00ef
         Masking: 000000ff  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot-), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending+ InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

52:0d.0 PCI bridge: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA (rev ca) (prog-if 00 [Normal 
decode])
     Subsystem: PLX Technology, Inc. PEX 8717 16-lane, 8-Port PCI 
Express Gen 3 (8.0 GT/s) Switch with DMA
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 104
     IOMMU group: 55
     Bus: primary=52, secondary=54, subordinate=5b, sec-latency=0
     I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
     Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
     Prefetchable memory behind bridge: 381004000000-381007ffffff 
[size=64M] [32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee08000  Data: 0024
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0
             ExtTag- RBE+ TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #13, Speed 8GT/s, Width x1, ASPM L1, Exit 
Latency L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise-
             Slot #0, PowerLimit 0W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- ARIFwd+
              AtomicOpsCap: Routing+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
              AtomicOpsCtl: EgressBlck-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink+ Retimer- 
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8717 
16-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch with DMA
     Capabilities: [100 v1] Device Serial Number ca-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF+
         AERCap:    First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [e00 v1] Multicast
         McastCap: MaxGroups 64, ECRCRegen+
         McastCtl: NumGroups 1, Enable-
         McastBAR: IndexPos 0, BaseAddr 0000000000000000
         McastReceiveVec:      0000000000000000
         McastBlockAllVec:     0000000000000000
         McastBlockUntransVec: 0000000000000000
         McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 
0000000000000000
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport

54:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme 
BCM57762 Gigabit Ethernet PCIe (rev 01)
     Subsystem: Broadcom Inc. and subsidiaries NetXtreme BCM57762 
Gigabit Ethernet PCIe
     Physical Slot: 0-3
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 17
     IOMMU group: 55
     Region 0: Memory at 381004000000 (64-bit, prefetchable) [size=64K]
     Region 2: Memory at 381004010000 (64-bit, prefetchable) [size=64K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] Vital Product Data
         Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
         Read-only fields:
             [PN] Part number: BCM957762
             [EC] Engineering changes: 106679-15
             [SN] Serial number: 0123456789
             [MN] Manufacture ID: 14e4
             [VR] Vendor specific: 03
             [RV] Reserved: checksum good, 22 byte(s) reserved
         Read/write fields:
             [YA] Asset tag: XYZ01234567
             [RW] Read-write area: 107 byte(s) free
         End
     Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [a0] MSI-X: Enable+ Count=6 Masked-
         Vector table: BAR=2 offset=00000000
         PBA: BAR=2 offset=00000120
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <2us, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-c4-ca-2b-c9-02-1c
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [1b0 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Kernel driver in use: tg3
     Kernel modules: tg3

9f:00.0 System peripheral: Arista Networks, Inc. Device 0001 (rev 01)
     Subsystem: Arista Networks, Inc. Device 0001
     Physical Slot: 0
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 37
     Region 0: Memory at fbb00000 (32-bit, non-prefetchable) [size=512K]
     Region 1: Memory at fbb80000 (32-bit, non-prefetchable) [size=512K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable- Count=1/4 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [58] Express (v1) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit 
Latency L0s unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
     Kernel driver in use: scd
     Kernel modules: scd

a0:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme 
BCM5720 Gigabit Ethernet PCIe
     Subsystem: Broadcom Inc. and subsidiaries Device 2003
     Physical Slot: 0-1
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 38
     Region 0: Memory at 381e01000000 (64-bit, prefetchable) [size=64K]
     Region 2: Memory at 381e01010000 (64-bit, prefetchable) [size=64K]
     Region 4: Memory at 381e01020000 (64-bit, prefetchable) [size=64K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] Vital Product Data
         Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
         Read-only fields:
             [PN] Part number: BCM95720
             [EC] Engineering changes: 106679-15
             [SN] Serial number: 0123456789
             [MN] Manufacture ID: 14e4
             [RV] Reserved: checksum bad, 28 byte(s) reserved
         Read/write fields:
             [YA] Asset tag: XYZ01234567
             [RW] Read-write area: 107 byte(s) free
         End
     Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
         Vector table: BAR=4 offset=00000000
         PBA: BAR=4 offset=00001000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <2us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-fc-bd-67-67-d6-3f
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Kernel driver in use: tg3
     Kernel modules: tg3

a0:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme 
BCM5720 Gigabit Ethernet PCIe
     Subsystem: Broadcom Inc. and subsidiaries NetXtreme BCM5720 Gigabit 
Ethernet PCIe
     Physical Slot: 0-1
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 17
     IOMMU group: 38
     Region 0: Memory at 381e01030000 (64-bit, prefetchable) [size=64K]
     Region 2: Memory at 381e01040000 (64-bit, prefetchable) [size=64K]
     Region 4: Memory at 381e01050000 (64-bit, prefetchable) [size=64K]
     Capabilities: [48] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] Vital Product Data
         Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
         Read-only fields:
             [PN] Part number: BCM95720
             [EC] Engineering changes: 106679-15
             [SN] Serial number: 0123456789
             [MN] Manufacture ID: 14e4
             [RV] Reserved: checksum bad, 28 byte(s) reserved
         Read/write fields:
             [YA] Asset tag: XYZ01234567
             [RW] Read-write area: 107 byte(s) free
         End
     Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
         Vector table: BAR=4 offset=00000000
         PBA: BAR=4 offset=00001000
     Capabilities: [ac] Express (v2) Endpoint, IntMsgNum 0
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
         DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop- FLReset-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <2us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x1 (downgraded)
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
              AtomicOpsCtl: ReqEn-
              IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
         AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [13c v1] Device Serial Number 00-00-fc-bd-67-67-d6-40
     Capabilities: [150 v1] Power Budgeting <?>
     Capabilities: [160 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Kernel driver in use: tg3
     Kernel modules: tg3

ff:0b.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D R3 QPI Link 0/1 (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D R3 QPI Link 0/1
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 39

ff:0b.1 Performance counters: Intel Corporation Xeon E7 v4/Xeon E5 
v4/Xeon E3 v4/Xeon D R3 QPI Link 0/1 (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D R3 QPI Link 0/1
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 39
     Kernel driver in use: bdx_uncore

ff:0b.2 Performance counters: Intel Corporation Xeon E7 v4/Xeon E5 
v4/Xeon E3 v4/Xeon D R3 QPI Link 0/1 (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D R3 QPI Link 0/1
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 39
     Kernel driver in use: bdx_uncore

ff:0b.3 System peripheral: Arista Networks, Inc. Device 0001 (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 39
     Kernel driver in use: scd
     Kernel modules: scd

ff:0c.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Caching Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 40

ff:0c.1 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Caching Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 40

ff:0c.2 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Caching Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 40

ff:0c.3 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Caching Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 40

ff:0c.4 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Caching Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 40

ff:0c.5 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Caching Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 40

ff:0f.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Caching Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 41

ff:0f.4 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Device 6fe0
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 41

ff:0f.5 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Device 6fe0
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 41

ff:0f.6 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Caching Agent (rev 03)
     Subsystem: Intel Corporation Device 6fe0
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 41

ff:10.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D R2PCIe Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D R2PCIe Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 42

ff:10.1 Performance counters: Intel Corporation Xeon E7 v4/Xeon E5 
v4/Xeon E3 v4/Xeon D R2PCIe Agent (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D R2PCIe Agent
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 42
     Kernel driver in use: bdx_uncore

ff:10.5 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Ubox (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Ubox
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 42

ff:10.6 Performance counters: Intel Corporation Xeon E7 v4/Xeon E5 
v4/Xeon E3 v4/Xeon D Ubox (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Ubox
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 42

ff:10.7 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Ubox (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Ubox
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 42

ff:12.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Home Agent 0 (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Home Agent 0
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 43

ff:12.1 Performance counters: Intel Corporation Xeon E7 v4/Xeon E5 
v4/Xeon E3 v4/Xeon D Home Agent 0 (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Home Agent 0
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 43
     Kernel driver in use: bdx_uncore

ff:13.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Target Address/Thermal/RAS (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Target Address/Thermal/RAS
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 44

ff:13.1 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Target Address/Thermal/RAS (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Target Address/Thermal/RAS
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 44

ff:13.2 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel Target Address Decoder
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 44

ff:13.3 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel Target Address Decoder
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 44

ff:13.4 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel Target Address Decoder
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 44

ff:13.5 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel Target Address Decoder
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 44

ff:13.6 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D DDRIO Channel 0/1 Broadcast (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 44

ff:13.7 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D DDRIO Global Broadcast (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 44

ff:14.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel 0 Thermal Control (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel 0 Thermal Control
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 45
     Kernel driver in use: bdx_uncore

ff:14.1 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel 1 Thermal Control (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel 1 Thermal Control
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 45
     Kernel driver in use: bdx_uncore

ff:14.2 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel 0 Error (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel 0 Error
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 45

ff:14.3 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel 1 Error (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel 1 Error
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 45

ff:14.4 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D DDRIO Channel 0/1 Interface (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 45

ff:14.5 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D DDRIO Channel 0/1 Interface (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 45

ff:14.6 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D DDRIO Channel 0/1 Interface (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 45

ff:14.7 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D DDRIO Channel 0/1 Interface (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 45

ff:15.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel 2 Thermal Control (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel 2 Thermal Control
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 46
     Kernel driver in use: bdx_uncore

ff:15.1 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel 3 Thermal Control (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel 3 Thermal Control
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 46
     Kernel driver in use: bdx_uncore

ff:15.2 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel 2 Error (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel 2 Error
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 46

ff:15.3 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Memory Controller 0 - Channel 3 Error (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Memory Controller 0 - Channel 3 Error
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 46

ff:1e.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Power Control Unit (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Power Control Unit
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 47

ff:1e.1 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Power Control Unit (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Power Control Unit
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 47

ff:1e.2 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Power Control Unit (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Power Control Unit
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 47

ff:1e.3 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Power Control Unit (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Power Control Unit
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 47

ff:1e.4 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Power Control Unit (rev 03)
     Subsystem: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon 
D Power Control Unit
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 47

ff:1f.0 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Power Control Unit (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 48

ff:1f.2 System peripheral: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon 
E3 v4/Xeon D Power Control Unit (rev 03)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     IOMMU group: 48

Thanks,

Yury.

On 5/19/26 10:53, Lukas Wunner wrote:
> On Mon, May 18, 2026 at 02:23:36PM +0100, Yury Murashka wrote:
>> pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
>> If a new AER error is subsequently reported, the AER driver calls
>> find_source_device() to find the source of the error. It rescans the
>> whole bus and picks the first device reporting an AER error. Because the
>> previous error was never cleared, the error is attributed to the wrong
>> device and AER recovery is started for the wrong device.
> I guess the rationale of the current behavior is that the devices
> affected by the failed error recovery are basically in a broken
> state once error recovery failed and so user intervention is
> required, e.g. a remove/rescan via sysfs.
>
> My question is, why is error recovery failing for the devices
> in the first place?
>
> And what does the hierarchy look like?
> (lspci -tv and lspci -vvv output please)
>
> I also don't quite follow your assertion that (only) the first device
> reporting an error is picked.  The algorithm tries to collect *all*
> error-reporting devices in the affected portion of the hierarchy.
>
> Thanks,
>
> Lukas

