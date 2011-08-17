Return-Path: <B35362@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F422B6F76
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 17:29:10 +1000 (EST)
Message-ID: <4E4B6F46.2050209@freescale.com>
Date: Wed, 17 Aug 2011 15:35:34 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>
Subject: Re: [PATCH] mtd-utils: fix corrupt cleanmarker with flash_erase -j
	command
References: <1312350638-25566-1-git-send-email-b35362@freescale.com>
	<1313507201.2679.2.camel@sauron>
In-Reply-To: <1313507201.2679.2.camel@sauron>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@linux.freescale.net, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E4=BA=8E 2011=E5=B9=B408=E6=9C=8816=E6=97=A5 23:06, Artem Bityutskiy =E5=
=86=99=E9=81=93:
> On Wed, 2011-08-03 at 13:50 +0800, b35362@freescale.com wrote:
>> From: Liu Shuo<b35362@freescale.com>
>>
>> Flash_erase -j should fill discrete freeoob areas with required bytes
>> of JFFS2 cleanmarker in jffs2_check_nand_cleanmarker(). Not just fill
>> the first freeoob area.
>>
>> Signed-off-by: Liu Shuo<b35362@freescale.com>
>> Signed-off-by: Li Yang<leoli@freescale.com>
> ...
>
>>   	/*
>>   	 * Process user arguments
>> @@ -197,15 +198,40 @@ int main(int argc, char *argv[])
>>   			if (ioctl(fd, MEMGETOOBSEL,&oobinfo) !=3D 0)
>>   				return sys_errmsg("%s: unable to get NAND oobinfo", mtd_device);
>>
>> +			cleanmarker.totlen =3D cpu_to_je32(8);
>>   			/* Check for autoplacement */
>>   			if (oobinfo.useecc =3D=3D MTD_NANDECC_AUTOPLACE) {
>> +				struct nand_ecclayout_user ecclayout;
>>   				/* Get the position of the free bytes */
>> -				if (!oobinfo.oobfree[0][1])
>> +				if (ioctl(fd, ECCGETLAYOUT,&ecclayout) !=3D 0)
>> +					return sys_errmsg("%s: unable to get NAND ecclayout", mtd_device=
);
>> +
> Hmm, shouldn't we instead make MTD_OOB_AUTO be available for userspace
> via an ioctl instead and make flash_eraseall use it instead?
>


I think We can add a new ioctl MEMSETOOBMODE for selecting a mode to=20
access the OOB area.

Add new member into struct mtd_info:

struct mtd_info {
     ......

     enum {
          MTD_OOB_PLACE,
          MTD_OOB_AUTO,
          MTD_OOB_RAW,
     } oob_mode;
}

In function mtd_do_writeoob() (in drivers/mtd/mtdchar.c) :
     -  ops.mode =3D MTD_OOB_PLACE;
     + ops.mode =3D mtd->oob_mode;



Could we do it like this ?

Thanks
-LiuShuo
