Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2C9DDDE066
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:34 +1100 (EST)
Date: Fri, 25 Jan 2008 20:13:55 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/5] [POWERPC] fsl_soc,
	legacy_serial: add support for "soc" compatible matching
Message-ID: <20080125171355.GA9879@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154010.GE23246@localhost.localdomain>
	<9C11FC54-29CF-4027-97C3-FEB1EBA2D78B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <9C11FC54-29CF-4027-97C3-FEB1EBA2D78B@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 10:35:06AM -0600, Kumar Gala wrote:
> 
> On Jan 24, 2008, at 9:40 AM, Anton Vorontsov wrote:
> 
> >We'll match on "soc" compatible for generic code, and "fsl,soc"
> >for fsl specific code.
> >
> >Unfortunately it's still impossible to remove device_type = "soc"
> >from the existing device tree, because older u-boots are looking for
> >it.
> >
> >Neither we can remove model number from the soc name to heal
> >arch/powerpc/boot/cuboot-85xx.c, because then dts'es will be
> >incompatible with older u-boots again.
> >
> >So, just one machine converted so far: MPC8360E-RDK. It's new machine
> >so we don't care about backward compatibility yet.
> >
> >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >---
> >
> >I know, this patch will conflict with the legacy serial rework[1].
> >It's okay though, if [1] will hit galak/powerpc.git first, I'll
> >simply rebase that patch.
> >
> >[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050096.html
> >
> >Documentation/powerpc/booting-without-of.txt |   18 ++++------
> >arch/powerpc/boot/dts/mpc836x_rdk.dts        |    1 -
> >arch/powerpc/kernel/legacy_serial.c          |    3 +-
> >arch/powerpc/sysdev/fsl_soc.c                |   51 ++++++++++++++ 
> >+-----------
> >4 files changed, 39 insertions(+), 34 deletions(-)
> 
> this needs a bit more discussion.

Ok.

> "fsl,soc" is terrible describe.  I  
> think we want some generic for the compat that implies 'soc register  
> space'.

My thinking:

Freescale soc register space: "fsl,soc"
generic soc device: "soc" (or maybe "linux,soc" better?)

I know, Scott Wood is pushing "xxxx-immr" thing forward... but
I don't like that name because SOC isn't only device with the
Internal Memory Mapped Registers. (Think of QE placed outside
of "soc"/"immr" node).

Though, "soc" by itself is fully unfortunate name. QE is the
part of SOC too, as we used to call it when speaking of hardware.
But logically we divide things for "core soc" and "core soc's
companion/communication/offload modules", i.e. QE/CPMs/...

We can remove that ambiguity by moving QE/CPMs nodes inside
the soc node. Then indeed -immr would be the best compatible for
the "soc" node.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
