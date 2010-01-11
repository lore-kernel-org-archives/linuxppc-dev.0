Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B560AB7C27
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 09:48:28 +1100 (EST)
Message-ID: <4B4BAAC0.4010300@embedded-sol.com>
Date: Tue, 12 Jan 2010 00:48:32 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI-PCI bridge scanning broken on 460EX
References: <4B388D9D.7010404@embedded-sol.com>	
	<1262584539.2173.335.camel@pasglop>	<4B41ADF1.1000400@embedded-sol.com>	
	<4B49CE8A.7000609@embedded-sol.com>	<1263155906.724.2.camel@pasglop>	
	<4B4A4307.5050704@embedded-sol.com>	<1263159117.724.15.camel@pasglop>	
	<4CD35CD1F8085945B597F80EEC89421303B8AD0C@exc01.bk.prodrive.nl>	
	<4B4B1027.4020708@embedded-sol.com>
	<4B4B55CF.9000707@embedded-sol.com>
	<1263243199.724.146.camel@pasglop>
In-Reply-To: <1263243199.724.146.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Stef van Os <stef.van.os@Prodrive.nl>, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Ben

Benjamin Herrenschmidt wrote:
>> It seems I was wrong. I've manually applied the patch at the wrong 
>> place. After patching the correct function
>> I'm not getting hard resets any more, which is a great improvement ! 
>> Thanks a lot, I really appreciate your help !
>>     
>
> This is somewhat funny... I wonder how it would have managed to find
> anything behind the root complex P2P bridge with broken type 1 cycles...
> very very strange.
>   

Maybe because the bus behind root P2P bridge is bus 0, and type 1 cycles are
needed for bus numbers greater than 0. That's what 460EX manual says.
>   
>> Unfortunately not all problems are gone. PLX is now identified 
>> correctly, but device behind it is not detected,
>> although u-boot detects it correctly. See below.
>>     
>
> You have removed all your changes to that code right ?
>   

Yes, I've removed all experimental changes.

> Also the log still looks weird:
>
>   
>> pci 0000:01:02.0: scanning behind bridge, config 010100, pass 0
>> pci 0000:01:02.0: bus configuration invalid, reconfiguring
>> pci 0000:01:02.0: scanning behind bridge, config 010100, pass 1
>> pci_bus 0000:01: bus scan returning with max=01
>> pci 0000:00:02.0: scanning behind bridge, config 010100, pass 1
>> pci_bus 0000:00: bus scan returning with max=01
>>     
>
> Unless you left some experimental changes in, the above isn't right, the
> "config" value should have changed due to the write of ~ffffff to it
>   

You are correct, the log is from older version, without Stef's fix. I 
don't have access to a
system with devices behind PLX, and the guy who did the testing used 
wrong kernel.
I'll make sure he uses the correct one and get back to you. Maybe 
everything works after all :)
I'm really sorry for confusion.

Felix.
