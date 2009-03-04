Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C299FDDFC8
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 03:47:45 +1100 (EST)
Message-Id: <2F7D2CFB-ABFA-425E-A349-3CB0970C110A@it-loops.com>
From: Michael Guntsche <mike@it-loops.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40903040757n3992fec4jb6f3b75396af2958@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
Date: Wed, 4 Mar 2009 17:47:39 +0100
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
	<c19541729a7d99548faadbabe5c7646c@localhost>
	<fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
	<9d38520266f15d80352d1554e63c1ce6@localhost>
	<a57485706bfc7aae2295acd743445312@localhost>
	<fa686aa40903030723p7d82edbfg5928adf9fe108b01@mail.gmail.com>
	<7AC161D8-83A8-4330-A2CF-3120F15D9038@it-loops.com>
	<fa686aa40903031310o4e0c0b2bnba0544012b0fb8bc@mail.gmail.com>
	<68DDAAA9-42AF-4E9C-907C-7D3269816184@it-loops.com>
	<fa686aa40903040757n3992fec4jb6f3b75396af2958@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 4, 2009, at 16:57, Grant Likely wrote:

> I need more information here.  What do you mean when you say "plain
> kernel".  What file from the build process do you use, and how do you
> boot it?
>
I build the kernel with

  make ARCH="powerpc" CROSS_COMPILE="powerpc-linux-gnu-" vmlinux

I take the kernel file and add a kernparm segment to it, where I  
specify my root directory.
Then I dd the file to the first partition of my CF card on the board.
As I said before, the bootloader looks at the first partition of the  
CF-card with a partition type of 0x27.
It expects a standard elf kernel to be in there and boots that.
That's all there is to it.

>
> I don't see a file named rbppc.c in the current kernel tree.
>
Sorry, this patch is not in mainline yet. You can find it at

http://cynigram.com/~nfontes/rb600/

It adds the pata driver, and the board specific stuff to the stock  
kernel.
The patch applies cleanly to 2.6.28.x but fails due to the gianfar  
related changes in the 2.6.29 release cycle.


>> You might be able to use of_attach_node() & prom_add_property() to
> modify the tree, but I've never done it myself.  Give it a try and
> tell me if it works.  :-)

I am trying to do it this way right now, when I was looking at them I  
was just wondering if those two functions were the correct ones to use.

As for backwards compatibility. All in-tree drivers were fixed as well  
to work with the new code so you cannot call this change breakage IMHO.
Off-tree code that is affected by it (like the one I am struggling  
with right now) just has to follow those changes. I do not think that  
the changes broke any
defined interface standards.

It would be a lot easier if the board would use uboot or cuboot in the  
first place, but there is no way I can change that, other thanflashing  
the boot-loader
itself NS I am neither brave nor knowledgeable enough to try that  
anyway.

Kind regards,
Michael
