Date: Fri, 13 Jun 2003 10:48:01 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: Rakesh jagota <j.rakesh@gdatech.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with kernel loading in PPC IBM405 based board
In-Reply-To: <agl575xzx4jdocg.120620030900@gda-server>
Message-ID: <Pine.LNX.4.56.0306131039260.16768@mag.devdep.sysgo.de>
References: <f4sdizk28w071ij.110620032000@gda-server>
 <20030611151322.GA9573@dingdong.cryptoapps.com> <agl575xzx4jdocg.120620030900@gda-server>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 7 Nov 2003, Rakesh jagota wrote:
        ^^^^^^^^^^
You really should fix your date settings or apply for a role on Star
Trek. :-)

> I am using openBios code, but i m not able to load the zImage.treeboot using
> tftp or serial port. I am directly loading the zImage.treeboot using JTAG
> (RISCWATCH). But I am not able to find out the exact loaction where we should
> load the image and then from where should be start running the kernel. I have
> seen the stext loaction (0xc0000000). Can you guide me exactly where should I
> load this image.

0xc0000000 is the virtual address where the _kernel_ is linked and supposed
to run after the MMU has been turned on.

The image you are trying to load is a preloader with a compressed kernel
image attached to it. The preloader is an ELF file that runs at an entirely
different address. It will uncompress and run the kernel (@ address 0x0).

To answer your question: the zImage is linked to 0x00400000 (check
arch/ppc/boot/simple/Makefile, LD_ARGS). The OpenBIOS can load ELF images,
so just use it. I don't recommend direct downloading with RISCWATCH,
although this may work.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.de>
Software Engineering

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.de | www.elinos.com | www.osek.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
