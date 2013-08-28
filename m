Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A8B5F2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 23:50:37 +1000 (EST)
Date: Wed, 28 Aug 2013 15:50:28 +0200
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 00/31] add COMMON_CLK support for PowerPC MPC512x
Message-ID: <20130828135028.GB4700@book.gsilab.sittig.org>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ summary for the busy or the impatient:
  this is a status update on the series
  - peripheral driver cleanup considered appropriate for v3.12
  - common clock support introduction isn't ready yet
  - which in turn holds subsequent parts
  - while the overall shape of the series is looking good ]

On Tue, Aug 06, 2013 at 22:43 +0200, Gerhard Sittig wrote:
> 
> this series
> - fixes several drivers that are used in the MPC512x platform (UART,
>   SPI, ethernet, PCI, USB, CAN, NAND flash, video capture) in how they
>   handle clocks (appropriately acquire and setup them, hold references
>   during use, release clocks after use)
> - introduces support for the common clock framework (CCF, COMMON_CLK
>   Kconfig option) in the PowerPC based MPC512x platform, which brings
>   device tree based clock lookup as well
> 
> although the series does touch several subsystems -- tty (serial), spi,
> net (can, fs_enet), mtd (nfc), usb, i2c, media (viu), and dts -- all of
> the patches are strictly clock related or trivial
> 
> it appears most appropriate to take this series through either the clk
> or the powerpc trees after it has passed review and other subsystem
> maintainers ACKed the clock setup related driver modifications

Since the status of this series was questioned recently, I felt
that I should officially and publicly provide a status update in
the absence of a v5 submission update.

The series has undergone some review and has received changes as
concerns were raised and feedback was provided.  While I consider
the nature and frequency of the changes totally appropriate --
each revision addressed all of the issues raised, and did so in
an appropriate manner, but could not forsee what else would be
raised upon re-submission.  Actually not sending another version
before _all_ concerns are addressed appropriately is what held
back submission of v5.  See the phase overview below for details.


Adding the cleanup of existing code before the introduction of
new features did widen the scope of the series, yet has heavily
improved the series, and the feedback was gratefully accepted and
thoroughly got addressed.

Actually this driver cleanup, which only was introduced after
initial submission upon Mark's request, could be considered the
most desirable part of the series at this very point in time.
And as I write this, the patches of the "peripheral driver
cleanup" phase are being picked up for v3.12 after they have
become stable in the review iterations.


Further extension of test coverage for the series after
submission of v4 has led to minimal fixes in CAN, USB, and PCI,
and has revealed one problem in multi platform configurations
which currently is the only remaining blocker for phase 2 and
subsequent steps.  While phase 1 with its obvious cleanup is
stable and has become desirable and acceptable and currently is
being picked up.


The current status of the v4 series in detail is:

Phase 1, patches 01-14/31, peripheral driver cleanup and DTS
improvement:  has addressed all concerns raised, and can be
applied via any subtree in any order since the parts are
independent from each other, with a few minor additions

- USB 03/31 received another adjustment of the clock lookup 'dev'
  parameter, the applied version works in all three cases of the
  PPC_CLOCK implementation where clock names are global, the CCF
  implementation with clkdev registration (during migration), and
  the CCF implementation with device tree based clock lookup (the
  end result of the series); the v4 patch wasn't broken but just
  in need of an addendum before/within phase 3, which now was
  folded into phase 1

- PCI 09/31 had a compile error on 85xx/86xx due to a
  copy'n'paste bug in an error path; since the (fixed) patch
  still remains a NOP for now and within the whole series, I have
  suggested to leave this patch for v3.12, and to address the
  remaining issue of the PCI driver patch being incomplete later,
  see the followup for 09/31 for details (what gets added in a
  future version is another comment in the PCI driver and a
  workaround in the clock provider backend, because in the given
  implementation the peripheral driver cannot appropriately
  acquire its clock item on some platforms)

- CAN 11/31 could save one more instruction by adding another
  jump label in the error path instead of explicit undo of a
  setup step, Marc's suggestion was implemented and has been
  applied

So all parts of phase 1 (with the exception of the PCI driver
change which is and remains a NOP) were applied, and followup
patches for fixup were avoided.  Nothing was broken, no breakage
was introduced, it's all about improvements.

Phase 2, patches 15-18/31, introduction of CCF support for
MPC512x:  works correctly for MPC512x and doesn't break other
platforms, but won't work in multi platform configurations with
MPC52xx (PPC_CLOCK and COMMON_CLK will collide in the linker),
shall not be considered for v3.12, multi platform needs to get
sorted out before consideration for v3.13 (and is the only known
issue of the series feature- or policy-wise)

Phase 3, patches 20,21,23-28/31, adoption of peripheral drivers
to the CCF world:  is complete feature-wise and recently has
received even more test coverage than before, remaining fixes got
folded into phase 1, patches of phase 3 depend on CCF support
which gets introduced in phase 2, and the "workaround removal"
aspects of phase 3 will explicitly be moved to phase 4 while the
content remains unaffected (mere split and re-order)

Phase 4, patches 19,22,29-31/31, removal of migration support
after complete adoption:  is complete feature-wise, but partial
removal of workarounds and compatibility from phase 3 shall move
explicitly to phase 4, to more strictly tell those phases apart
and for collision free application via individual subtrees if
application through a single tree cannot be done, so a mere
re-ordering remains to get communicated while nothing changes in
the content (re-ordering the sequence as well as verifying that
the patches in phase 3 are independent from each other has
already been done internally)


To summarize:
- The series is in a good shape, one multi platform issue needs
  to get addressed, everything else either is already there or
  just needs to get communicated.
- Phase 1 with the obvious cleanup is being considered for v3.12,
  and patches have been queued in their respective subtrees.
- Phase 2 will become acceptable when the multi platform
  configuration has been sorted out.  Each platform works in
  itself, just not the combination of 52xx and 512x, and actually
  MPC52xx could be considered the out-lier here (is the only
  remaining user of PPC_CLOCK, and does so with a dummy
  implementation in the absence of a real provider).
- Phases 3 and 4 are "complete" but depend on phase 2.  What
  remains is a re-sort of the CCF adjustment and the migration
  support removal aspects.
  
Thanks to those involved in the feedback and application so far!
In my eyes, changes have been few, and necessary, and always an
improvement.  Regardless of which potential for further
improvement remains, which just happens to be way outside of the
scope of the series (power consumption aspects that neither have
been addressed nor prepared before, or CCF support for other
PowerPC based platforms maybe).


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
