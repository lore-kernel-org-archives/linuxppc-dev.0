Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <406CA75E.2070508@246tNt.com>
Date: Fri, 02 Apr 2004 01:35:58 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mpc5xxx support (Was: Re: Proposed Kconfig update patch for help
 text)
References: <67423B18-83E3-11D8-B6FB-000393DBC2E8@motorola.com> <20040401150211.90D85C10A4@atlas.denx.de> <20040401161622.GA26876@smtp.west.cox.net>
In-Reply-To: <20040401161622.GA26876@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

>For 2.6, I think one of the following options needs to be done.
>- Motorola code, cleaned up with input from the community (and the bits
>  Linux just doesn't need, left out).
>- Ignore the Motorola code, or since it's GPL (must be to be in the
>  kernel, so I'm just making the assumption here...) use it as a guide
>  for how things work to implement a clean Linux implementation of
>  the code. I know there's someone working on this (who pops up on
>  #mklinux on freenode from time to time) but I don't know how far
>  they've gotten.

I think you're referring to me ;)
What is done :
 - All the kconfig stuff to add options for MPC5xxx and the very low
level stuff like adding in cputable and so on, just to get it recognized.
 - A serial driver that provides a working console ( It still misses
some stuff like modem ctrl because I don't understand that one well )
 - The I2C driver is working ( I can access the on board eeprom of the
IceCube )
 - The USB driver is started however it's not functionnal yet.
Apparently there is a lot of endian issues. In the 2.4 core, they
modified the generic ohci driver with #ifdef #endif to  change the
access from little endian to big endian. But I don't like this solution
because I personnaly have on a custom board a OHCI on PCI and the built
in ports, so I need to find a 'clean' solution.
 - The ethernet code is in *VERY* early stages, I just have the global
arch and some ideas in my head on how to do it.

I'm planning on just ignoring the Motorola code since there apparently
are problem with it ( I though that the motorola update was planned for
mid-feb but ... ) , I was just gonna implement something very simple
that just does what it need for the linux drivers to work cleanly and
properly.

I've tried to write the code as cleany as possible, it uses the OCP
stuff that was on linux-2.5-ocp and also the generic dma stuff.

I can provide the patches on request, I just didn't published it because
I don't know where to ...

Also, for a couple of week, my work is 'paused' on this but since I
would need stuff like ethernet and I2S working for mid-may, I'll resume
my work on it ASAP.

Sylvain Munaut

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
