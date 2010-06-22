Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id 2B585B6F1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 01:11:02 +1000 (EST)
Received: from [10.11.13.50] (unknown [10.11.13.50])
	by mail.theptrgroup.com (Postfix) with ESMTP id CBB501E002
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 11:10:59 -0400 (EDT)
Message-ID: <4C20D27D.5000503@ThePTRGroup.com>
Date: Tue, 22 Jun 2010 11:10:53 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com>
In-Reply-To: <4C20CECB.9050609@mlbassoc.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2010 10:55 AM, Gary Thomas wrote:
> I'm still trying to get UCC UART to work on my MPC8358 with
> the 2.6.33.3 kernel.
> 
> When I try to send data to the port, there is no output, not
> even any interrupts on the device.  What I see is that the UART
> driver seems to initialize fine and pushes characters into
> the output buffers & descriptors.  However, there are no
> interrupts hence it just sits there...
> 
> My device tree entry for this device now looks like this:
>     /* ttyQE0 (UCC3) */
>     serial_qe0: serial@4000 {
>                 device_type = "serial";
>                 compatible = "ucc_uart";
>                 cell-index = <3>;
>         reg = <0x2200 0x200>;
>         interrupts = <34>;
>         interrupt-parent = <&qeic>;
>                 port-number = <0>;
>         rx-clock-name = "brg1";
>         tx-clock-name = "brg1";
>     };
> 
> * Are there any known issues with this driver?
> * Is there any way to get a handle on why no data is moving?
> * Is there some way to tell if the QE even sees the descriptors?
> * The driver and documentation mention a "soft UART" mode for
>   chips with broken UART hardware.  How do I know if my board
>   has functioning UART hardware?
> 
> Note: I have UCC1+UCC2 working great with ethernet.
> 
> Thanks for any pointers or ideas

Hi Gary,

According to the errata, it looks like the MPC8358 is subject to
erratum QE_UART6.  You'll need to use soft UART mode and load the
microcode patch.  Once that is done you will also need to use two
different BRG's, one for tx and one for rx, since the soft UART mode
microcode patch requires them to be set to different rates (I believe
Rx is 16*baud under soft UART mode, and Tx is 1*baud).

Also, I don't know if it matters or not, but you should change your
dts entry "serial@4000" to "serial@2200", just like you recently changed
your "reg =" to 0x2200.

Chuck Meade
chuck@ThePTRGroup.com
