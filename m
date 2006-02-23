Return-Path: <lagrange@fr.oleane.com>
Received: from smtp6.clb.oleane.net (smtp6.clb.oleane.net [213.56.31.26])
	by ozlabs.org (Postfix) with ESMTP id A19E667A06
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 04:23:07 +1100 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Gianfar is slower  than fcc_enet on MPC8541 ???
Date: Thu, 23 Feb 2006 18:28:40 +0100
Message-ID: <000001c6389e$980f0ff0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000701c6389b$49e30960$5201a8c0@GEG2400>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

Sorry to reply so late. I was out of office.

I tried the below Andy's idea. It works fine.
It is my TCP clients which now slow the traffic.

But I don't know why the default timeouts are so high.
If the traffic is high, the timeout does not fire.
If the traffic is low, the timeout seems too long (???).

Thanks all for your ideas and works.
Best regards
Laurent


> De la part de Andy Fleming
> Envoye : mar. 14 fevrier 2006 18:37
> A : Laurent Lagrange
> Cc : linuxppc-embedded@ozlabs.org
> Objet : Re: Gianfar is slower than fcc_enet on MPC8541 ???
> 
> My guess is that you are measuring latency.  By default, interrupt  
> coalescing is on, and used to be set to very poor default 
> values.  In drivers/net/gianfar.h, change the defaults to look like this:
> 
> #define DEFAULT_TX_COALESCE 1
> #define DEFAULT_TXCOUNT 16
> #define DEFAULT_TXTIME  4
> 
> #define DEFAULT_RX_COALESCE 1
> #define DEFAULT_RXCOUNT 16
> #define DEFAULT_RXTIME  4
> 
> The problem was that the timeout was quite long, so a small number of  
> packets would have to wait a whole millisecond (or more!) to get  
> processed.  While it wouldn't affect bandwidth tests, which send many  
> packets, it would affect a simple test like ping.
> 
> If you don't feel like recompiling the kernel, you can use ethtool to  
> change the timeout values.
 
