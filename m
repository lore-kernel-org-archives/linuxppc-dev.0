Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 61E58B702E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 08:13:54 +1100 (EST)
Message-ID: <4EB4558A.8070105@freescale.com>
Date: Fri, 4 Nov 2011 16:13:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 7/7] gianfar: add support for wake-on-packet
References: <1320410403-14639-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB45515.6060405@freescale.com>
In-Reply-To: <4EB45515.6060405@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 04:11 PM, Scott Wood wrote:
> On 11/04/2011 07:40 AM, Zhao Chenhui wrote:
>>  static int gfar_suspend(struct device *dev)
>>  {
>> @@ -1268,9 +1443,17 @@ static int gfar_suspend(struct device *dev)
>>  	struct gfar __iomem *regs = priv->gfargrp[0].regs;
>>  	unsigned long flags;
>>  	u32 tempval;
>> -
>>  	int magic_packet = priv->wol_en &&
>> -		(priv->device_flags & FSL_GIANFAR_DEV_HAS_MAGIC_PACKET);
>> +		(priv->wol_opts & GIANFAR_WOL_MAGIC);
>> +	int arp_packet = priv->wol_en &&
>> +		(priv->wol_opts & GIANFAR_WOL_ARP);
>> +
>> +	if (arp_packet) {
>> +		pmc_enable_wake(priv->ofdev, PM_SUSPEND_MEM, 1);
>> +		pmc_enable_lossless(1);
>> +		gfar_arp_suspend(ndev);
>> +		return 0;
>> +	}
> 
> How do we know this isn't standby?

Or suspend to disk, for that matter?

-Scott
