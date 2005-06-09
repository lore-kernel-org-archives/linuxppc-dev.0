Return-Path: <kylo.ginsberg@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.205])
	by ozlabs.org (Postfix) with ESMTP id 9C64167B44
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 09:25:40 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so184563rne
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Jun 2005 16:25:39 -0700 (PDT)
Message-ID: <61cc712d050609162565d8bbfd@mail.gmail.com>
Date: Thu, 9 Jun 2005 16:25:39 -0700
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <815f92995891b6f6e5333d0658637788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <61cc712d0506091509527ee680@mail.gmail.com>
	<815f92995891b6f6e5333d0658637788@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mapping full 1 GB of memory on a Freescale Book E part
Reply-To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/9/05, Kumar Gala <kumar.gala@freescale.com> wrote:
>=20
> On Jun 9, 2005, at 5:09 PM, Kylo Ginsberg wrote:
> > I've modified fsl_booke_mmu.c to use a 4th TLB, thus mapping the full
> > 1 GB of memory.  However, I'm new to linux memory management, so I'd
> > appreciate any comments as to whether there are tradeoffs or dangers
> > here that I am missing.
>=20
> There is a danger here in that you have left no virtual address space
> for the kernel.  Since KERNEL_BASE is normally 0xc000_0000 + 1G ends up
> a the end of memory.  There for any devices that need virtual memory
> space would not have any to map out of.  I'm kinda amazed this works at
> all.  I'd be interested in seeing what a boot log looks like for this
> config.

Sorry, should have mentioned this in the first post.  I dropped
KERNEL_BASE to 0xa0000000 and upped LOWMEM_SIZE to 0x40000000.  So the
Advanced Setup portion of my .config reads:

#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=3Dy
CONFIG_HIGHMEM_START=3D0xfe000000
CONFIG_LOWMEM_SIZE_BOOL=3Dy
CONFIG_LOWMEM_SIZE=3D0x40000000
CONFIG_KERNEL_START_BOOL=3Dy
CONFIG_KERNEL_START=3D0xa0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=3D0x80000000
# CONFIG_BOOT_LOAD_BOOL is not set
CONFIG_BOOT_LOAD=3D0x00800000

and under Platform Options:

# CONFIG_HIGHMEM is not set

> The way to handle this is by enabling HIGHMEM support in the kernel or
> dropping the KERNEL_START in the config.  I'm haven't ever tried to
> drop KERNEL_START so your milage may very on what if anything that will
> break.

So, an alternative would be to leave fsl_booke_mmu.c untouched, revert
my KERNEL_START/LOWMEM mods, and instead enable HIGHMEM?  Setting
HIGHMEM_START to ...? Will that entail more TLB thrashing?

Kylo
