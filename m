Return-Path: <matthieu.castet@parrot.com>
Received: from co202.xi-lite.net (co202.xi-lite.net [149.6.83.202])
	by ozlabs.org (Postfix) with ESMTP id 60F02B6F6F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 18:57:28 +1000 (EST)
Message-ID: <4E4E2571.20409@parrot.com>
Date: Fri, 19 Aug 2011 10:57:21 +0200
From: Matthieu CASTET <matthieu.castet@parrot.com>
MIME-Version: 1.0
To: LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
In-Reply-To: <4E4DD661.5080006@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
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

LiuShuo a écrit :
> 于 2011年08月19日 01:00, Matthieu CASTET 写道:
>> b35362@freescale.com a écrit :
>>> From: Liu Shuo<b35362@freescale.com>
>>>
>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In order
>>> to support the Nand flash chip whose page size is larger than 2K bytes,
>>> we divide a page into multi-2K pages for MTD layer driver. In that case,
>>> we force to set the page size to 2K bytes. We convert the page address of
>>> MTD layer driver to a real page address in flash chips and a column index
>>> in fsl_elbc driver. We can issue any column address by UA instruction of
>>> elbc controller.
>>>
>> Why do you need to do that ?
>>
>> When mtd send you a 4k page, why can't you write it by 2*2k pages write ?
> 1. It's easy to implement.
> 2. We don't need to move the data in buffer more times, because we
> want to use the HW_ECC.
> 
> In flash chip per Page:
> ----------------------------------------------------------------
> | first data | first oob | second data | second oob |
> ----------------------------------------------------------------
How the bad block marker are handled with this remapping ?

Mtd will search in the first oob, but this will be the data zone of the nand,
not where manufacturer put marker.

Matthieu
