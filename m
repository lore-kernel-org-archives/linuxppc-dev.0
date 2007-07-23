Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 76E78DDE99
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 04:04:21 +1000 (EST)
Message-ID: <46A4ED9E.6010307@mvista.com>
Date: Mon, 23 Jul 2007 11:04:14 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 5/6 v2] 85xxCDS: Misc 8548 PCI Corrections.
References: <46A10578.6030609@mvista.com>	
	<DF1A9889-840C-4D19-9824-177DFEFE298F@kernel.crashing.org>	
	<46A133CF.6010407@mvista.com> <46A137C1.3080105@mvista.com>
	<1185185072.25737.1.camel@localhost.localdomain>
In-Reply-To: <1185185072.25737.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zang Roy-r61911 wrote:
> On Sat, 2007-07-21 at 06:31, Randy Vinson wrote:
> 
>> @@ -272,10 +272,10 @@ static void __init mpc85xx_cds_setup_arch(void)
>>         for (np = NULL; (np = of_find_node_by_type(np, "pci")) !=
>> NULL;) {
>>                 struct resource rsrc;
>>                 of_address_to_resource(np, 0, &rsrc);
>> -               if ((rsrc.start & 0xfffff) == 0x9000)
>> -                       fsl_add_bridge(np, 0);
>> -               else
>> +               if ((rsrc.start & 0xfffff) == 0x8000)
>>                         fsl_add_bridge(np, 1);
>> +               else
>> +                       fsl_add_bridge(np, 0);
> Why this is needed?
> For pcie@a000, fsl_add_bridge(np, 0)?
The old version of the code would call fsl_add_bridge(np, 1) for the
host bridges @8000 and @a000. When I tried it that way, it didn't work.
I don't think you can have 2 primary bridges.

Randy V.
