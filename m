Return-Path: <ric@emc.com>
Received: from mexforward.lss.emc.com (mexforward.lss.emc.com
	[168.159.213.200])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40D9D67B1B
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 21:36:10 +1000 (EST)
Message-ID: <446C621E.9060502@emc.com>
Date: Thu, 18 May 2006 08:01:34 -0400
From: Ric Wheeler <ric@emc.com>
MIME-Version: 1.0
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>, Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Lord has been actively working on the sata_mv driver recently,

ric


Zang Roy-r61911 wrote:

>-----Original Message-----
>From: Kumar Gala [mailto:galak@kernel.crashing.org]
>Sent: 2006年5月17日 21:28
>To: Zang Roy-r61911
>Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; Yang Xin-Xin-r48390
>Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powerpc pl atform
>
>
>
>On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:
>
>  
>
>>Fix Marvell SATA driver bugs on PowerPC platform:
>>SATA device can't work for the problem on little-endian mode.
>>U-Boot can't find SATA device after kernel reboots.
>>
>>Signed-off-by: Hongjun cheng	<hong-jun.chen@reescale.com>
>>Signed-off-by: Roy Zang		<tie-fei.zang@freescale.com>
>>
>>    
>>
>>>From nobody Mon Sep 17 00:00:00 2001
>>>      
>>>
>>From: roy zang <tie-fei.zang@freescale.com>
>>Date: Tue May 16 15:25:23 2006 +0800
>>Subject: [PATCH] Fix bugs on powerpc platform for mv sata driver
>>    
>>
>
>This needs to go to Jeff Garzik as SATA driver maintainer.
>
>- kumar
>
>  
>
>> drivers/scsi/sata_mv.c |   10 +++++++++-
>> 1 files changed, 9 insertions(+), 1 deletions(-)
>>
>>d82ac19d259f8487a31105eaf844a93cbd9008e8
>>diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
>>index d5fdcb9..4166422 100644
>>--- a/drivers/scsi/sata_mv.c
>>+++ b/drivers/scsi/sata_mv.c
>>@@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16
>> {
>> 	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>> 		(last ? CRQB_CMD_LAST : 0);
>>+#ifdef CONFIG_PPC
>>+	*cmdw = cpu_to_le16(*cmdw);
>>+#endif
>> }
>>
>> /**
>>@@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>> static void mv5_enable_leds(struct mv_host_priv *hpriv, void  
>>__iomem *mmio)
>> {
>> 	u32 tmp;
>>-
>>+#ifndef CONFIG_PPC
>> 	writel(0, mmio + MV_GPIO_PORT_CTL);
>>+#endif
>>
>> 	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
>>
>> 	tmp = readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
>>+#ifdef CONFIG_PPC
>>+	tmp &= ~(1 << 0);
>>+#else	
>> 	tmp |= ~(1 << 0);
>>+#endif
>> 	writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
>> }
>>
>>-- 
>>1.3.0
>>_______________________________________________
>>Linuxppc-dev mailing list
>>Linuxppc-dev@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
