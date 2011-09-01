Return-Path: <B35362@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB26AB6F70
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2011 19:41:30 +1000 (EST)
Message-ID: <4E5F5360.6060400@freescale.com>
Date: Thu, 1 Sep 2011 17:41:52 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>	<4E4D3CE0.7020602@freescale.com>
	<4E5366AF.7040108@freescale.com> <4E537AC4.6000301@parrot.com>
	<4E546672.3070100@freescale.com> <4E563133.5070006@parrot.com>
In-Reply-To: <4E563133.5070006@parrot.com>
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

=E4=BA=8E 2011=E5=B9=B408=E6=9C=8825=E6=97=A5 19:25, Matthieu CASTET =E5=86=
=99=E9=81=93:
> Hi,
>
> LiuShuo a =C3=A9crit :
>> =E4=BA=8E 2011=E5=B9=B408=E6=9C=8823=E6=97=A5 18:02, Matthieu CASTET =E5=
=86=99=E9=81=93:
>>> LiuShuo a =C3=A9crit :
>>>> =E4=BA=8E 2011=E5=B9=B408=E6=9C=8819=E6=97=A5 00:25, Scott Wood =E5=86=
=99=E9=81=93:
>>>>> On 08/17/2011 09:33 PM, b35362@freescale.com wrote:
>>>>>> From: Liu Shuo<b35362@freescale.com>
>>>>>>
>>>>>> Freescale FCM controller has a 2K size limitation of buffer RAM. I=
n order
>>>>>> to support the Nand flash chip whose page size is larger than 2K b=
ytes,
>>>>>> we divide a page into multi-2K pages for MTD layer driver. In that=
 case,
>>>>>> we force to set the page size to 2K bytes. We convert the page add=
ress of
>>>>>> MTD layer driver to a real page address in flash chips and a colum=
n index
>>>>>> in fsl_elbc driver. We can issue any column address by UA instruct=
ion of
>>>>>> elbc controller.
>>>>>>
>>>>>> NOTE: Due to there is a limitation of 'Number of Partial Program C=
ycles in
>>>>>> the Same Page (NOP)', the flash chip which is supported by this wo=
rkaround
>>>>>> have to meet below conditions.
>>>>>> 	1. page size is not greater than 4KB
>>>>>> 	2.	1) if main area and spare area have independent NOPs:
>>>>>> 			  main  area NOP    :>=3D3
>>>>>> 			  spare area NOP    :>=3D2?
>>>>> How often are the NOPs split like this?
>>>>>
>>>>>> 		2) if main area and spare area have a common NOP:
>>>>>> 			  NOP               :>=3D4
>>>>> This depends on how the flash is used.  If you treat it as a NOP1 f=
lash
>>>>> (e.g. run ubifs rather than jffs2), then you need NOP2 for a 4K chi=
p and
>>>>> NOP4 for an 8K chip.  OTOH, if you would be making full use of NOP4=
 on a
>>>>> real 2K chip, you'll need NOP8 for a 4K chip.
>>>>>
>>>>> The NOP restrictions should be documented in the code itself, not j=
ust
>>>>> in the git changelog.  Maybe print it to the console when this hack=
 is
>>>>> used, along with the NOP value read from the ID.
>>>> We can't read the NOP from the ID on any chip. Some chips don't
>>>> give this infomation.(e.g. Micron MT29F4G08BAC)
>>> Doesn't the micron chip provide it with onfi info ?
>> Sorry, there is something wrong with my expression.
>> We can get the NOP info from datasheet, but can't get it by READID
>> command in code.
>>
> ok I was thinking the micron chip was a 4K nand. But it is an old 2K. W=
hy do you
> want NOP from it ?
>
>
> Also can you reply my question about the sequence you use when trying t=
o read 4k
> with one command.
>
>
> Thanks
>
>
> Matthieu
>
Sorry for late reply.

After doing some tests, I found that the elbc controller can read/write=20
4k with one command
if we insert a FIR_OP_NOP between first half reading/wring and second=20
half reading/writing.(delay for something ?)

Read sequence :
-------------------------------------------------------------------------=
----------------------------------------------
first half :
                out_be32(&lbc->fir,
                          (FIR_OP_CM0 << FIR_OP0_SHIFT) |
                          (FIR_OP_CA << FIR_OP1_SHIFT) |
                          (FIR_OP_PA << FIR_OP2_SHIFT) |
                          (FIR_OP_CM1 << FIR_OP3_SHIFT) |
                          (FIR_OP_RBW << FIR_OP4_SHIFT));

                 out_be32(&lbc->fcr, (NAND_CMD_READ0 << FCR_CMD0_SHIFT) |
                                     (NAND_CMD_READSTART <<=20
FCR_CMD1_SHIFT));

second half :
                 out_be32(&lbc->fir,
                                 (FIR_OP_RB << FIR_OP1_SHIFT));       =20
// FIR_OP0_SHIFT is FIR_OP_NOP
-------------------------------------------------------------------------=
----------------------------------------------


Write sequence :
-------------------------------------------------------------------------=
----------------------------------------------

first half:
                 fcr =3D (NAND_CMD_STATUS << FCR_CMD1_SHIFT) |
                       (NAND_CMD_SEQIN << FCR_CMD2_SHIFT) |
                       (NAND_CMD_PAGEPROG << FCR_CMD3_SHIFT);

                 out_be32(&lbc->fir,
                                  (FIR_OP_CM2 << FIR_OP0_SHIFT) |
                                  (FIR_OP_CA << FIR_OP1_SHIFT) |
                                  (FIR_OP_PA << FIR_OP2_SHIFT) |
                                  (FIR_OP_WB << FIR_OP3_SHIFT));

second half:
                 out_be32(&lbc->fir,
                         (FIR_OP_WB << FIR_OP1_SHIFT) |
                         (FIR_OP_CM3 << FIR_OP2_SHIFT) |
                         (FIR_OP_CW1 << FIR_OP3_SHIFT) |
                         (FIR_OP_RS << FIR_OP4_SHIFT));
-------------------------------------------------------------------------=
----------------------------------------------

I am going to try to finish it and send a new patch.


-LiuShuo
