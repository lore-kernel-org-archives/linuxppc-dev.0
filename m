Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FED31007DE
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 16:26:34 +1100 (EST)
Subject: Re: [PATCH 7/8] spi_mpc8xxx: Turn qe_mode into flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <3E303C4F-CE29-470F-B34A-3413F31BC23C@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164925.GG4578@oksana.dev.rtsoft.ru>
	<3E303C4F-CE29-470F-B34A-3413F31BC23C@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Nov 2009 16:03:36 +1100
Message-ID: <1259039016.16367.118.camel@pasglop>
Mime-Version: 1.0
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-05 at 07:47 -0600, Kumar Gala wrote:
> On Oct 12, 2009, at 11:49 AM, Anton Vorontsov wrote:
> 
> > Soon there will be more flags introduced in subsequent patches, so
> > let's turn qe_mode into flags.
> >
> > Also introduce mpc8xxx_spi_strmode() and print current SPI mode.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> > ---
> > drivers/spi/spi_mpc8xxx.c   |   30 +++++++++++++++++++-----------
> > include/linux/fsl_devices.h |    2 +-
> > 2 files changed, 20 insertions(+), 12 deletions(-)
> 
> applied to next

This patch breaks my 6xx config:

/home/benh/linux-powerpc-test/arch/powerpc/platforms/83xx/mpc832x_rdb.c: In function ‘of_fsl_spi_probe’:
/home/benh/linux-powerpc-test/arch/powerpc/platforms/83xx/mpc832x_rdb.c:77: error: ‘struct fsl_spi_platform_data’ has no member named ‘qe_

The reason is that the mpc832x_rdb.c code still uses the legacy probing
method. The fix is not totally trivial as the new flags are defined inside
spi_mpc8xxx.c so either the flags need to be moved to fsl_devices.h or
mpc832x_rdb.c needs to be converted to new style stuff.

I'll commit (will be up later today in my next branch) a fix moving the
flags over for now so the tree doesn't break building.

If you are going to keep the flags in the .c file you probably also want
to remove the platform device definition from fsl_devices.h anyways as
there's no point exposing to the world a structure with a "flags" member
if the definition of those flags isn't also exposed.

Cheers,
Ben.
