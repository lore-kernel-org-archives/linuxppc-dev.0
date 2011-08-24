Return-Path: <B35362@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B60EB6F00
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2011 12:41:43 +1000 (EST)
Message-ID: <4E546672.3070100@freescale.com>
Date: Wed, 24 Aug 2011 10:48:18 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>	<4E4D3CE0.7020602@freescale.com>
	<4E5366AF.7040108@freescale.com> <4E537AC4.6000301@parrot.com>
In-Reply-To: <4E537AC4.6000301@parrot.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	Li Yang-R58472 <r58472@freescale.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E4=BA=8E 2011=E5=B9=B408=E6=9C=8823=E6=97=A5 18:02, Matthieu CASTET =E5=86=
=99=E9=81=93:
> LiuShuo a =C3=A9crit :
>> =E4=BA=8E 2011=E5=B9=B408=E6=9C=8819=E6=97=A5 00:25, Scott Wood =E5=86=
=99=E9=81=93:
>>> On 08/17/2011 09:33 PM, b35362@freescale.com wrote:
>>>> From: Liu Shuo<b35362@freescale.com>
>>>>
>>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In =
order
>>>> to support the Nand flash chip whose page size is larger than 2K byt=
es,
>>>> we divide a page into multi-2K pages for MTD layer driver. In that c=
ase,
>>>> we force to set the page size to 2K bytes. We convert the page addre=
ss of
>>>> MTD layer driver to a real page address in flash chips and a column =
index
>>>> in fsl_elbc driver. We can issue any column address by UA instructio=
n of
>>>> elbc controller.
>>>>
>>>> NOTE: Due to there is a limitation of 'Number of Partial Program Cyc=
les in
>>>> the Same Page (NOP)', the flash chip which is supported by this work=
around
>>>> have to meet below conditions.
>>>> 	1. page size is not greater than 4KB
>>>> 	2.	1) if main area and spare area have independent NOPs:
>>>> 			  main  area NOP    :>=3D3
>>>> 			  spare area NOP    :>=3D2?
>>> How often are the NOPs split like this?
>>>
>>>> 		2) if main area and spare area have a common NOP:
>>>> 			  NOP               :>=3D4
>>> This depends on how the flash is used.  If you treat it as a NOP1 fla=
sh
>>> (e.g. run ubifs rather than jffs2), then you need NOP2 for a 4K chip =
and
>>> NOP4 for an 8K chip.  OTOH, if you would be making full use of NOP4 o=
n a
>>> real 2K chip, you'll need NOP8 for a 4K chip.
>>>
>>> The NOP restrictions should be documented in the code itself, not jus=
t
>>> in the git changelog.  Maybe print it to the console when this hack i=
s
>>> used, along with the NOP value read from the ID.
>> We can't read the NOP from the ID on any chip. Some chips don't
>> give this infomation.(e.g. Micron MT29F4G08BAC)
> Doesn't the micron chip provide it with onfi info ?
Sorry, there is something wrong with my expression.
We can get the NOP info from datasheet, but can't get it by READID=20
command in code.

-LiuShuo
> Matthieu
>
