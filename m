Return-Path: <benh@kernel.crashing.org>
Subject: Re: [MPC7448] machdep_calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <319b0ac50808180435o4a8e5bebr79f86e17ba2fb9af@mail.gmail.com>
References: <319b0ac50808180145r44a1b64fhd09c038ce45bb206@mail.gmail.com>
	<1219051624.28339.39.camel@pasglop>
	<319b0ac50808180422r504a012djb971bf80e819a6d2@mail.gmail.com>
	<319b0ac50808180435o4a8e5bebr79f86e17ba2fb9af@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 19 Aug 2008 07:11:14 +1000
Message-Id: <1219093874.28339.63.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-18 at 13:35 +0200, Sébastien Chrétien wrote:
> Can somebody explain me the aim of the function  "setup_arch" in the
> machine_call structure ?

This is where most of your arch code gets a chance to initialize before
most of the core is.

The generic core linux code calls the architecture setup_arch() very
early during boot, before most other initializations. The powerpc
architecture code performs various early initialisations there, on
32-bit that includes unflattening the device-tree, looking for legacy
serial ports, etc... and initializing bootmem.

It then calls ppc_md.setup_arch to give the platform a chance to perform
other platform specific early initializations before the rest of the
kernel starts initializing.

This is very early, ie, for memory allocation you can only use bootmem
for example. Interrupts haven't been initialized or switched on yet,
etc...

This is typically the place where your arch code will setup it's SMP ops
if any, will discover the fixed PCI host bridges, and initialize low
level HW components that need early initialization.

Ben.

> 2008/8/18, Sébastien Chrétien <sebastien.chretien.enseirb@gmail.com>:
>         Ok I am going to copy some examples.
>         
>         2008/8/18, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>                 On Mon, 2008-08-18 at 10:45 +0200, Sébastien Chrétien
>                 wrote:
>                 > Hello,
>                 >
>                 > I am developping a Linux for my PPC Board. I must
>                 write a
>                 > define_machine structure (marchdep_calls). Where can
>                 I find some
>                 > Information about functions of this structure ?
>                 
>                 
>                 It isn't well documented unfortunately. Best is to
>                 look at what others
>                 do... and then find your way through.
>                 
>                 I agree somebody should write dome doco one day ... in
>                 the meantime,
>                 feel free to ask questions here.
>                 
>                 Cheers,
>                 Ben.
>                 
>                 
>         
> 
