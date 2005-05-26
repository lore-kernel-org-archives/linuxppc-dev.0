Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8314A67B20
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 09:09:00 +1000 (EST)
In-Reply-To: <1116607235.29111.20.camel@gleep>
References: <1116607235.29111.20.camel@gleep>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 26 May 2005 18:08:54 -0500
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
Cc: Jakob Viketoft <jakob.viketoft@bitsim.se>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: OF flat device tree for ppc32...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon,

Can you break the patch up into a few pieces, it will be easier to 
review that way.  Here are the following pieces that make sense to me:

0. New firmware interface (fw_bdt*, Kconfig, ...)
1. board code changes (everything in arch/ppc/platforms/*)
2. driver changes (things in *_io, ide, net, serial dirs -- try to give 
a better list below)
3. System changes (files in arch/ppc/syslib and include/asm-ppc)

Let me know if you feel these are reasonable, they suck, or otherwise.

Let's handle the removal in arch/m68knommu/platform/68360/commproc.c 
outside of all of this (thus isolating ourselves to PPC).

2. DRIVER CHANGES:
  ppc/8260_io/enet.c                      |    9
  ppc/8260_io/fcc_enet.c                  |   15
  ppc/8xx_io/commproc.c                   |    3
  ppc/8xx_io/enet.c                       |   10
  ppc/8xx_io/fec.c                        |    8
  ide/ppc/mpc8xx.c                        |   14
  mtd/maps/tqm8xxl.c                      |    7
  net/fec.c                               |    6
  net/fec_8xx/fec_8xx-netta.c             |    5
  net/oaknet.c                            |    6
  serial/68360serial.c                    |    3
  serial/cpm_uart/cpm_uart_core.c         |    8
  serial/cpm_uart/cpm_uart_cpm1.c         |   13
  serial/cpm_uart/cpm_uart_cpm2.c         |   13
  serial/mpc52xx_uart.c                   |   11

- kumar

On May 20, 2005, at 11:40 AM, Loeliger Jon-LOELIGER wrote:

> On Thu, 2005-05-19 at 01:41, Jakob Viketoft wrote:
>> Hello Jon!
>>
>> Any news on the port of the OF-layer to ppc32? I'd love to hear some
>> more and it would be great be able to help out, even though I have
> some
>> heavy deadlines hanging over me for the next 2 months. From what I can
>
>> see on the list, there wasn't many comments on your first preparatory
>> code, but I for one thinks it's time to move it forward anyway.
>>
>> What do you say?
>>
>> 	/Jakob
>
> Folks,
>
> I have updated my tree and patch to the latest GIT
> as of last night.  The new patch is available here:
>
>    http://www.jdl.com/bdt_cleanup_git.patch.gz
>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>
> Please let me know if there are difficulties retrieving it.
>
> This patch has a few caveats associated with it.
> In particular, it does not address the entire
>
>     arch/ppc/boot/simple
>
> issue at all.  And for that reason, this patch does
> not yet actually remove the to-be-obsoleted ppcboot.h
> that is otherwise unreferenced.  I am hopeful that
> someone who is muchm ore familiar with that code can
> pick up from this patch and Do The Right Thing there.
>
> This patch in no-way eliminates the U-Boot-to-Kernel
> interface yet.  It merely isolates it all to one location
> and provides a functional interface to it.
>
> Enjoy,
> jdl
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
