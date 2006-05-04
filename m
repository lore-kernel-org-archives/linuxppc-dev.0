Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa3.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 02DFE67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 05:45:57 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Where to look for CRAMFS
Date: Thu, 4 May 2006 21:46:39 +0200
References: <c359a7c00605031415o545d761cha3a3498c9454f3df@mail.gmail.com>
In-Reply-To: <c359a7c00605031415o545d761cha3a3498c9454f3df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605042146.39449.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Your flash is seen by the kernel as sequence of partitions, the size and 
offset of each partition (mtd partition) can be specified in two ways:

1) Tipically your board has a specific file in drivers/mtd/maps/yourboard.c 
that cares to partition the flash based on a static table that you provide.
2) The kernel can parse command line argument mtdparts (for example 
mtdparts=0:384k(boot),1024k(kern),2560k(cramfs),-(jffs2) ) to get the size of 
these partitions (this feature should be enabled when compiling the kernel)

Your cramfs will be written in one of this partitions and you can tell the 
kernel in which one it resides specifying cmd line argument "root" 

On my board I specified 4 partitions on my 8MB flash:
1) /dev/mtd0 -> 256kb for u-boot and its environment
2) /dev/mtd1 -> for the kernel
3) /dev/mtd2 -> for rootfs on a cramfs
4) /dev/mtd3 -> for a jffs2 filesystem

and therefore root=/dev/mtd2

If you want to load your software as a bundle of both kernel and cramfs and 
not separately you can also provide your package with an header containing 
the size of kernel and cramfs and instruct the kernel to partition the flash 
based on this header.

Bye,
Antonio.

On Wednesday 03 May 2006 23:15, Sauro Salomoni wrote:
> Greetings.
>
> I have an embedded board using i.MX21.
>
> What I want to know is: how do I tell the kernel where my CRAMFS root
> file system is?
> I mean, I put it in a specific memory address, but how does the kernel
> know where it is?!
>
> What happens here is that the kernel looks in some address and don't
> find the Magic Number CRAMFS stores in its own start address. I have a
> "bad magic number" msg because my root fs is somewhere else.
> Can anyone help me, plz?
>
> Thanks in advance.
>
>
> Sauro
> Engineer
> Z Tec
> www.ztec.com.br
> +55 61 3322-2544
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
