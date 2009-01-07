Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 148D1DDFB3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 02:22:58 +1100 (EST)
Message-Id: <F325E4B5-0818-4AE3-B2AA-305D7D423838@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090107151942.GA2156@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/2] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Date: Wed, 7 Jan 2009 09:20:50 -0600
References: <20090105174050.GA30219@oksana.dev.rtsoft.ru>
	<20090105174155.GB8718@oksana.dev.rtsoft.ru>
	<20090107151942.GA2156@oksana.dev.rtsoft.ru>
Cc: Huang Changming <Chang-Ming.Huang@freescale.com>,
	Liu Dave <DaveLiu@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2009, at 9:19 AM, Anton Vorontsov wrote:

> On Mon, Jan 05, 2009 at 08:41:55PM +0300, Anton Vorontsov wrote:
>> This patch adds pcie nodes to the appropriate dts files, plus adds
>> some probing code for the boards.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
> [...]
>> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/ 
>> boot/dts/mpc8377_mds.dts
>> index 1d14d70..b12b9b4 100644
>> --- a/arch/powerpc/boot/dts/mpc8377_mds.dts
>> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> [...]
>> +	pci1: pcie@e0009000 {
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		#interrupt-cells = <1>;
>> +		device_type = "pci";
>> +		compatible = "fsl,mpc8377-pcie", "fsl,mpc8314-pcie";
>> +		reg = <0xe0009000 0x00001000>;
>> +		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
>> +		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
>
> I just noticed that for MPC837x boards FSL U-Boots set up cfg space
> at 0xa0000000, mem at 0xa8000000, and io at 0xb8000000. So the setup
> is differerent from MPC8315 boards (the ones I was testing this patch
> with).
>
> I'll send an update today, and will test it on MPC837x and MPC831x
> boards (but firstly need to finish and send PCI-E patches for the
> community U-Boots).

Can you also rebase on my latest next tree.  I pulled in Trent's 85xx/ 
86xx pci atmu cleanup and that might impact the patches applying.

- k
