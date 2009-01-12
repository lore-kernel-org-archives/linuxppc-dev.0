Return-Path: <noname1.c@hotmail.com>
Received: from blu0-omc4-s5.blu0.hotmail.com (blu0-omc4-s5.blu0.hotmail.com
	[65.55.111.144]) by ozlabs.org (Postfix) with ESMTP id F1F66DDFE6
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 18:27:20 +1100 (EST)
Message-ID: <BLU127-W40CAB009B564198BFAF47B5D80@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_fec3ec31-dd59-48f6-8fb0-e892d2ca083c_"
From: =?gb2312?B?z/LT7g==?= <noname1.c@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: How does map_flash_by_law1 work?
Date: Mon, 12 Jan 2009 15:27:19 +0800
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_fec3ec31-dd59-48f6-8fb0-e892d2ca083c_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


I'm reading the start.S for mpc83xx in u-boot.
I couldn't understand how the source code below work:
 
/***************************************************
map_flash_by_law1: /* When booting from ROM (Flash or EPROM), clear the  */ /* Address Mask in OR0 so ROM appears everywhere      */ /*----------------------------------------------------*/ lis r3, (CFG_IMMR)@h  /* r3 <= CFG_IMMR    */ lwz r4, OR0@l(r3) li r5, 0x7fff        /* r5 <= 0x00007FFFF */ and r4, r4, r5 stw r4, OR0@l(r3)     /* OR0 <= OR0 & 0x00007FFFF */
 
 /* As MPC8349E User's Manual presented, when RCW[BMS] is set to 0,  * system will boot from 0x0000_0100, and the LBLAWBAR0[BASE_ADDR]  * reset value is 0x00000; when RCW[BMS] is set to 1, system will boot  * from 0xFFF0_0100, and the LBLAWBAR0[BASE_ADDR] reset value is  * 0xFF800.  From the hard resetting to here, the processor fetched and  * executed the instructions one by one.  There is not absolutely  * jumping happened.  Laterly, the u-boot code has to do an absolutely  * jumping to tell the CPU instruction fetching component what the  * u-boot TEXT base address is.  Because the TEXT base resides in the  * boot ROM memory space, to garantee the code can run smoothly after  * that jumping, we must map in the entire boot ROM by Local Access  * Window.  Sometimes, we desire an non-0x00000 or non-0xFF800 starting  * address for boot ROM, such as 0xFE000000.  In this case, the default  * LBIU Local Access Widow 0 will not cover this memory space.  So, we  * need another window to map in it.  */
 lis r4, (CFG_FLASH_BASE)@h ori r4, r4, (CFG_FLASH_BASE)@l stw r4, LBLAWBAR1(r3) /* LBLAWBAR1 <= CFG_FLASH_BASE */
 /* Store 0x80000012 + log2(CFG_FLASH_SIZE) into LBLAWAR1 */ /*0x8000_0000 is used to enable this window*/ /*0x0000_0000-0x0000_0012 is the reserved window size*/ lis r4, (0x80000012)@h ori r4, r4, (0x80000012)@l li r5, CFG_FLASH_SIZE1: srawi. r5, r5, 1 /* r5 = r5 >> 1 */ addi r4, r4, 1 bne 1b
 
 stw r4, LBLAWAR1(r3) /* LBLAWAR1 <= Flash Size */ blr
********************************************************/
 
the problem is from this segment:
 
1: srawi. r5, r5, 1 /* r5 = r5 >> 1 */ addi r4, r4, 1 bne 1b
 
How it adjust the flash size to the fit size?
I define the CFG_FLASH_SIZE equal 1 in the MPC8313ERDB.h
_________________________________________________________________
微软地图率先推出跨城市多点驾车路线查询！
http://ditu.live.com/?form=MRAHAB&rtp=pos.30.454167_116.308611_%E5%A4%AA%E6%B9%96__~pos.29.554046_115.983427_%E5%BA%90%E5%B1%B1__~pos.29.116111_110.478889_%E5%BC%A0%E5%AE%B6%E7%95%8C__&rtop=0~0~0&encType=1
--_fec3ec31-dd59-48f6-8fb0-e892d2ca083c_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
I'm reading the start.S for mpc83xx in u-boot.<BR>
I&nbsp;couldn't understand how the source code below work:<BR>
&nbsp;<BR>
/***************************************************<BR>
map_flash_by_law1:<BR>&nbsp;/* When booting from ROM (Flash or EPROM), clear the&nbsp; */<BR>&nbsp;/* Address Mask in OR0 so ROM appears everywhere&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>&nbsp;/*----------------------------------------------------*/<BR>&nbsp;lis&nbsp;r3, (CFG_IMMR)@h&nbsp; /* r3 &lt;= CFG_IMMR&nbsp;&nbsp;&nbsp; */<BR>&nbsp;lwz&nbsp;r4, <A href="mailto:OR0@l(r3">OR0@l(r3</A>)<BR>&nbsp;li&nbsp;r5, 0x7fff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* r5 &lt;= 0x00007FFFF */<BR>&nbsp;and&nbsp;r4, r4, r5<BR>&nbsp;stw&nbsp;r4, <A href="mailto:OR0@l(r3">OR0@l(r3</A>)&nbsp;&nbsp;&nbsp;&nbsp; /* OR0 &lt;= OR0 &amp; 0x00007FFFF */<BR>
&nbsp;<BR>
&nbsp;/* As MPC8349E User's Manual presented, when RCW[BMS] is set to 0,<BR>&nbsp; * system will boot from 0x0000_0100, and the LBLAWBAR0[BASE_ADDR]<BR>&nbsp; * reset value is 0x00000; when RCW[BMS] is set to 1, system will boot<BR>&nbsp; * from 0xFFF0_0100, and the LBLAWBAR0[BASE_ADDR] reset value is<BR>&nbsp; * 0xFF800.&nbsp; From the hard resetting to here, the processor fetched and<BR>&nbsp; * executed the instructions one by one.&nbsp; There is not absolutely<BR>&nbsp; * jumping happened.&nbsp; Laterly, the u-boot code has to do an absolutely<BR>&nbsp; * jumping to tell the CPU instruction fetching component what the<BR>&nbsp; * u-boot TEXT base address is.&nbsp; Because the TEXT base resides in the<BR>&nbsp; * boot ROM memory space, to garantee the code can run smoothly after<BR>&nbsp; * that jumping, we must map in the entire boot ROM by Local Access<BR>&nbsp; * Window.&nbsp; Sometimes, we desire an non-0x00000 or non-0xFF800 starting<BR>&nbsp; * address for boot ROM, such as 0xFE000000.&nbsp; In this case, the default<BR>&nbsp; * LBIU Local Access Widow 0 will not cover this memory space.&nbsp; So, we<BR>&nbsp; * need another window to map in it.<BR>&nbsp; */<BR>
<BR>&nbsp;lis r4, (CFG_FLASH_BASE)@h<BR>&nbsp;ori r4, r4, (CFG_FLASH_BASE)@l<BR>&nbsp;stw r4, LBLAWBAR1(r3) /* LBLAWBAR1 &lt;= CFG_FLASH_BASE */<BR>
&nbsp;/* Store 0x80000012 + log2(CFG_FLASH_SIZE) into LBLAWAR1 */<BR>&nbsp;/*0x8000_0000 is used to enable this window*/<BR>&nbsp;/*0x0000_0000-0x0000_0012 is the reserved window size*/<BR>&nbsp;lis r4, (0x80000012)@h<BR>&nbsp;ori r4, r4, (0x80000012)@l<BR>&nbsp;li r5, CFG_FLASH_SIZE<BR>1:&nbsp;srawi. r5, r5, 1&nbsp;/* r5 = r5 &gt;&gt; 1 */<BR>&nbsp;addi r4, r4, 1<BR>&nbsp;bne 1b<BR>
&nbsp;<BR>
&nbsp;stw r4, LBLAWAR1(r3) /* LBLAWAR1 &lt;= Flash Size */<BR>&nbsp;blr<BR>
********************************************************/<BR>
&nbsp;<BR>
the problem is from this segment:<BR>
&nbsp;<BR>
1:&nbsp;srawi. r5, r5, 1&nbsp;/* r5 = r5 &gt;&gt; 1 */<BR>&nbsp;addi r4, r4, 1<BR>&nbsp;bne 1b<BR>
&nbsp;<BR>
How it adjust the flash size to the fit size?<BR>
I define the CFG_FLASH_SIZE equal 1 in the MPC8313ERDB.h<BR><RTE_TEXT></RTE_TEXT><BR><br /><hr />MSN保护盾，十八般武艺保障MSN安全！ <a href='http://im.live.cn/safe/' target='_new'>现在就下载！</a></body>
</html>
--_fec3ec31-dd59-48f6-8fb0-e892d2ca083c_--
