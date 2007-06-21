Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C4E43DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jun 2007 04:11:51 +1000 (EST)
Message-ID: <467AC10C.4050906@ru.mvista.com>
Date: Thu, 21 Jun 2007 22:18:52 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
Subject: Re: Virtex 4 Avnet Mini-Module Networking.
References: <BAY115-W111D8089A1F12D9A5764AAB2100@phx.gbl>
In-Reply-To: <BAY115-W111D8089A1F12D9A5764AAB2100@phx.gbl>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mohammad Sadegh Sadri wrote:
> 
> very interesting
> 
> the provided xps project from xapp941 results 230Mbits but your custome system is 83.0Mbits, yes?

yes

> just, are you sure the ppc core has the same core clock frequency in both designs? I mean may be the xapp941 is running at 300MHz but yours at 100MHz. 

both run at 300MHz

> And what about a custom system with 9.1SP2? does that gives the same performance?

haven't tried this yet

> Finally If possible please release the test results for TCP streams. ( 9.1 no SP and 9.1 SP2 )

The TEMAC driver is from EDK 9.1.02 (IOW, SP2).

bitstream made by myself with EDK 9.1.00:
=========================================

root@192.168.119.11:~/netperf-2.4.1/src# ./netperf -l 30 -H 192.168.119.1 -i 10, 2 -I 99,10 -t TCP_STREAM -- -m 32768 -s 262144
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.119.1 (192.168.119.1) port 0 AF_INET : ±5.0% @ 99% conf.
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

  87380 217088  32768    30.00      41.66

bitstream from XAPP941:
=======================

root@192.168.119.11:~/netperf-2.4.1/src# ./netperf -l 30 -H 192.168.119.1 -i 10, 2 -I 99,10 -t TCP_STREAM -- -m 32768 -s 262144
TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.119.1 (192.168.119.1) port 0 AF_INET : ±5.0% @ 99% conf.
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

  87380 217088  32768    30.00     111.86

And I didn't test ML405 receive performance.

Thanks,
Andrei

> thanks
> 
> 
> 
> ----------------------------------------
>> Date: Thu, 21 Jun 2007 18:53:49 +0400
>> From: akonovalov@ru.mvista.com
>> To: mamsadegh@hotmail.com
>> CC: linuxppc-embedded@ozlabs.org; kashiwagi@co-nss.co.jp; glenn.g.hart@us.westinghouse.com
>> Subject: Re: Virtex 4 Avnet Mini-Module Networking.
>>
>> Mohammad Sadegh Sadri wrote:
>>> I'm wondering where are the original developers of TEMAC driver these days, I have not seen any posts from any of andrei
>>> nor grant in the recent weeks. may be they are involved in other projects.
>> As for me - no, not until the end of this week..
>>
>> I am puzzled with the following:
>>
>> I've got ML405 recently. There is a prebuilt bitstream with TEMAC in SGDMA mode for this board made by Xilinx (XAPP941).
>> With the TEMAC driver from EDK 9.1SP2 and the XAPP941 bitstream I've got (no jumbo frames):
>>
>>    XTemac: using sgDMA mode.
>>    XTemac: using TxDRE mode
>>    XTemac: using RxDRE mode
>>    XTemac: buffer descriptor size: 32768 (0x8000)
>>    XTemac: (buffer_descriptor_init) phy: 0x3cf8000, virt: 0xff100000, size: 0x8000
>>    eth%d: XTemac: PHY detected at address 7.
>>    eth0: Xilinx TEMAC #0 at 0x80000000 mapped to 0xC5060000, irq=0
>>    eth0: XTemac id 1.0f, block id 5, type 8
>>
>>    eth0: XTemac: Options: 0xb8f2
>>    eth0: XTemac: We renegotiated the speed to: 1000
>>    eth0: XTemac: speed set to 1000Mb/s
>>    eth0: XTemac: Send Threshold = 16, Receive Threshold = 2
>>    eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 1
>>
>>    root@192.168.119.11:~/netperf-2.4.1/src# ./netperf -l 30 -H 192.168.119.1 -i 10,
>>    2 -I 99,10 -t UDP_STREAM -- -m 32768 -s 262144
>>    UDP UNIDIRECTIONAL SEND TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.11
>>    9.1 (192.168.119.1) port 0 AF_INET : ±5.0% @ 99% conf.
>>    Socket  Message  Elapsed      Messages
>>    Size    Size     Time         Okay Errors   Throughput
>>    bytes   bytes    secs            #      #   10^6bits/sec
>>
>>    217088   32768   30.00       26391      0     230.60
>>    107520           30.00       26377            230.48
>>
>> Not that bad for this setup.
>>
>> With xps (EDK 9.1 without any SPs) I've tried creating exact the same design.
>> So that exact the same kernel etc could be used for the both bitstreams.
>> And with the self-made one I see exact the same output with the only difference:
>>
>>    root@192.168.119.11:~/netperf-2.4.1/src# ./netperf -l 30 -H 192.168.119.1 -i 10,
>>    2 -I 99,10 -t UDP_STREAM -- -m 32768 -s 262144
>>    UDP UNIDIRECTIONAL SEND TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.11
>>    9.1 (192.168.119.1) port 0 AF_INET : ±5.0% @ 99% conf.
>>    Socket  Message  Elapsed      Messages
>>    Size    Size     Time         Okay Errors   Throughput
>>    bytes   bytes    secs            #      #   10^6bits/sec
>>
>>    217088   32768   30.00        9593      0      83.82
>>    107520           30.00        9586             83.76
>>
>> :o(
>>
>> Rebuilding the XAPP941 project with EDK 9.1.00 still leaves 230Mb/sec.
>> I also pulled the additional timing constraints from XAPP941's data/system.ucf
>> into the self-made data/system.ucf, but this haven't change anything.
>>
>> I've run out of ideas, and switched from TEMAC to other Xilinx stuff for a while.
>>
>>
>> Thanks,
>> Andrei
> 
> _________________________________________________________________
> Connect to the next generation of MSN Messenger 
> http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=wlmailtagline
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
