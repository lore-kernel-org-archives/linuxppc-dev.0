Return-Path: <lagrange@fr.oleane.com>
Received: from relay01s.ntr.oleane.net (unknown [194.2.3.145])
	by ozlabs.org (Postfix) with ESMTP id 431322BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jan 2005 04:51:15 +1100 (EST)
Received: from smtp3.clb.oleane.net (smtp3.clb.oleane.net [213.56.31.19])
	by relay01s.ntr.oleane.net with ESMTP id j06HoV6Y001258
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Jan 2005 18:50:40 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Eugene Surovegin'" <ebs@ebshome.net>
Date: Thu, 6 Jan 2005 18:42:50 +0100
Message-ID: <000001c4f417$25e84260$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050105174154.GB14485@gate.ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8260 strange virtual addresses returned by kmalloc()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Eugene

My PAGE_OFFSET is defined as follow :
#define PAGE_OFFSET  CONFIG_KERNEL_START     in
./linux/include/asm-ppc/page.h
#define CONFIG_KERNEL_START (0xc0000000)     in
./linux/include/linux/autoconf.h

After reading kmalloc manual pages, I am in doubt.
My call is like
if ((tmpbuffer = kmalloc(128 * 1024, GFP_KERNEL)) == NULL){
    return(1);
}

This is the first time, I kmallocate a 128KB buffer which seems to be the
max
contiguous memory space which can be allocated.
Is it true on PPC ? Some PPC drivers seems to only allocate multiple
PAGE_SIZE (4KB) buffers.

My allocated buffer is intended to be used for DMA accesses.
Must I add the GFP_DMA flag to force the kmalloc to use contiguous memory ?

The Linux code for vmalloc is based on successive kmalloc calls, but I don't
know
what the kmalloc do when the desired size is greater than the PAGE_SIZE.

What is the right way to allocate big (128KB ???) DMA buffers ?
The manual pages say "Only for DMA kmalloc or __get_dma_pages() has to be
used"

The global variable is well in the loaded module.
OK, I use a kmalloc for the buffer instead of using the global variable.

Thanks for your ideas.
Laurent

-----Message d'origine-----
De : Eugene Surovegin [mailto:ebs@ebshome.net]
Envoye : mer. 5 janvier 2005 18:42
A : Laurent Lagrange
Cc : linuxppc-embedded@ozlabs.org
Objet : Re: MPC8260 strange virtual addresses returned by kmalloc()


On Wed, Jan 05, 2005 at 02:38:12PM +0100, Laurent Lagrange wrote:
> Hi and Happy New Year to all,
>
> I use a Linux 2.4.25 kernel on a MPC8260 custom board with 128MB of RAM.
> PCI is activated and my drivers are loaded as modules.
> The RAM is mapped at 0xC0000000 as usual.
>
> On MPC8XX I used kmalloc and iopa to get the physical addresses of the
> allocated buffers.
> On MPC82XX I used kmalloc and __pa for the same thing and it worked fine
> with previous kernel.
>
> But now, when I want to use kmalloc, I get addresses like 0xC9xxxxxx.
> The __pa gives me physical addresses 0x09xxxxxx which are out of my
physical
> RAM.
> I tried old iopa function and got some real physical addresses and the
> module works.
> The virt_to_bus gives me too addresses like  0x09xxxxxx
> (ie substract kernel base address 0xC0000000 as usual).
>
> I don't understand why I get virtual addresses which seem to be out of my
> memory and why it runs.

Yeah, this looks strange, please, check that this address is really
from kmalloc and not from vmalloc.

Also, check that PAGE_OFFSET is really 0xc000'0000.

> More, I have a global variable which is a little buffer. It is also mapped
> at a 0xC9xxxxxx address.

Is this global variable in the loaded module? If yes, this is normal,
because modules are loaded into vmalloced space and you cannot use
__pa for such addresses.

--
Eugene
