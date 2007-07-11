Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0925DDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:57:19 +1000 (EST)
In-Reply-To: <DB462F87-151E-4F21-80CF-209326FCEB67@kernel.crashing.org>
References: <1184082728.20129.187.camel@localhost.localdomain>
	<963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
	<DB462F87-151E-4F21-80CF-209326FCEB67@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <503D28B7-4D60-4507-9D66-BD59C0E59951@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
Date: Wed, 11 Jul 2007 12:57:05 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +			compatible = "fsl,mpc86xx-pciex","86xx";
>>
>> And "xx" again.  Aren't the 85- and 86- PCIe controllers
>> compatible, btw?
>
> They are, but we need to distinguish between 83xx, 85xx, and 86xx  
> pci, pciex, pci-x controllers.

Sure, but if 85xx-pcie and 86xx-pcie are compatible, the OS
driver can match on the same "compatible" entry for both.
Just choose one -- "fsl,8641-pcie" or something.  It is a
good idea to put the exact name of the controller on the
board in the first "compatible" entry in case it is found
later that some specific model needs a workaround or some
other special treatment, but in general, everything can
just use the generic "grandfather" model to match on.


Segher
