Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070627012206.GB11191@localhost.localdomain>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
	<20070627012206.GB11191@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <51DE9687-717E-4411-981F-EC03AC27D2F9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 07/15] [POWERPC] Removed remnants of bus_offset
Date: Tue, 26 Jun 2007 23:27:29 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2007, at 8:22 PM, David Gibson wrote:

> On Tue, Jun 26, 2007 at 08:16:37PM -0500, Kumar Gala wrote:
>> Removed the remants of bus_offset and use self_busno in the  
>> mv64x60 case
>> and use pci_assign_all_buses on 83xx/85xx.
>>
>> 83xx/85xx have multiple PHBs and the firmwares on these devices  
>> tend not
>> to handle topologies with P2P bridges well so we let Linux just  
>> reassign
>> the bus numbers to match.
>
> [snip]
>> diff --git a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci- 
>> bridge.h
>> index 2c2abda..70aab66 100644
>> --- a/include/asm-ppc/pci-bridge.h
>> +++ b/include/asm-ppc/pci-bridge.h
>> @@ -48,6 +48,7 @@ struct pci_controller {
>>  	int first_busno;
>>  	int last_busno;
>>  	int self_busno;
>> +	/* bus_offset is only used by ARCH=ppc */
>>  	int bus_offset;
>>
>>  	void __iomem *io_base_virt;
>
> Might be a good time to copy asm-ppc/pci-bridge.h to
> asm-powerpc/pci-bridge-32.h, yeah?

Yeah I'll look at something towards that, seeing as its one of the  
few headers we are including directly.

- k
