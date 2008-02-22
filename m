Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id DDCB1DDF0A
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 00:01:23 +1100 (EST)
Date: Fri, 22 Feb 2008 13:01:21 +0000
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH] [POWERPC] 8xx: timebase frequency should not depend on
	bus-frequency
Message-ID: <20080222130121.1794a06b@neuromancer.mindspace>
In-Reply-To: <20080221234136.GA3545@zarina>
References: <20080221194508.GA12896@localhost.localdomain>
	<47BDD587.9060206@freescale.com>
	<20080221195918.GA14636@localhost.localdomain>
	<47BDD9E2.5050007@freescale.com>
	<20080221211343.GA24786@localhost.localdomain>
	<47BDEB0A.80706@freescale.com> <20080221234136.GA3545@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Feb 2008 02:41:36 +0300
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> On Thu, Feb 21, 2008 at 03:20:10PM -0600, Scott Wood wrote:
> > Anton Vorontsov wrote:
> > > On Thu, Feb 21, 2008 at 02:06:58PM -0600, Scott Wood wrote:
> > >> Current u-boots don't support device trees at all on 8xx.
> > > 
> > > Yes, vanilla u-boots. I assume many of us use some u-boot hacks to
> > > actually boot with the device tree (no, not cuboots)... ;-)
> > 
> > Fine, but don't expect misbehavior from out-of-tree u-boots to be used 
> > as justification for the kernel ignoring device tree content. :-)
> 
> You got me wrong, maybe I wasn't clear enough: it wasn't justification of
> any kind. It's was just a remark regarding u-boot still not supporting
> fdt for 8xx (20 lines of code we're lazy to cleanup, write annotation
> to the patch and send it ;-).

Hey Anton.

I won't make any comment on what Linux should do with an older version of
u-boot.

However, just to let you know, there are a couple of patches to do a more modern
fdt on 8xx- sent to the u-boot list in the last <= ~ 10 days.

Using those patches - which incorporate the changes suggested by Scott re:
get_tbclk()- the timebase-frequency field is indeed stuffed with u-boot's
get_tbclk(); - see below.

u-boot/cpu/mpc8xx/fdt.c

void ft_cpu_setup(void *blob, bd_t *bd)
{
        do_fixup_by_prop_u32(blob, "device_type", "cpu", 4,
                "timebase-frequency", get_tbclk(), 1);
        do_fixup_by_prop_u32(blob, "device_type", "cpu", 4,
                "bus-frequency", bd->bi_busfreq, 1);
        do_fixup_by_prop_u32(blob, "device_type", "cpu", 4,
                "clock-frequency", bd->bi_intfreq, 1);
        do_fixup_by_compat_u32(blob, "fsl,cpm-brg", "clock-frequency",
                gd->brg_clk, 1);

        /* Fixup ethernet MAC addresses */
        fdt_fixup_ethernet(blob, bd);

        fdt_fixup_memory(blob, (u64)bd->bi_memstart, (u64)bd->bi_memsize);
}

Adding fdt support to an 8xx board is then as simple as defining

/* pass open firmware flat tree */
#define CONFIG_OF_LIBFDT        1
#define CONFIG_OF_BOARD_SETUP   1


In your u-boot/include/configs/MySuperBoard.h

Best,
Bryan
