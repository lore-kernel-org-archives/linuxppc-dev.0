Date: Wed, 29 Aug 2001 17:31:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Waite <bwaite@cspi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trying to boot linux on a MVME5100
Message-ID: <20010829173139.I18618@cpe-24-221-152-185.az.sprintbbd.net>
References: <85256AB7.00607D65.00@pine.cspi.com> <200108292010.QAA06333@orchid.cspi.com> <20010829163256.E18618@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010829163256.E18618@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 29, 2001 at 04:32:56PM -0700, Tom Rini wrote:
> On Wed, Aug 29, 2001 at 04:02:35PM -0400, Brian Waite wrote:
>
> > I am also using an MVME5100 it works so far except with the new 2.4.9 devel
> > tree I can  no longer build a zImage.initrd. make zImage.initrd completes and
> > is happy, but I never find the file in the tree anywahere. I have cheked pp3,
> > prep, common, simple and images. The most I can find is a vmlinux.gz Any
> > ideas on this?
>
> G'arg...  It really should be:
> arch/ppc/boot/images/zImage.initrd.{pplus,bugboot}
>
> I'll go and make a quick dummy ramdisk and try this..

Whoops.  Typo on my part.  In arch/ppc/boot/simple/Makefile, change:
ifeq ($(CONFIG_MCPN765)$(CONFIG_MVMEM5100)$(CONFIG_PRPMC750)$(CONFIG_LOPEC),y)
to
ifeq ($(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750)$(CONFIG_LOPEC),y)

Then re-run make zImage.initrd and you'll get something like:
-rwxr-xr-x    1 trini    trini      703610 Aug 29 17:30 arch/ppc/boot/images/zImage.initrd.bugboot
-rwxr-xr-x    1 trini    trini      704611 Aug 29 17:30 arch/ppc/boot/images/zImage.initrd.pplus

I'm pushing this fix now, whoops..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
