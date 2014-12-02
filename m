Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0138.outbound.protection.outlook.com [157.56.111.138])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BD0E1A00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 16:03:17 +1100 (AEDT)
Message-ID: <1417496585.15957.210.camel@freescale.com>
Subject: Re: [RFC PATCH v1 1/1] powerpc/85xx: Add support for
 Emerson/Artesyn MVME2500.
From: Scott Wood <scottwood@freescale.com>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Mon, 1 Dec 2014 23:03:05 -0600
In-Reply-To: <CAPk1OjGGnF6jxxXOOqK4dB9-g2=CyT7DsS8U+KgW3-g2PooXdQ@mail.gmail.com>
References: <1417011468-13485-1-git-send-email-alessio.bogani@elettra.eu>
 <1417040495.15957.176.camel@freescale.com>
 <CAPk1OjGGnF6jxxXOOqK4dB9-g2=CyT7DsS8U+KgW3-g2PooXdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-27 at 15:28 +0100, Alessio Igor Bogani wrote:
> Scott,
> 
> On 26 November 2014 at 23:21, Scott Wood <scottwood@freescale.com> wrote:
> > On Wed, 2014-11-26 at 15:17 +0100, Alessio Igor Bogani wrote:
> >> +     lbc: localbus@ffe05000 {
> >> +             reg = <0 0xffe05000 0 0x1000>;
> >> +
> >
> > It's not possible to program the LBC with a window of only 0x1000 bytes.
> 
> All similar boards seem to have the same value there. 

I was referring to the final ranges entry:

> +                         0x5 0x0 0x0 0xffdf0000 0x00001000>;

The localbus ranges should reflect what was programmed into BRn/ORn.
The smallest size that can be programmed into ORn is 32 KiB.

> AFAIK 0x1000 is a offset so it stands for 4KB.

It's not an offset.  It's a size in both cases.

> >> +
> >> +             serial2: serial@1,0 {
> >> +                     #cell-index = <2>;
> >> +                     device_type = "serial";
> >> +                     compatible = "ns16550";
> >> +                     reg = <0x1 0x0 0x100>;
> >> +                     clock-frequency = <1843200>;
> >> +                     interrupts = <11 2 0 0>;
> >> +             };
> >
> > Why do you need cell-index, what connection do these values have to
> > actual hardware (e.g. values written to a register, rather than numbers
> > in a manual), and why did the name change to #cell-index?
> 
> I have used fsl/pq3-duart-0.dtsi as template and #cell-index are used there.

"cell-index" is used there (though I don't know why), not "#cell-index".
The latter string does not appear anywhere in the kernel.

> >> +/include/ "mvme2500.dtsi"
> >
> > Are you going to have more than one .dts using this .dtsi?  If not, why
> > separate this part?
> 
> The pq3-gpio-0.dtsi defines an gpio controller in this way:
> 
> gpio-controller@f000 {
>      reg = <0xf000 0x100>;
>      [...]
> 
> But MVME2500 board requires a slightly different definition:
> 
>      reg = <0xfc00 0x100>;

The GPIO CCSR registers on a P2010 don't change based on what board you
put it on.  It looks like pq3-gpio-0.dtsi is just wrong, for all chips
that use it.  It should be fixed there.

> Override gpio-controller reg definition included by
> fsl/p2020si-post.dtsi (which includes the above mentioned
> fsl/pq3-gpio-0.dtsi) using mvme2500.dtsi is the only solution I have
> found so far.
> 
> Can you suggest me a better approach, please?

There's no need here, but if you did for some reason need to override
something in <chip>-post.dtsi, you could just put it after the include
of the post file.  No need to push the board's fragment into yet another
dtsi. 

> >> diff --git a/arch/powerpc/configs/85xx/mvme2500_defconfig b/arch/powerpc/configs/85xx/mvme2500_defconfig
> >> new file mode 100644
> >> index 0000000..06fe629
> >> --- /dev/null
> >> +++ b/arch/powerpc/configs/85xx/mvme2500_defconfig
> >
> > Why does this board need its own defconfig?
> >
> > If it's just for the address space stuff, maybe it could be a more
> > general mpc85xx_2g_1g_1g_defconfig.  xes_mpc85xx_defconfig uses the same
> > layout (though it's SMP).  Maybe other boards could share it in the
> > future, or users of existing boards might prefer it...
> 
> Sorry for ignorance but what are *_defconfigs supposed to provide?
> A barely bootable system (in that case I can pick the config of a
> similar board) or a system with all drivers for devices exposed by its
> device tree?

All drivers.  It's OK to add drivers to existing defconfigs -- though
I'd hesitate to put staging drivers in there, so I guess it can have its
own defconfig as long as it relies on that.

> > Better still would be if we could have address map tweaks be kconfig
> > fragments that get mixed in by the user, with merge_config.sh.
> 
> Personally I would prefer see something more simple like this:
> 
> %_defconfig: scripts/kconfig/conf
>    # Grab the platform generic config file (for a SoC family)
>    $(Q)$< --defconfig=arch/$(SRCARCH)/configs/mpc$(shell dirname
> $@)_defconfig Kconfig

What is the dirname here trying to do?

> >> +CONFIG_ADVANCED_OPTIONS=y
> >> +CONFIG_LOWMEM_SIZE_BOOL=y
> >> +CONFIG_LOWMEM_SIZE=0x40000000
> >> +CONFIG_PAGE_OFFSET_BOOL=y
> >> +CONFIG_PAGE_OFFSET=0x80000000
> >> +CONFIG_KERNEL_START_BOOL=y
> >> +CONFIG_TASK_SIZE_BOOL=y
> >> +CONFIG_TASK_SIZE=0x80000000
> >
> > I gues the point here is to avoid using highmem just for the last 256
> > MiB?
> 
> Yes. Can you suggest me a better solution, please?

Not if the performance benefit from getting rid of highmem is worth
carrying this around...  But it would still be good if the board support
were build in the standard defconfig as well.  It's unlikely to get much
build coverage (by people who don't use this board) in a board-specific
defconfig.

> >> +CONFIG_STAGING=y
> >
> > What do you need from staging?
> 
> CONFIG_VME_USER. It is a staging driver although it isn't appear in
> staging menu.

OK.

-Scott
