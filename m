Return-Path: <vikrant.basotra@indiatimes.com>
Received: from WS0005.indiatimes.com (smtp5.indiatimes.com [203.199.93.15])
	by ozlabs.org (Postfix) with ESMTP id 441F36800E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2005 11:24:31 +1000 (EST)
From: "vikrant.basotra" <vikrant.basotra@indiatimes.com>
Message-Id: <200508091026.PAA18553@WS0005.indiatimes.com>
To: <linuxppc-dev@ozlabs.org>, <linuxppc-embedded@ozlabs.org>
Date: Tue, 09 Aug 2005 16:12:24 +0530
Content-Type: multipart/alternative;
	boundary="=_MAILER_ATTACH_BOUNDARY1_20058921612241224679759"
MIME-Version: 1.0
Cc: sibi_mathew@satyam.com, vikrant_basotra@satyam.com,
	apoorv_sangal@satyam.com
Subject: Flash not getting in to Query Mode while Linux Bootup
Reply-To: "vikrant.basotra" <vikrant.basotra@indiatimes.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=_MAILER_ATTACH_BOUNDARY1_20058921612241224679759
Content-Type: text/plain; charset=us-ascii

Hi All,
	I am porting Linux on the custom board PMC8266 (having MPC8266
microprocessor) based on the ADS8260 board.I am using ELDK1.1.1 and 
Linux2.4.24.
I am using Intel StrataFlash Memory Chip (28F256J3A) where the JFFS2 filesystem image is 
located.

I am not able to mount the file system, and I am getting the following error message during boot up
******************************************
CFI: Found no pmc8260 flash memory device at location zero
******************************************

During the dry run I have figured out that the error is occuring because the Flash is getting in to the CFI Query mode,
The code snippet as in file drivers/mtd/chips/cfi_probe.c is as following:
********************************************
static int cfi_probe_chip(struct map_info *map, __u32 base,
			  struct flchip *chips, struct cfi_private *cfi)
{
	...................................
	...................................
	..................................
	
	cfi_send_gen_cmd(0xF0, 0, base, map, cfi, cfi-device_type, NULL);
	cfi_send_gen_cmd(0x98, 0x55, base, map, cfi, cfi-device_type, NULL);

	...................................
	...................................
	..................................

}
********************************************

As per the data sheet the command sequence to set the flash in to CFI Query mode is correct.
But what the kernel is getting at the Query Address is the Data present at that location,instead of the expected
Query DATA i.e Q.R.Y

Please let me know how should i get rid of this problem.

Regards,
Vikrant BasotraIndiatimes Email now powered by APIC Advantage. Help! 
Help


--=_MAILER_ATTACH_BOUNDARY1_20058921612241224679759
Content-Type: text/html; charset=us-ascii

Hi All,
	I am porting Linux on the custom board PMC8266 (having MPC8266
microprocessor) based on the ADS8260 board.I am using ELDK1.1.1 and 
Linux2.4.24.
I am using Intel StrataFlash Memory Chip (28F256J3A) where the JFFS2 filesystem image is 
located.

I am not able to mount the file system, and I am getting the following error message during boot up
******************************************
CFI: Found no pmc8260 flash memory device at location zero
******************************************

During the dry run I have figured out that the error is occuring because the Flash is getting in to the CFI Query mode,
The code snippet as in file drivers/mtd/chips/cfi_probe.c is as following:
********************************************
static int cfi_probe_chip(struct map_info *map, __u32 base,
			  struct flchip *chips, struct cfi_private *cfi)
{
	...................................
	...................................
	..................................
	
	cfi_send_gen_cmd(0xF0, 0, base, map, cfi, cfi->device_type, NULL);
	cfi_send_gen_cmd(0x98, 0x55, base, map, cfi, cfi->device_type, NULL);

	...................................
	...................................
	..................................

}
********************************************

As per the data sheet the command sequence to set the flash in to CFI Query mode is correct.
But what the kernel is getting at the Query Address is the Data present at that location,instead of the expected
Query DATA i.e Q.R.Y

Please let me know how should i get rid of this problem.

Regards,
Vikrant Basotra<hr><font face="Arial" size="2">Indiatimes Email now powered by <b>APIC Advantage</b>. <a href="http://email.indiatimes.com/apic/">Help!</a> </font><br><DIV align=left><a target="_blank" href="http://imaround.indiatimes.com/IMaround/presencefr.mss?userid=vikrant.basotra" ><IMG alt="My Presence" border=0 src="http://203.199.93.51/IMaround/getpresence.mss?userid=vikrant.basotra" ></a><a target="_blank" href="http://email.indiatimes.com/apic/userpage.html"><FONT face="Arial" size=2>Help</font></a></DIV><hr><br><DIV align="left"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0" width="360" height="80"><param name="movie" value="http://203.199.93.12/image/swap.swp"><param name="quality" value="high"><embed src="http://203.199.93.12/image/swap.swp" quality="high" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" ty!
pe="application/x-shockwave-flash" width="360" height="80"></embed></object></DIV>

--=_MAILER_ATTACH_BOUNDARY1_20058921612241224679759--
