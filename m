Date: Mon, 26 Jun 2000 01:18:46 -0700
From: Matt Porter <mporter@mvista.com>
To: Kwansuk Kim <kskim@neowave.co.kr>
Cc: jinoung kim <jinoung@mail.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: omitted kernel sections
Message-ID: <20000626011846.A10313@cx258813-a.chnd1.az.home.com>
References: <384039193.961980819731.JavaMail.root@web538-mc.mail.com> <NEBBKFENMLEDKDHMEHPJKEMECAAA.kskim@neowave.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NEBBKFENMLEDKDHMEHPJKEMECAAA.kskim@neowave.co.kr>; from kskim@neowave.co.kr on Mon, Jun 26, 2000 at 03:43:35PM +0900
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 26, 2000 at 03:43:35PM +0900, Kwansuk Kim wrote:

<snip>

>   Warning:
>   'main' function not found in file: c:\860source\zvmlinux.initrd
>   Note: in startup routine. Enter STEP to go to High-level module.
                   CONTENTS, READONLY
>
> Why weren't .image, .initrd section loaded? Because they aren't elf format file?

Correct. An ELF loader isn't going to load non-ELF sections.

> What can I do? I haven't any idea.

Doesn't your BDM/JTAG probe have an option to load binary data into
memory?  I don't know its capabilities but you can load the zvmlinux
as above and let it strip the non-ELF sections off, then load the
vmlinux.gz and ramdisk.image.gz files into memory using using raw
binary transfer.  Depending on your probe's host software, you should
be able to script all this stuff.

An alternative is to get the Abatron BDI2000 BDM/JTAG probe
(http://www.abatron.ch) which understands the Linux image format.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
