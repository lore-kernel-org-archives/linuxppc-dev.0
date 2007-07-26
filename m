Return-Path: <erik@dd.nec.com.au>
Received: from ns2.nec.com.au (ns2.nec.com.au [147.76.180.2])
	by ozlabs.org (Postfix) with ESMTP id 49014DDF17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 19:03:39 +1000 (EST)
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 19:03:38 +1000 (EST)
Received: from bohr.dd.nec.com.au (bohr.dd.nec.com.au [172.31.20.11])
	by deer.dd.nec.com.au (8.12.5/8.12.5/Debian-1) with ESMTP id
	l6Q93bwX007104
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Jul 2007 19:03:37 +1000
Received: from dvalin ([172.31.20.70])
	by bohr.dd.nec.com.au (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	l6Q93Xil016263
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Jul 2007 19:03:37 +1000
Date: Thu, 26 Jul 2007 19:11:10 +1000
To: linuxppc-embedded@ozlabs.org
Subject: Re: I have a question about:ppc pci and frame_buffer
Message-ID: <20070726091110.GB8884@dd.nec.com.au>
References: <749612.18053.qm@web15210.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <749612.18053.qm@web15210.mail.cnb.yahoo.com>
From: erik@dd.nec.com.au (Erik Christiansen)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 03:58:04PM +0800, ???? ?? wrote:
>   here below is what i want :
>   #################################################
>   0..................7  8............15 16..............24 25.................31 
>            B                    G                   R                TRANS
>   now it is this:
>   #################################################
>   0..................7  8............15 16..............24 25.................31 
>         TRANS               R                   G                   B

In U-boot, there is what you might do yourself, perhaps:

#define LONGSWAP(x) ((((x) & 0x000000ff) << 24) | (((x) & 0x0000ff00) << 8)|\
           (((x) & 0x00ff0000) >>  8) | (((x) & 0xff000000) >> 24) )
#define PCISWAP(x)   LONGSWAP(x)

Any good for your purpose?

Erik
