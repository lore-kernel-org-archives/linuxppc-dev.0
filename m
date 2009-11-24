Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 598C8B6F04
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 02:41:58 +1100 (EST)
Date: Tue, 24 Nov 2009 18:41:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] spi_mpc8xxx: Turn qe_mode into flags
Message-ID: <20091124154145.GA23040@oksana.dev.rtsoft.ru>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164925.GG4578@oksana.dev.rtsoft.ru>
	<3E303C4F-CE29-470F-B34A-3413F31BC23C@kernel.crashing.org>
	<1259039016.16367.118.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1259039016.16367.118.camel@pasglop>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 24, 2009 at 04:03:36PM +1100, Benjamin Herrenschmidt wrote:
[...]
> This patch breaks my 6xx config:
> 
> /home/benh/linux-powerpc-test/arch/powerpc/platforms/83xx/mpc832x_rdb.c: In function ‘of_fsl_spi_probe’:
> /home/benh/linux-powerpc-test/arch/powerpc/platforms/83xx/mpc832x_rdb.c:77: error: ‘struct fsl_spi_platform_data’ has no member named ‘qe_
> 
> The reason is that the mpc832x_rdb.c code still uses the legacy probing
> method. The fix is not totally trivial as the new flags are defined inside
> spi_mpc8xxx.c

Thanks for noticing. I indeed forgot about the legacy stuff. :-/

> If you are going to keep the flags in the .c file you probably also want
> to remove the platform device definition from fsl_devices.h anyways as
> there's no point exposing to the world a structure with a "flags" member
> if the definition of those flags isn't also exposed.

Yep. Though, IIRC Joakim asked to keep the legacy bindings for some
time (until we implement SPI chip-select framework?)... so for now
we'll have to leave we the exposed flags.

Thanks again,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
