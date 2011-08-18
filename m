Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC160B6F70
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 04:24:46 +1000 (EST)
Message-ID: <4E4D58E6.7060706@freescale.com>
Date: Thu, 18 Aug 2011 13:24:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com>
In-Reply-To: <4E4D452C.7050805@parrot.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"b35362@freescale.com" <b35362@freescale.com>,
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

On 08/18/2011 12:00 PM, Matthieu CASTET wrote:
> b35362@freescale.com a =E9crit :
>> From: Liu Shuo <b35362@freescale.com>
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
>=20
> When mtd send you a 4k page, why can't you write it by 2*2k pages write=
 ?

That would be more complicated given the statefulness of the interface,
for no real benefit.

> Even better send the first 2K and then if your controller allow it send=
 the
> remaining 2K without command/address phase.

IIRC Shuo tried this first and couldn't make it work.

-Scott
