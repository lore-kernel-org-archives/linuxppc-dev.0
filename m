Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E212A67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 09:13:16 +1000 (EST)
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHMEIHCLAA.Joakim.Tjernlund@lumentis.se>
References: <BCEFJBPJCGFCNMMMIDBHMEIHCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4f898cca602f86b36579fd02046c1aac@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 23 Apr 2005 19:12:02 -0400
To: Joakim.Tjernlund@lumentis.se
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 23, 2005, at 1:23 PM, Joakim Tjernlund wrote:

> Does CONFIG_PIN_TLB make a difference?

While looking at the code, I noticed this will only work
if you can map all of the memory with wired TLB entries.
If you have more than 24M of memory, make sure you
enable CONFIG_MODULES to eliminate the TLB miss
optimization that will certainly crash a system by failing
to look up kernel PTEs correctly.

Thanks.


	-- Dan
