Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.101.113.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 466A867A79
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Feb 2005 20:48:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 21 Feb 2005 15:18:12 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA684@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <david.jander@protonic.nl>, <linuxppc-embedded@ozlabs.org>
Subject: mkImage -e option for 4MB virtual entry point address of vmlinux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


In the last lines of the build which contains the below

ppc_82xx-ld -T ../ld.script -Ttext 0x00400000 -Bstatic -o zvmlinux
head.o

means that the entry address is 0x400000 ( 4MB) . Does it mean that the
while making mkImage for the kernel the -e option should be given
0x400000? And the load address option should also be the same for linux
kernel image or Is it ok if the load address is 0x0 address?



Thanks & Regards
Surabhi Srinivas

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of David Jander
Sent: Monday, February 21, 2005 1:08 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: Freeing unused kernel memory: 56k init

On Sunday 20 February 2005 16:25, srinivas.surabhi@wipro.com wrote:
> When I tried to debug for the reason of  "Freeing unused kernel
memory:
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
> enabled while building the Mounta Vista linux kernel ? Why because
there
> was an option to enable the kernel base address and if it is enabled
it
> asks for what is the address for the Kernel Virtual base address? If I
> give 0x0 it works otherwise the Kernel itself is not at all booting.

Ok, don't say no more! Do not ever change that address unless you know
exactly=0D
what you are doing. It should be 0xc0000000 usually.
If the kernel doesn't boot, something else is wrong.
The linux kernel uses virtual memory, that's why it needs an MMU for
instance.=0D
That way, the memory the kernel uses and runs in is always mapped at
address=0D
0xc0000000.

> Till the statement "Freeing unused kernel memory: 56k init"  is coming
> only if and if the 0x0 was given for the kernel virtual base address.

That's actually pretty funny. I'd never thought about doing such an
experiment=0D
and expecting it to do something :-)

Greetings,

--=0D
David Jander
Protonic Holland.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
