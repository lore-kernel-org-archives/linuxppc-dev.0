Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 8D8EADDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 06:19:41 +1100 (EST)
Received: by qyk14 with SMTP id 14so4344078qyk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Dec 2008 11:19:38 -0800 (PST)
Message-ID: <c384c5ea0812011119o97adf68l1546c96d5a6696a8@mail.gmail.com>
Date: Mon, 1 Dec 2008 20:19:38 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: ppc4xx: u-boot sees PCIe endpoint, linux does not.
In-Reply-To: <1228119152.7356.118.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0811280450t3e199da6s1fcdf903f63f9622@mail.gmail.com>
	<1228119152.7356.118.camel@pasglop>
Cc: u-boot@lists.denx.de, Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

On Mon, Dec 1, 2008 at 9:12 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2008-11-28 at 13:50 +0100, Leon Woestenberg wrote:
>>
>> AMCC PPC460EX canyonlands board with an FPGA PCIe end point:
>>
>> u-boot sees the end point, but Linux does not:
>>
>> U-Boot 1.3.3-00249-ga524e11 (Jun 30 2008 - 16:05:51)
>> CPU:   AMCC PowerPC 460EX Rev. A at 800 MHz (PLB=200, OPB=100, EBC=100 MHz)
>> <...>
>> Board: Canyonlands - AMCC PPC460EX Evaluation Board, 2*PCIe, Rev. 16
>> <...>
>> PCIE1: successfully set as root-complex
>>         02  00  2071  2071  00ff  00
>>
>> Now, if I re-program the end-point FPGA during the u-boot boot
>> time-out, Linux will recognize the end-point.
>>
> It's possible that either the reset in between goes bonkers or something
> else causes your FPGA to stop responding. It looks like a programming
> problem with the FPGA to me.
>
I have verified that the end point does not receive any kind of reset.

Also, this problem only happens on the Canyonlands board; on x86 and
powerpc MPC8315E it remains properly working after soft/hard resets,
u-boot init etc.

Could it be u-boot overwrites a too large payload into the config
space or something similar, which makes subsequent accesses fail?

Regards,
-- 
Leon
