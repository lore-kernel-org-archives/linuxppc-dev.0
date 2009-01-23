Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 877F7DE061
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 06:50:33 +1100 (EST)
Message-Id: <040FB934-E848-4400-A77F-69E90F4AE495@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michele.pallaro@alcatel-lucent.it
In-Reply-To: <1232733128.6271.19.camel@ITVIMNXI34497>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Non-contiguous physical memory
Date: Fri, 23 Jan 2009 13:50:16 -0600
References: <bc81dc640901210718l18edbc6ehffbb6709c0daac3f@mail.gmail.com>
	<3725D962-7F25-4A77-8D87-9BBA0A78D406@kernel.crashing.org>
	<1232733128.6271.19.camel@ITVIMNXI34497>
Cc: linuxppc-dev@ozlabs.org, Aaron Pace <kodiakuppercut@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 23, 2009, at 11:52 AM, Michele Pallaro wrote:

> Hello,
> 	I have a similar problem with my custom board CPU mpc8548 (E500V2)  
> with
> 4Gbytes of RAM
>
> 	  0x0000_0000 --    0x7FFF_FFFF  2Gbytes
> 	0x1_0000_0000 -- 0x1_7FFF_FFFF   2Gbytes
>
> I Enable the option PHYS_64BIT, and set in dts
>
> memory {
>                #address-cells = <2>;
>                #size-cells = <1>;
>                device_type = "memory";
>                reg = <00000000 00000000 00000000 7FFFFFFF
>                       00000001 00000000 00000000 7FFFFFFF>;
>        };
>
> But the kernel can see just 2Gbytes of memory.
> How the kernel can see the other 2Gbytes ?
>
> 	Michele

This should be:

reg = < 0x00000000 0x00000000 0x00000000 0x80000000
         0x00000001 0x00000000 0x00000000 0x80000000 >;

Its a start, size pair.

- k
