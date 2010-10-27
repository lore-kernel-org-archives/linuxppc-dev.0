Return-Path: <natalie@extricom.com>
Received: from smtp.extricom.com (smtp.extricom.com [192.114.46.18])
	by ozlabs.org (Postfix) with SMTP id 722A8B70AA
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Oct 2010 20:27:18 +1100 (EST)
Message-ID: <4CC7EFFC.10405@extricom.com>
Date: Wed, 27 Oct 2010 11:25:16 +0200
From: Natalie Shapira <natalie@extricom.com>
MIME-Version: 1.0
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Freescale P2020/ 85xx PCIe: DMA low throughtput
References: <4CBEC62E.30900@extricom.com>
	<929D3CED81F34E43887A393170D66FB90355C3CA@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <929D3CED81F34E43887A393170D66FB90355C3CA@GBRSUN01MS002.eu.xerox.net>
Content-Type: multipart/alternative;
	boundary="------------060300080805060605030409"
Cc: linuxppc-dev@ozlabs.org, zw@zh-kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060300080805060605030409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jenkins, Clive wrote:
>> Hi, 
>>
>> I'm working on bring up for a new board based on Freescales p2020.
>> I have a programmable FPGA as a PCIe device with a buffer I can
>> write to and from.
>> I want to test  performence for the PCIe bus. 
>> I encountered a problem while doing a DMA between the FPGA & DDR. 
>> The whole buffer  moves  to and from  the device  with out
>> mismatches but with low throughtput. 
>> The thing is that the buffer divided to many transactions of byte
>> size instead of transferring it in a burst. 
>> I must mention that even a buffer of word size, divided in to byte
>> transactions by the DMA (the core can read a word so it seems like
>> the DMA fault.
>> I tried to change the latency timer, max latency, min latency and
>> cache line in the configuration space of both sides of the pcie
>> bus. It didn't help.
>> Do you have an idea what can it be? 
>>
>> Thanks,
>> Natalie. 
>>     
>
> Assuming the P2020 has the usual 85xx-style DMA engine, you may have
> the Band Width Control cleared to 0. This 4-bit field (BWC) restricts
> the transfer size to 2^BWC bytes, for BWC=0,1,..0xa. 0xb-0xe are
> reserved. 0xf disables bandwidth sharing to allow uninterrupted
> transfers from each channel, so if you are using several channels
> one channel can completely lock out other channels. BWC=0x8 at reset
> (2^8 = 256 bytes). See the P2020 manual for more details.
>
> BWC is the field with mask 0x0f000000 in the MR (Master Reset)
> register for the channel (0, 1, 2, 3), at offset 0x100, 0x180, 0x200,
> 0x280 relative to the base of the DMA controller.
>
> Clive
>
>
>   
Hi, Thanks.
I changed the BWC but the transactions are still in a byte size instead 
of burst.
Do you have another idea?

Natalie.

--------------060300080805060605030409
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=us-ascii" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Jenkins, Clive wrote:
<blockquote
 cite="mid:929D3CED81F34E43887A393170D66FB90355C3CA@GBRSUN01MS002.eu.xerox.net"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">Hi, 

I'm working on bring up for a new board based on Freescales p2020.
I have a programmable FPGA as a PCIe device with a buffer I can
write to and from.
I want to test  performence for the PCIe bus. 
I encountered a problem while doing a DMA between the FPGA &amp; DDR. 
The whole buffer  moves  to and from  the device  with out
mismatches but with low throughtput. 
The thing is that the buffer divided to many transactions of byte
size instead of transferring it in a burst. 
I must mention that even a buffer of word size, divided in to byte
transactions by the DMA (the core can read a word so it seems like
the DMA fault.
I tried to change the latency timer, max latency, min latency and
cache line in the configuration space of both sides of the pcie
bus. It didn't help.
Do you have an idea what can it be? 

Thanks,
Natalie. 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Assuming the P2020 has the usual 85xx-style DMA engine, you may have
the Band Width Control cleared to 0. This 4-bit field (BWC) restricts
the transfer size to 2^BWC bytes, for BWC=0,1,..0xa. 0xb-0xe are
reserved. 0xf disables bandwidth sharing to allow uninterrupted
transfers from each channel, so if you are using several channels
one channel can completely lock out other channels. BWC=0x8 at reset
(2^8 = 256 bytes). See the P2020 manual for more details.

BWC is the field with mask 0x0f000000 in the MR (Master Reset)
register for the channel (0, 1, 2, 3), at offset 0x100, 0x180, 0x200,
0x280 relative to the base of the DMA controller.

Clive


  </pre>
</blockquote>
Hi, Thanks.<br>
I changed the BWC but&nbsp; the transactions are still in a byte size
instead of burst.<br>
Do you have another idea?<br>
<br>
Natalie. <br>
</body>
</html>

--------------060300080805060605030409--
