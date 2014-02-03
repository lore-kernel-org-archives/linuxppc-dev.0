Return-Path: <michael.moese@men.de>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.168])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 09DD02C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2014 19:21:03 +1100 (EST)
Date: Mon, 3 Feb 2014 09:20:50 +0100
From: Michael Moese <michael.moese@men.de>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: PCIe Access - achieve bursts without DMA
Message-ID: <20140203082050.GB1970@localhost.intra.men.de>
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
 <1391208815.27142.38.camel@pasglop>
 <52EC2F46.7000609@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <52EC2F46.7000609@ovro.caltech.edu>
Cc: linuxppc-dev@lists.ozlabs.org, "Moese, Michael" <michael.moese@men.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 31, 2014 at 03:18:30PM -0800, David Hawkins wrote:
> 1. Peripheral board DMA (board-to-board)
> 2. Peripheral board DMA to host memory.
> 3. Host (root complex) DMA.
> 
> As far as "verification" of your custom peripheral board FPGA IP is
> concerned, if I was a customer, and you had data for (1) and (2),
> I'd be pretty happy (and could care less about (2), since its so
> system dependent).

Usually I would totally agree with you and try to implement the benchmark
using DMA transfers Unfortunately, we have some boards and IP cores that
do not support DMA transfers, or the target system must not do by a 
requirement, and as I have no influence on these, I had to investigate
on how to improve my throughput.
I've submitted a RFC Patch earlier today, which allowed me to perform
PCIe read bursts on IO memory, achieving 18 MB/s instead of the 3 MB/s
I got when using non-cached reads. However, I had to ioremap() my 
memory, like Gabriel said, using write-thru configuration. 

> Since its an FPGA-based IP. I'd also expect to see a PCIe simulation
> with Bus Functional Models showing what the optimal performance of
> your IP was, and then how it nicely matches with the measurements
> in (1). If you do not have a PCIe logic analyzer, both Xilinx and
> Altera have Chipscope/SignalTap logic analyzers that can be used
> for tracing traffic at the TLP layer inside the FPGA.

Of course our IP developers to simulation and analyzing, we have PCI
and PCIe analyzer and all other equipment one might need. However,
we've seen that not only on PowerPC but also on x86, performing real
bursts is not intuitive.


Thank you for your help - we might be satisfied with the achieved 
18 MB/s.


Michael
