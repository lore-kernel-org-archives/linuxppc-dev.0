From: Tibor Pausz <pausz@stud.uni-frankfurt.de>
To: Chas Williams <chas@cmf.nrl.navy.mil>,
        jingai <jingai@floatingpenguins.com>
Cc: debian-powerpc <debian-powerpc@lists.debian.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of PCI-PCI bridge on UMAX S900
Date: Thu, 4 Jan 2001 20:19:39 +0100
Message-Id: <19341129125123.15815@mail.server.uni-frankfurt.de>
In-Reply-To: <200012291509.eBTF9qZ11058@ginger.cmf.nrl.navy.mil>
References: <200012291509.eBTF9qZ11058@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fre, 29. Dez 2000, Chas Williams <chas@cmf.nrl.navy.mil> wrote:

>In message <200012290016.SAA25126@lists.linuxppc.org>,jingai writes:
>>Doh!  I didn't even think to check if the second get_property() call
>>was returning > 0.. this fixes it!  Thanks bunches for spotting that!
>
>it seems like someone was confused about the meaning of the 'interrupts'
>property when they wrote prom.c.  its basically the number of interrupts
>supported by this pci device.  interpret_dbdma_props() also has the
>same confusion, so the following would be a more complete patch to
>prom.c.  note that it checks to see if a pci node has an interrupt
>property before assigning one, otherwise devices on the far side of
>a pci bridge (that shares interrupts) would be assigned interrupts
>when they dont need them.

Today I tried your patch. Well, I breaks the hole interrupt stuff.
Now, even Mesh has trouble with interrupts (kernel crash), the
console=ttyS0 doesn't work so no output from the booting ...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
