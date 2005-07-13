Return-Path: <gqbenjamin@21cn.com>
Received: from 21cn.com (send.forptr.21cn.com [202.105.45.49])
	by ozlabs.org (Postfix) with SMTP id B57C767BD0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 12:51:25 +1000 (EST)
Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <Q6949286895747.26323@webmail1.inner-21cn.com>
Date: Wed, 13 Jul 2005 10:42:52 +0800 (CST)
From: gqbenjamin@21cn.com
To: linuxppc-embedded@ozlabs.org 
Cc: 
Subject: help: FCC_ENET OF MPC8250?
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

I use a device, like SMARTBITS, to test the Ethernet rate of mpc8250. The kernel is linux-2.4.20 with CONFIG_FCC_LXT971 and CONFIG_USE_MDIO, and do 'cat "1">/proc/sys/net/ipv4/ip_forward'.

If the rate of sending IP packet been set too high, for example 100 Mbps Full Duplex and each packet is 1514 Bytes. Later, the kernel print '... Memory squeeze, dropping packet' on uart. Stop sending IP packet and do 'cat /proc/meminfo', the *MemFree* become small.

Try again, the *MemFree* become smaller, just look like some allocated memory (skbuf) do not be free.

Final, the kernel break down, because all memory have been used.

Q. How can I do to let kernel do not break down? Is it a kernel promblem?

PS: 
I use linux-2.6.5 on mpc8250 for the same test, and get the same result.
I change some code in file skbuff.c, use a memory pool that I created instead of allocating *skb* from *MemFree*, and do the same test. Final, the kernel can not transmit any IP packet, beacuse all space in the pool been used, but do not break down. 

Thanks for your reading.

e-mail: gqben@sina.com gqbenjamin@163.com gqbenjamin@21cn.com

----------------------------------------------
vgo体验桌面快感，享受宽频乐趣！ 
http://vgo.21cn.com 
点这里免费体验发送4G大附件 
http://mail.21cn.com/huodong/0504/mail/ 
彩屏手机白送啦!赶快来拿! 
http://qipai.g.21cn.com 
智慧大挑战就在低价夺宝 
http://super.21cn.com/ 
体验另类约会，感受别样浪漫 
http://y.21cn.com/club/ 
小灵通短信中心，短信魅力无极 
http://pas.21cn.com/ 
全能聊2005版闪亮登场！ 
http://callme.21cn.com 
