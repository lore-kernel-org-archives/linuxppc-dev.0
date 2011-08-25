Return-Path: <matthieu.castet@parrot.com>
Received: from co202.xi-lite.net (co202.xi-lite.net [149.6.83.202])
	by ozlabs.org (Postfix) with ESMTP id 2D86BB6F81
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 21:25:43 +1000 (EST)
Message-ID: <4E563133.5070006@parrot.com>
Date: Thu, 25 Aug 2011 13:25:39 +0200
From: Matthieu CASTET <matthieu.castet@parrot.com>
MIME-Version: 1.0
To: LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>	<4E4D3CE0.7020602@freescale.com>
	<4E5366AF.7040108@freescale.com> <4E537AC4.6000301@parrot.com>
	<4E546672.3070100@freescale.com>
In-Reply-To: <4E546672.3070100@freescale.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

LiuShuo a écrit :
> 于 2011年08月23日 18:02, Matthieu CASTET 写道:
>> LiuShuo a écrit :
>>> 于 2011年08月19日 00:25, Scott Wood 写道:
>>>> On 08/17/2011 09:33 PM, b35362@freescale.com wrote:
>>>>> From: Liu Shuo<b35362@freescale.com>
>>>>>
>>>>> Freescale FCM controller has a 2K size limitation of buffer RAM. In order
>>>>> to support the Nand flash chip whose page size is larger than 2K bytes,
>>>>> we divide a page into multi-2K pages for MTD layer driver. In that case,
>>>>> we force to set the page size to 2K bytes. We convert the page address of
>>>>> MTD layer driver to a real page address in flash chips and a column index
>>>>> in fsl_elbc driver. We can issue any column address by UA instruction of
>>>>> elbc controller.
>>>>>
>>>>> NOTE: Due to there is a limitation of 'Number of Partial Program Cycles in
>>>>> the Same Page (NOP)', the flash chip which is supported by this workaround
>>>>> have to meet below conditions.
>>>>> 	1. page size is not greater than 4KB
>>>>> 	2.	1) if main area and spare area have independent NOPs:
>>>>> 			  main  area NOP    :>=3
>>>>> 			  spare area NOP    :>=2?
>>>> How often are the NOPs split like this?
>>>>
>>>>> 		2) if main area and spare area have a common NOP:
>>>>> 			  NOP               :>=4
>>>> This depends on how the flash is used.  If you treat it as a NOP1 flash
>>>> (e.g. run ubifs rather than jffs2), then you need NOP2 for a 4K chip and
>>>> NOP4 for an 8K chip.  OTOH, if you would be making full use of NOP4 on a
>>>> real 2K chip, you'll need NOP8 for a 4K chip.
>>>>
>>>> The NOP restrictions should be documented in the code itself, not just
>>>> in the git changelog.  Maybe print it to the console when this hack is
>>>> used, along with the NOP value read from the ID.
>>> We can't read the NOP from the ID on any chip. Some chips don't
>>> give this infomation.(e.g. Micron MT29F4G08BAC)
>> Doesn't the micron chip provide it with onfi info ?
> Sorry, there is something wrong with my expression.
> We can get the NOP info from datasheet, but can't get it by READID 
> command in code.
> 
ok I was thinking the micron chip was a 4K nand. But it is an old 2K. Why do you
want NOP from it ?


Also can you reply my question about the sequence you use when trying to read 4k
with one command.


Thanks


Matthieu
