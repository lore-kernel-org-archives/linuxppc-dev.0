Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 0B52167A73
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Feb 2005 18:37:37 +1100 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 090E24067
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Feb 2005 08:37:39 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 21 Feb 2005 08:37:30 +0100
References: <EF9B29C78F41FA488927FCBC7750AF0E011DA65E@hyd-mdp-msg.wipro.com>
In-Reply-To: <EF9B29C78F41FA488927FCBC7750AF0E011DA65E@hyd-mdp-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502210837.31174.david.jander@protonic.nl>
Subject: Re: Freeing unused kernel memory: 56k init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sunday 20 February 2005 16:25, srinivas.surabhi@wipro.com wrote:
> When I tried to debug for the reason of  "Freeing unused kernel memory:
> 56k init " hang problem  the following is the printk outputs...
>
> Entering kernel_read
>
> Entering elf_map
>
> map_addr was 0x30026000

Heh? Weired address. I'd expect something above 0xc0000000

> Failed due to bad address

No wonder....

> >From the above can anything be concluded ?
>
> One more doubt was, is it mandatory that the Virtual memory has to
> enabled while building the Mounta Vista linux kernel ? Why because there
> was an option to enable the kernel base address and if it is enabled it
> asks for what is the address for the Kernel Virtual base address? If I
> give 0x0 it works otherwise the Kernel itself is not at all booting.

Ok, don't say no more! Do not ever change that address unless you know exactly 
what you are doing. It should be 0xc0000000 usually.
If the kernel doesn't boot, something else is wrong.
The linux kernel uses virtual memory, that's why it needs an MMU for instance. 
That way, the memory the kernel uses and runs in is always mapped at address 
0xc0000000.

> Till the statement "Freeing unused kernel memory: 56k init"  is coming
> only if and if the 0x0 was given for the kernel virtual base address.

That's actually pretty funny. I'd never thought about doing such an experiment 
and expecting it to do something :-)

Greetings,

-- 
David Jander
Protonic Holland.
