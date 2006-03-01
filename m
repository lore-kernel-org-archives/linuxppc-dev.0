Return-Path: <pantelis@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 9172367A01
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 02:24:29 +1100 (EST)
From: Pantelis Antoniou <pantelis@embeddedalley.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx TSEC performance limits
Date: Wed, 1 Mar 2006 17:25:40 +0200
References: <9C1918067C3BC14C9C351C206D8A84370398A987@rennsmail03.eu.thmulti.com>
In-Reply-To: <9C1918067C3BC14C9C351C206D8A84370398A987@rennsmail03.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603011725.40644.pantelis@embeddedalley.com>
Cc: Joyeau Sylvain <Sylvain.Joyeau@thomson.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 01 March 2006 14:23, Joyeau Sylvain wrote:
> Hi,
> 
> Does anybody already succeeded in getting full TX bandwidth on a TSEC
> interface, transmitting 1500 bytes frames at netdev level (ie calling
> directly dev_queue_xmit(skb)) for instance ?
> 
> With default Gianfar driver parameters, I can transmit only around
> 870Mb/s (while reception side is idle). The other TSEC interface is used
> only to control a telnet terminal (~1Kb/s), the CPU is idle 60%,
> 6000irq/s.
> 
> I must decrease TX threshold value from 1024 to 128 to get 960Mb/s.
> 
> The problem is that decreasing the TX threshold under 512 bytes has a
> dramatic side effect: the Gianfar driver generates "TX underrun" events
> as soon as  I start, in parallel, a DMA transfer from memory to memory.
> Rather disappointing behavior from a PQ3@825MHz :-(
> 
> Any idea how to get full TX bandwidth _without_ modifying this
> parameter?
> 
> Thanks.
> 
> --
> sylvain
>

I don't know 85xx in any great detail, but most QUICCs have a register
that controls the DMA bus arbitration priorities. Find it and give
the highest priority to the ethernet.

Pantelis
