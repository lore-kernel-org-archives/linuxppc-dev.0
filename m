To: Amit.Lubovsky@infineon.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX860 loading denx kernel image with EPPC-Bug 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 24 Dec 2003 11:36:54 +0100."
             <AD2F581BD7340A4C908AF1AFB066EA3B0E4977@ntah901e.savan.com>
Date: Fri, 26 Dec 2003 18:37:51 +0100
Message-Id: <20031226173756.2F57AC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Amit,

in message <AD2F581BD7340A4C908AF1AFB066EA3B0E4977@ntah901e.savan.com> you wrote:
>
> I try to load linux kernel 2.4.20 from denx (vmlinux) to MBX860 board
> with the on board boot loader (EPPC-Bug) without success and get
> the following:
...
> Any idea what am I doing wrong?

You are using the wrong boot loader and/or the wrong image.

vmlinux is just the Linux kernel -  it  expects  to  receive  certain
parameters  in  registers,  and boot arameters in a command line. The
EPPCBug boot loader does not know anything about Linux, so the kernel
crashes because of missing / bad parameters.

Either you will have to use a boot loader that knows about Linux  and
the  parameters  needed  to boot it (like U-Boot), or you could use a
wrapper (bootstrap loader) around the Linux kernel like what you  get
when you use the arch/ppc/boot/images/zImage file.

Best regards, and Happy Hollidays,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"We don't have to protect the environment -- the Second Coming is  at
hand."                                                   - James Watt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
