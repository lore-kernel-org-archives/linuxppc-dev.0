Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr15.xs4all.nl (smtp-vbr15.xs4all.nl [194.109.24.35])
	by ozlabs.org (Postfix) with ESMTP id DACC9DDF2D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Mar 2008 19:03:32 +1100 (EST)
Message-ID: <47D0F479.4050109@aimvalley.nl>
Date: Fri, 07 Mar 2008 08:53:29 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: RAW Sockets - HDLC or Ethernet
References: <000001c87f6b$e1d5e9e0$6405a8c0@absolut>
In-Reply-To: <000001c87f6b$e1d5e9e0$6405a8c0@absolut>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


I guess this is what a raw packet socket is supposed to do.
It's not a bug it's a feature.
Can't you somehow recognize your own packet (and skip it) ?

Btw. this question can probably be better addressed in
comp.os.linux.development.system

---
N. van Bolhuis.


Russell McGuire wrote:
> Anyone,
> 
> Yet another mysterious question, at least to me.
> 
> I have written to simple utilities to send and receive a file / data through
> a newly created driver, HDLC using an MPC8360E. 
> Though I doubt this question is limited to that specific HW.
> 
> The main question is that everything I send though device HDLC0 I can
> immediately read from HDLC0 even though logically there is no connection
> there. It as if the kernel is immediately allowing me to read from the same
> device, what a separate application just wrote.???
> HOW CAN THIS BE?
> 
> Details:
> I have two applications: send and receive.  (pseudo code as follows)
> 
> Send opens a socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL)).
> And binds it (AF_PACKET, ETH_P_HLDC, if_index(hdlc0))
> 
> Receive opens a socket to the same device 
> socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL))
> bind(AF_PACKET, ETH_P_ALL, if_index(hdlc0)
> 
> Note they are opening the same device.
> 
> Now if I send anything through the send application, I immediately receive
> it via the receive application??
> Note, entirely separate processes!
> 
> Note, there is NO hardware loopback, this should be a dead end, and I should
> get nothing back at least as far as HW is concerned.
> 
> What am I missing, that causes all my TX data to show up immediately in the
> RX app? Note I have verified my HDLC drier is not actually receiving
> anything, so is there something in the kernel that is bridging the TX / RX
> paths, or am I just missing the function of this? If so how can I use RAW
> mode, while not mixing this, or at least keeping them separate in the
> applications?
> 
> -Russ
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
This message has been scanned for viruses and is believed to be clean
