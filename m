Return-Path: <liberty@extricom.com>
Received: from smtp.extricom.com (smtp.extricom.com [192.114.46.18])
	by ozlabs.org (Postfix) with SMTP id 690FDB6F07
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 04:05:00 +1100 (EST)
Message-ID: <4CBDCD26.2080004@extricom.com>
Date: Tue, 19 Oct 2010 18:53:58 +0200
From: Eran Liberty <liberty@extricom.com>
MIME-Version: 1.0
To: Eran Liberty <liberty@extricom.com>
Subject: Re: Freescale P2020 CPU Freeze over PCIe abort signal
References: <4CADBD7B.3000506@extricom.com>	
	<1286756363.2463.517.camel@pasglop> <4CB2E517.8020401@extricom.com>
	<1286796721.5220.2.camel@pasglop>
	<4CBB4D80.3030007@extricom.com> <4CBC8B40.4060706@extricom.com>
In-Reply-To: <4CBC8B40.4060706@extricom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Eran Liberty wrote:
> Eran Liberty wrote:
>> This should probably go to the Freescale support, as it feels like a 
>> hardware issue yet the end result is a very frozen Linux kernel so I 
>> post here first...
>>
>> I have a programmable FPGA PCIe device connected to a Freescale's 
>> P2020 PCIe port. As part of the bring-up tests, we are testing two 
>> faulty scenarios:
>> 1. The FPGA totally ignores the PCIe transaction.
>> 2. The FPGA return a transaction abort.
>>
>> Both are plausible PCIe behavior and their should be outcome is 
>> documented in the PCIe spec. The first should be terminated by the 
>> transaction requestor timeout mechanism and raise an error, the 
>> second should abort the transaction and raise and error.
>>
>> In P2020 if I do any of those the CPU is left hung over the transaction.
>>
>> something like:
>> in_le32(addr)
>>
>> is turned into:
>> 7c 00 04 ac     sync   7c 00 4c 2c     lwbrx   r0,0,r9
>> 0c 00 00 00     twi     0,r0,0
>> 4c 00 01 2c     isync
>>
>> assembly code, where in r9 (in this example) hold an address which is 
>> physically mapped into the PCIe resource space.
>>
>> The CPU will hang over the load instruction.
>>
>> Just for the fun of it, I have wrote my own assembly function 
>> omitting everything but the load instruction; still freeze.
>> Replace "lwbrx" with a simple "lwz"; still freeze.
>>
>> It looks like the CPU snoozes till the PCIe transaction is done with 
>> no timeouts, ignoring any abort signal.
>>
>> I am going to:
>> A. Try to reach the Freescale support.
>> B. Asked the FPGA designed to give me a new behavior that will stall 
>> the PCIe transaction replay for 10 sec, but after those return ok.
>> C. report back here with either A or B.
>>
>> If you have any ideas I would love to hear them.
>>
>> -- Liberty
>>
> Some more info:
>
> As said the the FPGA designer provided me a PCIe device that will 
> stall its response to a variable amount of time. The CPU became 
> un-frozen after this amount of time. More over, we have found that in 
> that period till it un-froze the PCIe core did a retry to that 
> transaction over and over every 40 ms. This gave me the bright idea to 
> look for the word "retry" in the Freescale documentation which 
> rewarded me with these registers:
>
> ------------------------------------------------------- snip 
> -------------------------------------------------------
> 16.3.2.3        PCI Express Outbound Completion Timeout Register
>                (PEX_OTB_CPL_TOR)
> The PCI Express outbound completion timeout register, shown in Figure 
> 16-4, contains the maximum wait
> time for a response to come back as a result of an outbound non-posted 
> request before a timeout condition
> occurs.
> Offset 
> 0x00C                                                                                                
> Access: Read/Write
>         0   1              5     7   
> 8                                                                                      
> 31
>     R
>        TD            
> —                                                            TC
>     W
> Reset 0     0  0  0   0   0   0  0   0   0   0   1    0  0   0  0    
> 1   1  1    1   1  1   1   1   1  1   1   1  1  1   1  1
>            Figure 16-4. PCI Express Outbound Completion Timeout 
> Register (PEX_OTB_CPL_TOR)
> Table 16-6 describes the PCI Express outbound completion timeout 
> register fields.
>                                 Table 16-6. PEX_OTB_CPL_TOR Field 
> Descriptions
>  Bits     Name                                                     
> Description
>   0        TD     Timeout disable. This bit controls the 
> enabling/disabling of the timeout function.
>                   0 Enable completion timeout
>                   1 Disable completion timeout
>  1–7        —     Reserved
> 8–31       TC     Timeout counter. This is the value that is used to 
> load the response counter of the completion timeout.
>                   One TC unit is 8× the PCI Express controller clock 
> period; that is, one TC unit is 20 ns at 400 MHz, and 30
>                   ns at 266.66 MHz.
>                   The following are examples of timeout periods based 
> on different TC settings:
>                   0x00_0000 Reserved
>                   0x10_FFFF 22.28 ms at 400 MHz controller clock; 
> 33.34 ms at 266.66 MHz controller clock
>                   0xFF_FFFF 335.54 ms at 400 MHz controller clock; 
> 503.31 ms at 266.66 MHz controller clock
>
>
> 16.3.2.4       PCI Express Configuration Retry Timeout Register
>               (PEX_CONF_RTY_TOR)
> The PCI Express configuration retry timeout register, shown in Figure 
> 16-5, contains the maximum time
> period during which retries of configuration transactions which 
> resulted in a CRS response occur.
> Offset 
> 0x010                                                                               
> Access: Read/Write
>         0  1     3   
> 4                                                                                     
> 31
>     R
>        RD     —                                                 TC
>     W
> Reset 0    0  0  0  0   1  0  0  0  0   0  0   0  0  0  0   1  1  1  
> 1  1  1   1   1 1 1   1  1   1 1   1  1
>           Figure 16-5. PCI Express Configuration Retry Timeout 
> Register (PEX_CONF_RTY_TOR)
>                            QorIQ P2020 Integrated Processor Reference 
> Manual, Rev. 0
> 16-12                                                                                   
> Freescale Semiconductor
>                                                                                                 
> PCI Express Interface Controller
> Table 16-7 describes the PCI Express configuration retry timeout 
> register fields.
>                            Table 16-7. PEX_CONF_RTY_TOR Field 
> Descriptions
>  Bits  Name                                                     
> Description
>   0     RD    Retry disable. This bit disables the retry of a 
> configuration transaction that receives a CRS status response
>               packet.
>               0 Enable retry of a configuration transaction in 
> response to receiving a CRS status response until the timeout
>                  counter (defined by the PEX_CONF_RTY_TOR[TC] field) 
> has expired.
>               1 Disable retry of a configuration transaction 
> regardless of receiving a CRS status response.
>  1–3     —    Reserved
> 4–31    TC    Timeout counter. This is the value that is used to load 
> the CRS response counter.
>               One TC unit is 8× the PCI Express controller clock 
> period; that is, one TC unit is 20 ns at 400 MHz and 30 ns
>               at 266.66 MHz.
>               Timeout period based on different TC settings:
>               0x000_0000        Reserved
>               0x400_FFFF        1.34 s at 400 MHz controller clock, 
> 2.02 s at 266.66 MHz controller clock
>               0xFFF_FFFF        5.37 s at 400 MHz controller clock, 
> 8.05 s at 266.66 MHz controller clock
> ------------------------------------------------------- snap 
> -------------------------------------------------------
>
> Now this is all nice on the paper, but what the P2020 seems to be 
> doing in reality is
> 1. never expire
> 2. do re-tries even in the non configuration access
>
> I am going to try to disable completion timeout and see if I get 
> better behavior.
>
> -- Liberty
>
>
Disabling PEX_OTB_CPL_TOR,  PEX_CONF_RTY_TOR, or both yields the same 
behavior. The kernel freezes over the load command while the underlying 
hardware does PCIe transaction retries to infinity and beyond.

-- Liberty
