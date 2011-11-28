Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 01887B6F8A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 04:20:42 +1100 (EST)
Message-ID: <4ED3C2E2.9040601@freescale.com>
Date: Mon, 28 Nov 2011 11:20:34 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322095306-13156-1-git-send-email-b35362@freescale.com>
 <1322095306-13156-3-git-send-email-b35362@freescale.com>
 <3F607A5180246847A760FD34122A1E052DC4CD@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <3F607A5180246847A760FD34122A1E052DC4CD@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shuo-B35362 <B35362@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/24/2011 01:37 AM, Li Yang-R58472 wrote:
>> +static void io_to_buffer(struct mtd_info *mtd, int subpage, int oob)
>> +{
>> +	struct nand_chip *chip = mtd->priv;
>> +	struct fsl_elbc_mtd *priv = chip->priv;
>> +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
>> +	void *src, *dst;
>> +	int len = (oob ? 64 : 2048);
>> +
>> +	if (oob)
>> +		dst = elbc_fcm_ctrl->buffer + mtd->writesize + subpage * 64;
>> +	else
>> +		dst = elbc_fcm_ctrl->buffer + subpage * 2048;
>> +
>> +	src = elbc_fcm_ctrl->addr + (oob ? 2048 : 0);
>> +	memcpy_fromio(dst, src, len);
> 
> Might be safer to use _memcpy_fromio()

How so?

memcpy_fromio() is the public interface that will end up calling
_memcpy_fromio() on powerpc.

-Scott
