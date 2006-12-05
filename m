Return-Path: <xchen@sunrisetelecom.com.cn>
Received: from smtp01.east.net (smtp01.east.net [211.100.61.140])
	by ozlabs.org (Postfix) with ESMTP id AF39867B99
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 19:24:50 +1100 (EST)
Received: from unknown (HELO xchen)
	(Authenticated?user:?xchen@sunrisetelecom.com.cn@[211.157.209.206])
	(envelope-sender <xchen@sunrisetelecom.com.cn>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 5 Dec 2006 16:18:47 +0800
From: =?gb2312?B?s8LPow==?= <xchen@sunrisetelecom.com.cn>
To: <linuxppc-dev@ozlabs.org>
Subject: The "icache enable" cause the linux crash 
Date: Tue, 5 Dec 2006 16:18:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20061205082450.AF39867B99@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	
Hi,
	I use Uboot  to boot the linux. The console display "transferring
control to linux..."  and the LED1 is lighting. The linux crash at this.
When I port the Uboot to my board(MPC885), I meet the similar problem. I
must disable icache in board_init_f() then the uboot can run in ram. 
I delete line 2 and line 5 , it is worse. Both of LEDs are not light.  Could
you tell me why.  

initial_mmu:
	.
	.
	.
/* Since the cache is enabled according to the information we
	 * just loaded into the TLB, invalidate and enable the caches here.
	 * We should probably check/set other modes....later.
	 */
////////////////////////////////
Light the LED1
///////////////////////////////
1	lis	r8, IDC_INVALL@h
2	mtspr	IC_CST, r8
3	mtspr	DC_CST, r8
4	lis	r8, IDC_ENABLE@h
5	mtspr	IC_CST, r8
#ifdef CONFIG_8xx_COPYBACK
	mtspr	DC_CST, r8
#else
	/* For a debug option, I left this here to easily enable
	 * the write through cache mode
	 */
	lis	r8, DC_SFWT@h
	mtspr	DC_CST, r8
	lis	r8, IDC_ENABLE@h
	mtspr	DC_CST, r8
#endif
////////////////////////////////
Light the LED2
///////////////////////////////
