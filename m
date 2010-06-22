Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 7168FB6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 01:14:20 +1000 (EST)
Message-ID: <4C20D34A.80202@mlbassoc.com>
Date: Tue, 22 Jun 2010 09:14:18 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Chuck Meade <chuck@ThePTRGroup.com>
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com> <4C20D27D.5000503@ThePTRGroup.com>
In-Reply-To: <4C20D27D.5000503@ThePTRGroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2010 09:10 AM, Chuck Meade wrote:
> On 06/22/2010 10:55 AM, Gary Thomas wrote:
>> I'm still trying to get UCC UART to work on my MPC8358 with
>> the 2.6.33.3 kernel.
>>
>> When I try to send data to the port, there is no output, not
>> even any interrupts on the device.  What I see is that the UART
>> driver seems to initialize fine and pushes characters into
>> the output buffers&  descriptors.  However, there are no
>> interrupts hence it just sits there...
>>
>> My device tree entry for this device now looks like this:
>>      /* ttyQE0 (UCC3) */
>>      serial_qe0: serial@4000 {
>>                  device_type = "serial";
>>                  compatible = "ucc_uart";
>>                  cell-index =<3>;
>>          reg =<0x2200 0x200>;
>>          interrupts =<34>;
>>          interrupt-parent =<&qeic>;
>>                  port-number =<0>;
>>          rx-clock-name = "brg1";
>>          tx-clock-name = "brg1";
>>      };
>>
>> * Are there any known issues with this driver?
>> * Is there any way to get a handle on why no data is moving?
>> * Is there some way to tell if the QE even sees the descriptors?
>> * The driver and documentation mention a "soft UART" mode for
>>    chips with broken UART hardware.  How do I know if my board
>>    has functioning UART hardware?
>>
>> Note: I have UCC1+UCC2 working great with ethernet.
>>
>> Thanks for any pointers or ideas
>
> Hi Gary,
>
> According to the errata, it looks like the MPC8358 is subject to
> erratum QE_UART6.  You'll need to use soft UART mode and load the
> microcode patch.  Once that is done you will also need to use two
> different BRG's, one for tx and one for rx, since the soft UART mode
> microcode patch requires them to be set to different rates (I believe
> Rx is 16*baud under soft UART mode, and Tx is 1*baud).

As I feared!  Can you tell me where/how to get the microcode patch?

> Also, I don't know if it matters or not, but you should change your
> dts entry "serial@4000" to "serial@2200", just like you recently changed
> your "reg =" to 0x2200.

I did that as soon as I sent this and saw the glaring inconsistency :-)

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
