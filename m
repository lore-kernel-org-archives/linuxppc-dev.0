Date: Thu, 19 Oct 2000 14:16:35 +0200 (CEST)
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Alois Fertl <alois_fertl@talknet.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: initial console
In-Reply-To: <39EE00CA.BE9889DC@talknet.de>
Message-ID: <Pine.LNX.4.21.0010191410170.8107-100000@ipnpcu5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Oct 2000, Alois Fertl wrote:
>
> The problem you are seeing here is probably prep_init in prep_setup.c
> not copying the arguments passed by the boot loader into the kernels command
> line. Your root=/dev/sda5 is probably ignored.
> Look at your early log messages during boot. There should be a line
> "Boot arguments: ..." telling you those things seen by the kernel.
Indeed, The kernel argument I give is :
root=/dev/sda5
and during the boot when I look more closely :
PReP architecture
Boot arguments: /dev/sda1

> In case the arguments aren't as you typed them, try putting the following
> lines at the beginning of prep_init:
>
> +       if (r6) {
> +               *(char *)(r7 + KERNELBASE) = 0;
> +               strcpy(cmd_line, (char *)(r6 + KERNELBASE));
> +       }
Ok, this is fine my kernel boots ! Thank you very much.
> What hardware is this running on? If it is Motorola VME this failure is only
> the starting point and other trouble will follow. There are additional fixes
> but I can't verify them against a working source at the moment. test9 and
> test10
> from fmlabs currently both panic during init as soon as the process starts
> using the hard drive (this is on a PowerStack).

I have a MVME2303 from motorola diskless + a PMC with a 53c895 pci board
for my disk. With the 2.2.17 kernel all works well.
And now with the latest fsmlabs + your hack all function !

O+ xavier

33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
