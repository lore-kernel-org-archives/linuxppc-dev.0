Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (tel096021.tait.co.nz [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 01FC4683D5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 13:24:37 +1000 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 232C115B691
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 16:24:36 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])by
	gatekeeper.tait.co.nz (Postfix) with ESMTP id 85E0615B685for
	<linuxppc-embedded@ozlabs.org>; Tue, 11 Oct 2005 16:24:35 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by
	sunstrike.tait.co.nz(Sun Java System Messaging Server 6.1 (built Apr 28
	2004))id <0IO600G01ACZBK00@sunstrike.tait.co.nz>(original mail from
	robin.gilks@tait.co.nz) for linuxppc-embedded@ozlabs.org;
	Tue, 11 Oct 2005 16:24:35 +1300 (NZDT)
Date: Tue, 11 Oct 2005 16:24:34 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
In-reply-to: <434B2D23.2020208@rftechnology.com.au>
To: linuxppc-embedded@ozlabs.org
Message-id: <434B3072.1090008@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain;
	format=flowed;
	charset=ISO-8859-1
References: <20051010234614.1FE2A353D84@atlas.denx.de><434B12C5.2050809@tait
	.co.nz> <434B2D23.2020208@rftechnology.com.au>
Subject: Re: boot-time partitions and bootargs for 2.6.14
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dmytro Bablinyuk wrote:

>> struct map_info physmap_map = {
>>    .name = "fred",
>>    .size = WINDOW_SIZE,
>>    .buswidth = BUSWIDTH,
>>    .phys = WINDOW_ADDR,
>> };
>> and a command line something like:
>> mtdparts=fred:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()
>
>
> Thank you Robin,
>
> Yes, I have 'working' jffs2.img (original from board).
> I checked for spaces - it looks ok. It has 'physically_mapped_flash'. 

[snip]

In that case you should have a u-boot line of

mtdparts=physically_mapped_flash:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()
not of
mtdparts=1:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()

The name is significant (I think!!)

-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
