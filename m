Return-Path: <B31939@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 265BC2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 15:07:22 +1000 (EST)
Received: from mail6-co9 (localhost [127.0.0.1])	by mail6-co9-R.bigfish.com
 (Postfix) with ESMTP id D92824C0283	for <linuxppc-dev@lists.ozlabs.org>; Mon,
 17 Jun 2013 05:07:18 +0000 (UTC)
Received: from CO9EHSMHS028.bigfish.com (unknown [10.236.132.239])	by
 mail6-co9.bigfish.com (Postfix) with ESMTP id 2263CA0053	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 05:07:17 +0000 (UTC)
Message-ID: <51BE999D.2080207@freescale.com>
Date: Mon, 17 Jun 2013 13:07:41 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/5] powerpc/dts: update MSI bindings doc for MPIC v4.3
References: <1371247589.2996.15@snotra>
In-Reply-To: <1371247589.2996.15@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Soctt,

please see my comments.

On 06/15/2013 06:06 AM, Scott Wood wrote:
> On 06/14/2013 02:15:57 AM, Minghuan Lian wrote:
>> Add compatible "fsl,mpic-msi-v4.3" for MPIC v4.3. MPIC v4.3 contains
>> MSIIR and MSIIR1. MSIIR supports 8 MSI registers and MSIIR1 supports
>> 16 MSI registers, but uses different IBS and SRS shift. When using
>> MSIR1, the interrupt number is not consecutive. It is hard to use
>> 'msi-available-ranges' to describe the ranges of the available
>> interrupt and the ranges are related to the application, rather than
>> the description of the hardware. this patch also removes
>> 'msi-available-ranges' property.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> ---
>>  .../devicetree/bindings/powerpc/fsl/msi-pic.txt    | 49 
>> ++++++++++------------
>>  1 file changed, 22 insertions(+), 27 deletions(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt 
>> b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
>> index 5693877..e851e93 100644
>> --- a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
>> @@ -1,26 +1,23 @@
>>  * Freescale MSI interrupt controller
>>
>>  Required properties:
>> -- compatible : compatible list, contains 2 entries,
>> +- compatible : compatible list, may contains one or two entries,
>>    first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, 
>> mpc8572,
>> -  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" depending on
>> -  the parent type.
>> +  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" or
>> +  "fsl,mpic-msi-v4.3" depending on the parent type and version. If mpic
>> +  version is 4.3, the number of MSI registers is increased to 16, 
>> MSIIR1 is
>> +  provided to access these 16 registers, compatible "fsl,mpic-msi-v4.3"
>> +  should be used.
>
> Why "one or two"?  What does it look like in the case where there's 
> just one?
>
[Minghuan] The original doc said 'contains 2 entries', but I notcie 
pq3-mpic.dtsi and qoriq-mpic.dtsi have only one entry "fsl,mpic-msi", do 
not have "fsl,CHIP-msi".
for example:
mpc8610_hpcd.dts: compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";
fsl/qoriq-mpic.dtsi:  compatible = "fsl,mpic-msi"

Maybe I should say " For some platforms, "fsl,CHIP-msi' is optional."

>>  - reg : It may contain one or two regions. The first region should 
>> contain
>>    the address and the length of the shared message interrupt 
>> register set.
>> -  The second region should contain the address of aliased MSIIR 
>> register for
>> -  platforms that have such an alias.
>> -
>> -- msi-available-ranges: use <start count> style section to define which
>> -  msi interrupt can be used in the 256 msi interrupts. This property is
>> -  optional, without this, all the 256 MSI interrupts can be used.
>> -  Each available range must begin and end on a multiple of 32 (i.e.
>> -  no splitting an individual MSI register or the associated PIC 
>> interrupt).
>> +  The second region should contain the address of aliased MSIIR or 
>> MSIIR1
>> +  register for platforms that have such an alias, if using MSIIR1, 
>> the second
>> +  region must be added because different MSI group has different 
>> MSIRR1 offset.
>
> Why are you removing msi-available-ranges?  It's not valid for MPIC 
> v4.3, but it's still valid for older MPICs.  It should move to the 
> optional section, though.
[Minghuan] Because I would like to add kernel parameter 'msiregs' 
instead of "msi-available-ranges", for all the MPICs, we will have a 
uniform way to configure
For older MPICs, we can use "msi-available-ranges" and "msiregs", but 
for MPCI4.3 we can only use "msiregs", this may easily lead to confusion.
>>  - interrupts : each one of the interrupts here is one entry per 32 
>> MSIs,
>>    and routed to the host interrupt controller. the interrupts should
>> -  be set as edge sensitive.  If msi-available-ranges is present, only
>> -  the interrupts that correspond to available ranges shall be present.
>> +  be set as edge sensitive.
>>
>>  - interrupt-parent: the phandle for the interrupt controller
>>    that services interrupts for this device. for 83xx cpu, the 
>> interrupts
>> @@ -39,20 +36,18 @@ Optional properties:
>>
>>  Example:
>>      msi@41600 {
>> -        compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";
>> -        reg = <0x41600 0x80>;
>> -        msi-available-ranges = <0 0x100>;
>> -        interrupts = <
>> -            0xe0 0
>> -            0xe1 0
>> -            0xe2 0
>> -            0xe3 0
>> -            0xe4 0
>> -            0xe5 0
>> -            0xe6 0
>> -            0xe7 0>;
>> -        interrupt-parent = <&mpic>;
>> -    };
>> +    compatible = "fsl,mpic-msi";
>> +    reg = <0x41600 0x200 0x44140 4>;
>
> Why 0x200?
>
[Minghuan] The offsets of the MSIA registers are from 0x41600 to 
0x417ff, and the size is 0x200.
offset 0x41600-0x4170 are MSIIRA1-7.
0x41720 is MSISRA,
0x41750 is MSIIR.
The others are reserved.

-Scott
