Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2C2501007D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 04:16:36 +1100 (EST)
Message-ID: <4EDF9F6A.9000407@freescale.com>
Date: Wed, 7 Dec 2011 11:16:26 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Subject: Re: [PATCH 2/2 v2] mtd/nand: Add ONFI support for FSL NAND controller
References: <1323161655-19050-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1323161655-19050-2-git-send-email-Shengzhou.Liu@freescale.com>
 <4EDE4E1D.4030408@freescale.com>
 <3F453DDFF675A64A89321A1F352810216B074A@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <3F453DDFF675A64A89321A1F352810216B074A@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/2011 09:16 PM, Liu Shengzhou-B36685 wrote:
>>> +			out_be32(&lbc->fbcr, 8);
>>> +			elbc_fcm_ctrl->read_bytes = 8;
>>> +		} else {
>>> +			out_be32(&lbc->fbcr, 256);
>>> +			elbc_fcm_ctrl->read_bytes = 256;
>>> +		}
>>
>> Any harm in always using 256?
>>
>> -Scott
> [Shengzhou] For NAND_CMD_READID command, the total bytes of entire ID string are 8, there are not 256 bytes so many, it's unnecessary and looks not so well logically to always using 256, though it works.

It's not performance critical, and always using 256 keeps things
simpler, and more robust if the length of the ID string grows in the
future (we used to assume it was 5 bytes...).

-Scott
