Return-Path: <Bo.Liu@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by bilbo.ozlabs.org (Postfix) with ESMTP id DDD91B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 18:38:13 +1000 (EST)
Message-ID: <4A642CEE.2040708@windriver.com>
Date: Mon, 20 Jul 2009 16:38:06 +0800
From: tonyliu <Bo.Liu@windriver.com>
MIME-Version: 1.0
To: Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
Subject: Re: booting MPC8313 based board with yaffs2 RFS
References: <OF2CCFE0B3.51B58673-ON652575F5.001ABC10-652575F5.001C7443@lntemsys.com>
In-Reply-To: <OF2CCFE0B3.51B58673-ON652575F5.001ABC10-652575F5.001C7443@lntemsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rupesh Kumar wrote:
> Hi 
> Thanks for reply.
> After erasing one of the flash partition, i mounted it as yaffs2 and 
> manually created rootfs there. 
> Though it (careting RFS in NAND partiton) marked blocks bad, I am able to 
> boot with this yaffs2 filesystem.
> When image is created with mkyffs2image binary, board does not boot with 
> that and says kernel panic.
>
> 1. What nand flash is on-board? what's the size of the nand flash page 
> size, 512/2048?
> Nand Flash used on board is K9F2G08U0M-P from Samsung and page size is 
> 2048.
> 2. what's the version of mkyaffs2image you are using?
> mkyaffs2image: image building tool for YAFFS2 built Jan 31 2009
> 3. Can you mount an empty nand flash partition using yaffs2 type,
> mount  /dev/mtdblock##x   xxx
> Yes, i wrote RFS contents to the nand flash partition and booted with 
> that. 
> 4. It's better to attatch bootup message.
> Bootup message is attached for both conditions 
> 1) booting with manually created RFS on flash drive mounted as 
> yaffs2(boot-up_manual_RFS.txt).
> 2) booting with yaffs2 image created by mkyaffs2image tool.
>         Note :- below are steps used for writing RFS iamge 
>                 ~ # flash_eraseall /dev/mtd11
>                 ~ # nandwrite -a -o /dev/mtd11 rootrfs_1.yaffs2
>   
After you nandwrite the yaffs2 rootfs image, you should mount the 
partition to validate if it's right.
For your situation, there is probably only one "lost+found" dir under 
the mounted partition.

You maybe took  notice that there is one option "oob_ecc_size" for 
mkyaffs2image.Default is 0.

if your mkyaffs2image has no such option, you should update it.

Here are some comments of the patch for adding "oob_ecc_size", hope  
helpful for you

" The main problem was that mkyaffs2image was writing YAFFS2 OOB data 
into the OOB area that the MTD
driver uses for ECC. Therefore we need to leave room inside the OOB 
yaffs2 image space for data ECC.
This is achieved by introducing a new optional parameter called 
oob_ecc_size to specify the size of data ECC
(e.g. for 2k page/64bytes OOB, this data ECC is 14 bytes). "

Tony
>
>  
>
>
>
>
> Thanks 
> Rupesh
>
>
>
>
>
> tonyliu <Bo.Liu@windriver.com> 
> 07/17/2009 07:37 AM
>
> To
> Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
> cc
> linuxppc-dev@lists.ozlabs.org
> Subject
> Re: booting MPC8313 based board with yaffs2 RFS
>
>
>
>
>
>
>
> Rupesh Kumar wrote:
>   
>> Hi
>> I am using MPC8313 board which is currently booting with JFFS2 root file 
>>     
>
>   
>> system. 
>> I am using linux kernel version 2.6.23 from FreeScale's LTIB for 
>>     
> MPC8313. 
>   
>> As, I want it to boot with YAFFS2 root file system, I did compile kernel 
>>     
>
>   
>> with yaffs2 support, craeted yaffs2 rootfile system and passed yaffs2 
>> partiton of nand in bootargs. However it didnot work.
>>
>>
>> If any one has done it successfully, can please share the steps to be 
>> followed ?
>>
>>     
> More detailed info maybe helpful for debugging this issue.
>
> 1. What nand flash is on-board? what's the size of the nand flash page 
> size, 512/2048?
> 2. what's the version of mkyaffs2image you are using?
> 3. Can you mount an empty nand flash partition using yaffs2 type,
> mount  /dev/mtdblock##x   xxx
> 4. It's better to attatch bootup message.
>
> Tony
>   
>> Thanks
>> Rupesh
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>
>>     
>
>   
