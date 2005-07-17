Return-Path: <gqbenjamin@21cn.com>
Received: from 21cn.com (send.forptr.21cn.com [202.105.45.50])
	by ozlabs.org (Postfix) with SMTP id 8D17067C22
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 14:02:20 +1000 (EST)
Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <7h949282879570.27244@webmail1.inner-21cn.com>
Date: Sun, 17 Jul 2005 12:04:29 +0800 (CST)
From: gqbenjamin@21cn.com
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Re: help: FCC_ENET OF MPC8250?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for your replying.
I have resolved that problem.
I found a bug in function *fcc_enet_start_xmit*.
In linux-2.6.12 and linux-2.6.9, the bug had been 
patched by Dan Malek. 
In fcc_net.c of linux-2.6.5,  
at the end of *fcc_enet_start_xmit* :

if (bdp->cbd_sc & BD_ENET_TX_READY) {
	netif_stop_queue(dev);
	cep->tx_full = 1;
	}

This cann't be used to decide TX-BD is full.
If the rate of transmit is too high, the *skbuf*
in TX-BD probably have not chance to be free befor 
a new one had been put in. So, memory been lost.


> On Wed, 13 Jul 2005 10:42:52 +0800 (CST)
> gqbenjamin@21cn.com wrote:
> 
> > Hi,
> > 
> > I use a device, like SMARTBITS, to test the Ethernet rate of mpc8250. The kernel is linux-2.4.20
> > with CONFIG_FCC_LXT971 and CONFIG_USE_MDIO, and do 'cat "1">/proc/sys/net/ipv4/ip_forward'.
> > 
> > If the rate of sending IP packet been set too high, for example 100 Mbps Full Duplex and each
> > packet is 1514 Bytes. Later, the kernel print '... Memory squeeze, dropping packet' on uart. Stop
> > sending IP packet and do 'cat /proc/meminfo', the *MemFree* become small.
> > 
> > Try again, the *MemFree* become smaller, just look like some allocated memory (skbuf) do not be
> > free.
> > 
> > Final, the kernel break down, because all memory have been used.
> 
> 
> It sounds to me like the problem may be that fcc_enet_rx() is consuming all the memory.  This
> function is called in interrupt context and spins round the rx buffer descriptor ring until it finds
> an empty buffer descriptor.  There is no check to stop it going round more than once and each time
> it finds a BD it does a dev_alloc_skb().
> 
> It is possible that you are receiving data at a high enough rate that fcc_enet_rx() never exits.
> 
> What is more likely is that there isn't enough time between rx interrupts for the CPU to tx all the
> queued packets.
> 
> 
> > 
> > Q. How can I do to let kernel do not break down? Is it a kernel promblem?
> > 
> 
> This is just a guess, but... it may help to move fcc_enet_rx() from the interrupt handler to a
> bottom half.  If you do this you should also ensure that it cannot process the rx buffer descriptor
> ring more than once per call.  This may give the CPU *more* chance to tx queued packets by lowering
> the rx priority a little.
> 
> I don't know if this would work but I'd be interested to find out.
> 
> Alex
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
