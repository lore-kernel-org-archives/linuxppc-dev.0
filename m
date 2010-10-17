Return-Path: <liberty@extricom.com>
Received: from smtp.extricom.com (unknown [212.235.17.194])
	by ozlabs.org (Postfix) with SMTP id EC73AB70F3
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 06:28:57 +1100 (EST)
Message-ID: <4CBB4D80.3030007@extricom.com>
Date: Sun, 17 Oct 2010 21:24:48 +0200
From: Eran Liberty <liberty@extricom.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Freescale P2020 CPU Freeze over PCIe abort signal
References: <4CADBD7B.3000506@extricom.com>	
	<1286756363.2463.517.camel@pasglop> <4CB2E517.8020401@extricom.com>
	<1286796721.5220.2.camel@pasglop>
In-Reply-To: <1286796721.5220.2.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This should probably go to the Freescale support, as it feels like a 
hardware issue yet the end result is a very frozen Linux kernel so I 
post here first...

I have a programmable FPGA PCIe device connected to a Freescale's P2020 
PCIe port. As part of the bring-up tests, we are testing two faulty 
scenarios:
1. The FPGA totally ignores the PCIe transaction.
2. The FPGA return a transaction abort.

Both are plausible PCIe behavior and their should be outcome is 
documented in the PCIe spec. The first should be terminated by the 
transaction requestor timeout mechanism and raise an error, the second 
should abort the transaction and raise and error.

In P2020 if I do any of those the CPU is left hung over the transaction.

something like:
in_le32(addr)

is turned into:
7c 00 04 ac     sync   
7c 00 4c 2c     lwbrx   r0,0,r9
0c 00 00 00     twi     0,r0,0
4c 00 01 2c     isync

assembly code, where in r9 (in this example) hold an address which is 
physically mapped into the PCIe resource space.

The CPU will hang over the load instruction.

Just for the fun of it, I have wrote my own assembly function omitting 
everything but the load instruction; still freeze.
Replace "lwbrx" with a simple "lwz"; still freeze.

It looks like the CPU snoozes till the PCIe transaction is done with no 
timeouts, ignoring any abort signal.

I am going to:
A. Try to reach the Freescale support.
B. Asked the FPGA designed to give me a new behavior that will stall the 
PCIe transaction replay for 10 sec, but after those return ok.
C. report back here with either A or B.

If you have any ideas I would love to hear them.

-- Liberty
