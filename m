Message-ID: <3EC28019.8030402@mvista.com>
Date: Wed, 14 May 2003 10:42:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: dong in kang <dkang@east.isi.edu>
Cc: "'Linux PPC Embedded mailing list'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: boot PPClinux on Sandpoint with Atlimus board
References: <000401c31a20$3ddee7c0$45a97241@Minjoo>
In-Reply-To: <000401c31a20$3ddee7c0$45a97241@Minjoo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dong in kang wrote:

> Hello,
>
> I'm trying to boot PPClinux on Sandpoint with Altimux board (using MPC755
>and MPC107 bridge chip).
>I don't use DINK32. I use Codewarrior v.6.0 with BDI 2000.
>I'm trying to load the zImage.initrd on the SDRAM and directly run the
>kernel without using bootloader.
>I use MontaVista's hardhat linux. I configured the linux to work for
>Sandpoint.
>I use BDI2000 to initialize the bridge chip, which are less than 10
>instructions long.
>After initialization, I can read/write sdram.
>And then I upload zImage.initrd at 0x800000.
>It successfully decompresses the kernel and jump to 0x00000000.
>>From there it works fine until it enables MMU and jump to 0xC0000000.
>When it jumps to 0xC0000000, it only finds garbage there. All FFs at
>0xC0000000.
>
Well, you're glossing over a lot of steps any of which could be causing
you problems.  However, to address why you don't see anything at 0xc0000000:

You're looking there with your BDI, right?  If so, that's because
0xc0000000 is a virtual address and the 'md' telnet cmd needs a physical
address.  Try 'md 0'.  If things look okay.  Go into your System.map
file, find 'log_buf' and dump the data at the associated address
(converting the 0xCyyyyyyy to 0x0yyyyyyy).  You should see the printk
output that has accumulated (but not been dumped b/c you haven't reached
console_init() yet).  If you're lucky, you'll see the panic msg/reg dump
that will give you a clue as to what went wrong.

>I checked the register MSR and BATs. They look OK. But address translation
>doesn't seem to occur.
>I think I need to do more initialization before I upload zImage.initrd and
>run it.
>Could anybody tell me what should i do?
>
> Thanks,
>
> Dong-In Kang
>
>
Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
