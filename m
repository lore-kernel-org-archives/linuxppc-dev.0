Date: Thu, 11 Mar 2004 20:27:29 -0800
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: Xilinx PLB UART
In-reply-to: <20040310234754.50442.qmail@web11608.mail.yahoo.com>
To: Shamile Khan <shamile@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <40513C31.4040106@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252; format=flowed
References: <20040310234754.50442.qmail@web11608.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are not aware of any issues with the PLB Uart. As a matter of fact,
since your posting I tried the PLB Uart both in 16450 as well as in
16550A mode on the ML300 and both ways the Linux kernel booted fine and
showed normal behavior when accessed through the serial console. For
this test I've used the kernel shipping with MontaVista Linux 3.0
(2.4.18) and used the MLD technology of EDK to generate the proper BSP
for Linux.

Send me private mail if you want to have a copy of the EDK project with
the PLB Uart.

Some things to look for in your project:
- make sure the address map of the PLB Uart does not overlap with the
address region of the PLB2OPB bridge.
- use recent tools and the most recent cores available (e.g. EDK 6.1.2
and PLB Uart v1_00_c).
- use the MLD technology in EDK to generate a BSP for your Linux kernel.
With that you will automatically avoid problems with interrupt mapping
and similar things.
- for all new designs use EDK (vs V2PDK).
- start with the EDK reference design for ML300 available from
http://www.xilinx.com/ise/embedded/edk_examples.htm (design # 6). You
can modify this design to match your board.

Cheers,
- Peter


Shamile Khan wrote:

>Hi,
>
>This question concerns Xilinx Virtex II Pro platform. We
>have been using OPB UART for Linux. We just tried to switch
>from OPB UART to PLB UART. We have interrupts enabled. So
>the kernel boots till
>
>Freeing unused kernel memory: 40k init
>
>At this point, I dont see anything on the screen. I dont
>even see the slow display of characters on the screen
>implying that the kernel has switched to polling mode. I
>didnt change anything for the kernel as I expected the OPB
>UART functionality to be identical to PLB UART from
>processor's perspective. Are you aware of any issues
>concerning PLB UART for Linux?
>
>Thanks,
>Shamile
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
