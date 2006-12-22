Return-Path: <xchen@sunrisetelecom.com.cn>
Received: from smtp01.east.net (smtp01.east.net [211.100.61.140])
	by ozlabs.org (Postfix) with ESMTP id B3802DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Dec 2006 20:46:00 +1100 (EST)
Received: from unknown (HELO xchen)
	(Authenticated?user:?xchen@sunrisetelecom.com.cn@[211.157.209.206])
	(envelope-sender <xchen@sunrisetelecom.com.cn>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 22 Dec 2006 17:33:22 +0800
From: =?gb2312?B?s8LPow==?= <xchen@sunrisetelecom.com.cn>
To: <u-boot-users@lists.sourceforge.net>
Subject: sdram init MRS command
Date: Fri, 22 Dec 2006 17:34:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20061222094604.B3802DDE3B@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

	CPU type: MPC885
	SDRAM:    48LC16M16A2-75 x2

 	memctl->memc_mar=	0x00000088;
	memctl->memc_or1 = CFG_OR1_PRELIM;
	memctl->memc_br1 = CFG_BR1_PRELIM;
	memctl->memc_mamr = CFG_MAMR_9COL & (~(MAMR_PTAE));	/* no
refresh yet */
	udelay(200);
	memctl->memc_mcr=0x80002105; 	->>>>>>>>  after this I think the
function should sent data through address line
	udelay(1);
	memctl->memc_mamr= ( (CFG_MAMR_9COL &0xfffffff0) |0x08);
	udelay(200);

	As you see, The code set mar and run the ram word 0x05-0x07 to
precharge ,nop and MRS. After run MRS command I think the code should write
data through address line to set mode. But I don't find this step.  The
datasheet said mode redister are set  through A0-A12. My question is how the
mpc8xx set sdram mode.

Thanks
Andy
