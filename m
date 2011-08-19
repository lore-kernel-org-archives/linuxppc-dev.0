Return-Path: <B35362@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98D85B6F71
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 13:13:32 +1000 (EST)
Message-ID: <4E4DD661.5080006@freescale.com>
Date: Fri, 19 Aug 2011 11:20:01 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com>
In-Reply-To: <4E4D452C.7050805@parrot.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

=E4=BA=8E 2011=E5=B9=B408=E6=9C=8819=E6=97=A5 01:00, Matthieu CASTET =E5=86=
=99=E9=81=93:
> b35362@freescale.com a =C3=A9crit :
>> From: Liu Shuo<b35362@freescale.com>
>>
>> Freescale FCM controller has a 2K size limitation of buffer RAM. In or=
der
>> to support the Nand flash chip whose page size is larger than 2K bytes=
,
>> we divide a page into multi-2K pages for MTD layer driver. In that cas=
e,
>> we force to set the page size to 2K bytes. We convert the page address=
 of
>> MTD layer driver to a real page address in flash chips and a column in=
dex
>> in fsl_elbc driver. We can issue any column address by UA instruction =
of
>> elbc controller.
>>
> Why do you need to do that ?
>
> When mtd send you a 4k page, why can't you write it by 2*2k pages write=
 ?
1. It's easy to implement.
2. We don't need to move the data in buffer more times, because we
want to use the HW_ECC.

In flash chip per Page:
----------------------------------------------------------------
| first data | first oob | second data | second oob |
----------------------------------------------------------------

> Even better send the first 2K and then if your controller allow it send=
 the
> remaining 2K without command/address phase.
The elbc controller don't allow that.
I have to send twice Program CMD for writing the whole 4KB data.

>
> Matthieu
>
