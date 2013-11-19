Return-Path: <scottwood@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF0552C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 10:43:40 +1100 (EST)
Message-ID: <1384904608.1403.395.camel@snotra.buserror.net>
Subject: Re: [PATCH] lib/crc32: slice by 4 is more efficient than the
 default slice by 8 on Powerpc 8xx.
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 19 Nov 2013 17:43:28 -0600
In-Reply-To: <OFE596957E.9CEC5C97-ONC1257C28.00814EE8-C1257C28.0081FB80@transmode.se>
References: <20131118070423.E47181A4D3D@localhost.localdomain>
 <OF5004EA63.AA9B7989-ONC1257C28.004D6C13-C1257C28.004DF922@transmode.se>
 <1384885766.1403.366.camel@snotra.buserror.net>
 <OFE596957E.9CEC5C97-ONC1257C28.00814EE8-C1257C28.0081FB80@transmode.se>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Marcelo Tosatti <marcelo@kvack.org>,
 Bob Pearson <rpearson@systemfabricworks.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-20 at 00:39 +0100, Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 2013/11/19 19:29:26:
> > 
> > I don't think we should go littering the Kconfig with defaults for
> > various bits of hardware -- especially since you've already pointed out
> > non-8xx hardware that would also want this.  Put it in defconfig
> > instead, unless you can identify very broad classes of machines for
> > which SLICEBY4 is faster.
> 
> hmm, when 64bits went in there was not much proof that it was faster for
> a wide range of CPU, just 2 or 3 if I recall correctly. I suspect there
> are quite a few CPUs where 32 bits a equal or faster.

That may be the case, but I don't think we want a big list of them in
lib/Kconfig.  Whether the default should change (for all targets that
don't override it in defconfig, or at least for some broader category
such as "all 32-bit chips") is a different discussion.

-Scott
