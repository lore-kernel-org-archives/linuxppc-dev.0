Return-Path: <dedekind1@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CAECB6EE8
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 21:17:06 +1000 (EST)
Received: by gwb17 with SMTP id 17so1679689gwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 04:17:03 -0700 (PDT)
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 25 Aug 2011 14:18:54 +0300
In-Reply-To: <4E53D15D.2050807@freescale.com>
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D3CE0.7020602@freescale.com> <4E5366AF.7040108@freescale.com>
	<4E537AC4.6000301@parrot.com> <4E53D15D.2050807@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314271139.18988.48.camel@sauron>
Mime-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>, LiuShuo <b35362@freescale.com>,
	Matthieu CASTET <matthieu.castet@parrot.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-23 at 11:12 -0500, Scott Wood wrote:
> On 08/23/2011 05:02 AM, Matthieu CASTET wrote:
> > LiuShuo a écrit :
> >> We can't read the NOP from the ID on any chip. Some chips don't
> >> give this infomation.(e.g. Micron MT29F4G08BAC)
> 
> Are there any 4K+ chips (especially ones with insufficient NOP) that
> don't have the info?
> 
> This chip is 2K and NOP8.
> 
> Is there an easy way (without needing to have every datasheet for every
> chip ever made) to determine at runtime which chips supply this information?
> 
> > Doesn't the micron chip provide it with onfi info ?
> 
> This chip doesn't appear to be ONFI.

Few quick thoughts.

1. I think that if driver is able to detect flash NOP parameter and
refuse flashes with too low NOP, then your change is OK.
2. For ONFI flashes, can we take NOP from ONFI info?
3. For non-ONFI chip, is it fair to conclude that MLCs _all_ have NOP 1?
Can distinguish between MLC/SLC? If not, can this table help:
http://www.linux-mtd.infradead.org/nand-data/nanddata.html? If needed,
can we put "bits-per-cell" data to 'struct nand_flash_dev
nand_flash_ids' ?
4. Can we add a NOP field to 'struct nand_flash_dev nand_flash_ids'
array?

-- 
Best Regards,
Artem Bityutskiy
