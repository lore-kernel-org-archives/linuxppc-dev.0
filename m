Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0127.outbound.protection.outlook.com [207.46.100.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31DCF1A0140
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 09:47:14 +1100 (AEDT)
Message-ID: <1417560413.15957.217.camel@freescale.com>
Subject: Re: [RFC PATCH v1 1/1] powerpc/85xx: Add support for
 Emerson/Artesyn MVME2500.
From: Scott Wood <scottwood@freescale.com>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Tue, 2 Dec 2014 16:46:53 -0600
In-Reply-To: <CAPk1OjE7pAdLucb3+54MnONsNiBgzjvxsA_o-jOdXk9W2CVJAw@mail.gmail.com>
References: <1417011468-13485-1-git-send-email-alessio.bogani@elettra.eu>
 <1417040495.15957.176.camel@freescale.com>
 <CAPk1OjGGnF6jxxXOOqK4dB9-g2=CyT7DsS8U+KgW3-g2PooXdQ@mail.gmail.com>
 <1417496585.15957.210.camel@freescale.com>
 <CAPk1OjE7pAdLucb3+54MnONsNiBgzjvxsA_o-jOdXk9W2CVJAw@mail.gmail.com>
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

On Tue, 2014-12-02 at 15:55 +0100, Alessio Igor Bogani wrote:
> Hi Scott,
> 
> On 2 December 2014 at 06:03, Scott Wood <scottwood@freescale.com> wrote:
> [...]
> >> The pq3-gpio-0.dtsi defines an gpio controller in this way:
> >>
> >> gpio-controller@f000 {
> >>      reg = <0xf000 0x100>;
> >>      [...]
> >>
> >> But MVME2500 board requires a slightly different definition:
> >>
> >>      reg = <0xfc00 0x100>;
> >
> > The GPIO CCSR registers on a P2010 don't change based on what board you
> > put it on.  It looks like pq3-gpio-0.dtsi is just wrong, for all chips
> > that use it.  It should be fixed there.
> 
> I have to admit that I'm not using GPIO at the moment so a typo into
> board's manufacturer manual is more probable.

The various chip manuals also say that the registers start at offset
0xc00 in the gpio block.  Testing suggests that the registers actually
repeat every 0x100 bytes within the 4K page, but it would be good to fix
the device tree to match the documented location.

> >> > Better still would be if we could have address map tweaks be kconfig
> >> > fragments that get mixed in by the user, with merge_config.sh.
> >>
> >> Personally I would prefer see something more simple like this:
> >>
> >> %_defconfig: scripts/kconfig/conf
> >>    # Grab the platform generic config file (for a SoC family)
> >>    $(Q)$< --defconfig=arch/$(SRCARCH)/configs/mpc$(shell dirname
> >> $@)_defconfig Kconfig
> >
> > What is the dirname here trying to do?
> 
> Extract string "85xx" from "make 85xx/mvme2500_defconfig" command.
> 
> So the above mentioned Makefile snip grabs
> arch/powerpc/configs/mpc85xx_defconfig and applies (using
> merge_config.sh) options present in
> arch/powerpc/configs/85xx/mvme2500_defconfig.

But mpc85xx_defconfig isn't a suitable base for all 85xx (SMP, corenet,
etc).  Plus, hardcoding "mpc" in front of it in generic infrastructure
would not be appropriate (even on PPC you have the 40x and 44x
directories).

The right way to do this would be to have a metaconfig file that lists
the base config and a set of fragments to apply, which the user can use
like an ordinary defconfig.

> It should reduces the size of the board specific defconfig without
> using any other fragments and without change anything in user habits.
> 
> In my humble opinion that hardware is so rigid that flexibility given
> by config fragments don't seem very useful.

Which hardware?  The MVME2500?  It looked like you were proposing a more
general solution.  Note that many config options have nothing to do with
the hardware (filesystems, debug options, network protocols,
virtualization, etc).

In any case, we don't want a defconfig for every board.  We want a small
set of defconfigs that provide wide build coverage and the ability to
run on a wide variety of boards.  Nothing stops users or board vendors
from maintaining more targeted configs out of tree.

> >> > I gues the point here is to avoid using highmem just for the last 256
> >> > MiB?
> >>
> >> Yes. Can you suggest me a better solution, please?
> >
> > Not if the performance benefit from getting rid of highmem is worth
> > carrying this around...  But it would still be good if the board support
> > were build in the standard defconfig as well.  It's unlikely to get much
> > build coverage (by people who don't use this board) in a board-specific
> > defconfig.
> 
> Ok I changed mpc85xx_defconfig and it works with few addiction. So we
> have two possibilities: use mpc85xx_defconfig (but without VME_USER
> and Highmem tweak) or add mvme2500_defconfig: Which do you prefer? I
> would prefer the mvme2500_defconfig but I think that my vote doesn't
> count (rightly).

If it were just the highmem tweak I'd say that falls into the realm of
user config -- it's no different from any other board with 1 GiB of RAM.
I don't want to turn on staging drivers in the main defconfigs (unless
it's for something needed by most boards covered by the defconfig),
since it makes it easier for users to enable other staging drivers
without realizing it.

So, put everything but VME and the highmem tweak in mpc85xx_defconfig.
If you want, add an 85xx/mvme2500.config fragment that adds VME and the
highmem tweak (separate config fragments for each would be better, but
without a metaconfig mechanism it's less friendly to users who won't
know what the best starting point is for this board).

> What do you think about move board setup code from
> platform/85xx/mvme2500.c to platform/platforms/85xx/mpc85xx_ds.c?

It's not a DS board, but it'd be good to have a
platforms/85xx/mpc85xx_generic.c (similar to
platforms/85xx/corenet_generic.c) for platforms that don't need anything
special in the board file.

-Scott
