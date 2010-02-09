Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f203.google.com (mail-iw0-f203.google.com
	[209.85.223.203]) by ozlabs.org (Postfix) with ESMTP id 08AD0B7D30
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 04:22:26 +1100 (EST)
Received: by iwn41 with SMTP id 41so2852666iwn.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 09:22:25 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100205205041.GA4178@oksana.dev.rtsoft.ru>
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
	<20100205205041.GA4178@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:22:04 -0700
Message-ID: <fa686aa41002090922p73abf37bm2ae44823b9d0853@mail.gmail.com>
Subject: Re: [PATCH 1/3] of platforms: Move common static initialization to
	of_node_init()
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>,
	David Brownell <dbrownell@users.sourceforge.net>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 1:50 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> So far of_node_init() just initializes a kref, later we'll have to
> initialize other fields (for example node->data_lock).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> =A0arch/microblaze/kernel/prom.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++--
> =A0arch/powerpc/kernel/prom.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +=
+--
> =A0arch/powerpc/platforms/iseries/vio.c =A0 =A0 =A0| =A0 =A05 +++--
> =A0arch/powerpc/platforms/pseries/dlpar.c =A0 =A0| =A0 =A07 ++++---
> =A0arch/powerpc/platforms/pseries/reconfig.c | =A0 =A07 ++++---
> =A0arch/powerpc/sysdev/msi_bitmap.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++--
> =A0arch/sparc/kernel/prom_common.c =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +++---
> =A0drivers/of/base.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 10 ++++++++++
> =A0include/linux/of.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 ++
> =A09 files changed, 32 insertions(+), 17 deletions(-)

unflatten_dt_*() has been merged and moved to drivers/of.  Please
rebase this series on top of my next-devicetree branch in this git
tree:

git://git.secretlab.ca/git/linux-2.6

Otherwise, this looks fine to me.

g.
