To: Sylvain Munaut <tnt@246tnt.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Feb 2004 19:33:05 +0100."
             <402A7561.7020105@246tNt.com>
Date: Wed, 11 Feb 2004 21:08:55 +0100
Message-Id: <20040211200900.8CAD6C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <402A7561.7020105@246tNt.com> you wrote:
>
> I've managed to compile U-Boot in a lowboot configuration :
>
> # make MPC5200LITE_LOWBOOT_config
> # <edit the config.mk of the board to set TEXTADDR>

No such edit is necessary!!!!

>  From there I download the freshly downloaded/compiled kernel image (
> from denx cvs linux_2_4_devel, configured with icecube_5200_config ) and
> try to boot it :
...
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line:

You don't pass any "bootargs" here? Where is your root filesystem?

See http://www.denx.de/twiki/bin/view/DULG/LinuxKernelArgs

> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> PCI: Cannot allocate resource region 0 of device 00:1a.0

This looks fishy. Is there a PCI card installed? Remove it!!


> But as you can see, it doesn't exactly do what I hoped ;) I was waiting
> for an "Unable to mount root" since I didn't put a rootfs yet but it
> crashes before that ( i think )

Did you modify the kernel configuration? Did you try  passing  useful
kernel boot arguments?

>  From what I can see in the System.map, the call backtrace are :
>
> c0003918 t run_init_process
> c00073cc T arch_kernel_thread
>
> Any comments ?

At the moment my guess is that you have a  PCI  problem.  Remove  any
cards, and retry using useful boot arguments.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A father doesn't destroy his children.
	-- Lt. Carolyn Palamas, "Who Mourns for Adonais?",
	   stardate 3468.1.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
