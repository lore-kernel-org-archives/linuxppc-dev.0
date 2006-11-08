Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B393767CE6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 10:57:45 +1100 (EST)
In-Reply-To: <44B423FD-D411-4C80-A4BC-F74AFC942BFD@kernel.crashing.org>
References: <Pine.LNX.4.61.0611071707520.6936@ld0175-tx32.am.freescale.net>
	<44B423FD-D411-4C80-A4BC-F74AFC942BFD@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <46D6DE10-2A73-4319-B226-7CDF0EDF6839@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Changed gianfar device tree definition to make it more
	flexible
Date: Wed, 8 Nov 2006 17:57:35 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 8, 2006, at 00:28, Kumar Gala wrote:

>>
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
>> Documentation/powerpc/booting-without-of.txt
>> index 27b457c..bb1a402 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -1193,6 +1193,7 @@ platforms are moved over to use the flat
>>
>>      - device_type : Should be "network"
>>      - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
>> +      (This is deprecated in favor of the feature bits)
>>      - compatible : Should be "gianfar"
>>      - reg : Offset and length of the register set for the device
>>      - mac-address : List of bytes representing the ethernet  
>> address of
>> @@ -1206,6 +1207,30 @@ platforms are moved over to use the flat
>>        services interrupts for this device.
>>      - phy-handle : The phandle for the PHY connected to this  
>> ethernet
>>        controller.
>> +    - interface : The interface this ethernet is using.  Current  
>> options are:
>> +        GMII, MII, RGMII, SGMII, TBI, RMII, and RTBI
>> +
>> +  Optional properties (features):
>> +    - gigabit : Indicates support for 1000 Mbit operation
>> +    - coalescing : Indicates support for interrupt coalescing
>> +    - rmon : Indicates support for RMON-style counters
>> +    - checksumming : Indicates support for hardware TCP/UDP  
>> checksumming
>> +    - vlan-insertion : Indicates support for hardware vlan header  
>> insertion
>> +    - extended-hash : Indicates support for using the Individual
>> +        Address Hash registers to extend the Group Address Hash  
>> registers
>> +    - padding : Indicates support for padding between the FCB and
>> +        the frame
>> +    - filer : Indicates support for the Filer
>
> What exactly does parseL2, L3, L4 actually mean? (what feature is  
> this)


It's just fine-grained feature control for the parser.  Someone here  
suggested that I might want separate bits for L2, L3, and L4  
functionality.  It cost me nothing to add them, so I did.  Currently,  
the Linux driver does nothing to support them.


>
>> +    - parseL2 : Indicates support for parsing L2 headers
>> +    - parseL3 : Indicates support for parsing L3 headers
>> +    - parseL4 : Indicates support for parsing L4 headers
>> +    - multi-queue : Indicates support for sending and receiving
>> +      into multiple queues
>> +
>
> Shouldn't we have a flag for L2 stashing as well? (83xx TSECs don't  
> support it since no L2 on the parts :)


Yes, good.  I will add one for stashing.  And locking.
