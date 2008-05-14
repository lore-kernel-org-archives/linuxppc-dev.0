Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0A389DE1B6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 02:16:15 +1000 (EST)
Message-ID: <482B0F7B.3020905@ovro.caltech.edu>
Date: Wed, 14 May 2008 09:12:43 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: =?windows-1252?Q?=3F=3F?= <guojin02@tsinghua.org.cn>
Subject: Re: How to test the DDR memory with burst visit mode?
References: <410764342.21662@tsinghua.org.cn>
In-Reply-To: <410764342.21662@tsinghua.org.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> I designed my MPC8360E board with 1GBytes DDR-1 memory, I built two demo
> boards, one is 533/266/400, the other is 660/330/400. The lower frequancy board is
> no problem for our program, but the higher frequency board is always problem about
> the data transmit on ethernet. 
> I want to test 1GBytes DDR-1 memory, I want to know whether or not the DDR is
> stable and accuracy. Could you tell me a simple way that test my DDR memory? 

I use MPC8349E, so the following should be similar.

1) If your board is a PCI agent.

    You can run code on a host CPU that can view the MPC8360 board
    over the PCI bus.

    Setup the MPC8360 to come out of reset with the core held
    in reset.

    Program the DDR controller from the host CPU.

    Program the DMA controller to move data to/from the board DDR
    from/to the host memory (PCI transactions).

    Sweep the DDR MCK and DQS clock skew registers across their
    ranges and check for memory errors.

    You should get two or three settings that work ok.

2) If your board is a PCI host, then its a bit trickier, as you
    ideally want to generate burst traffic to test the DDR controller,
    and since you need to reprogram the DDR controller, you can not
    be running code there, eg. U-Boot.

    If the MPC8360 has an I/O Sequencer (IOS) as on the MPC8349E, then
    I think you should be able to write some code that DMAs from
    Flash to DDR. The IOS should copy the data first to its FIFO,
    and then to the DDR, so it should generate a burst.

    If you have a BDI2000, you should be able to manually program
    the DDR controller and the DMA controller. If you don't, just
    write some simple code that runs from the startup vector,
    eg. copy the contents of start.S up until the stack-in-dcache
    trick, and then you can write some C-code.

Hope that helps.
Cheers,
Dave
