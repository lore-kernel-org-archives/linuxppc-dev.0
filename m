Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 4C6B7DE095
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 19:24:21 +1100 (EST)
Subject: Re: Virtual device hdlc0 asks to que packet!
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: rmcguire@videopresence.com
In-Reply-To: <000301c87e50$2bbdc680$6405a8c0@absolut>
References: <mailman.1516.1204637021.17968.linuxppc-embedded@ozlabs.org>
	<000301c87e50$2bbdc680$6405a8c0@absolut>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 09:11:56 +0100
Message-Id: <1204704716.20637.50.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-04 at 15:33 -0800, Russell McGuire wrote:
> All,
> 
> Background MPC8360, using a T1 PHY as an HDLC device.
> 
> Developing my hdlc driver, and was writing a simple send utility. To test it
> out. Things seem well when I had massive delays in between the write() or
> sendot(), and I was able to attain 100+Kbytes/sec. However, when I replaced
> the simple usleeps(xxx) with select statements, suddenly I started getting a
> ton of these messages.
> 
> "Virtual device hdlc0 asks to que packet!"
> 
> Along with dropped or non-sent data.
> 
> In my driver I am tracking the available TX buffers, and issue a
> netif_stop_que() statement inside the start_xmit() call, with a
> corresponding netif_wake_que() in the tx_handler.
> 
> Is there something else that needs to be done in order to make a select
> statement wait for the socket to not be busy? It seems that it always
> returns immediately with no timeout.
> 
> I guess the other pieces of the scenario are as follows:
> 
> * Using 'sethdlc hdlc0 hdlc' for the mode, so no IP stack is used.
> * Opening the socket to the hdlc device directly to the device itself, i.e.
> no port number socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> 
> I have used both sendto() and write() to pass data down, and they both
> return as if all the data has been sent, i.e. I never get an error.
> 
> -Russ

When playing with your driver I noticed that the hdlc interfaces had
txqueuelen:0
Normal eth interfaces has txqueuelen:1000. Maybe you need to add a
txqueue to the hdlc interfaces?

 Jocke

PS.
    The driver seems to work now, I get both TX and RX IRQs now.
