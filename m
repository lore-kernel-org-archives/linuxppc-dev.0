Return-Path: <bzolnier@gmail.com>
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUILD FAILURE 05/12] Next April 21 : PPC64 randconfig
	[drivers/macintosh/mediabay.o]
Date: Wed, 22 Apr 2009 11:34:17 +0200
References: <1240339875.9110.137.camel@subratamodak.linux.ibm.com>
	<200904212104.14665.bzolnier@gmail.com>
	<18926.38431.910952.630575@cargo.ozlabs.ibm.com>
In-Reply-To: <18926.38431.910952.630575@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904221134.18163.bzolnier@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, Adrian Bunk <bunk@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stefan Bader <stefan.bader@canonical.com>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, subrata@linux.vnet.ibm.com,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 April 2009 05:59:27 Paul Mackerras wrote:
> Bartlomiej Zolnierkiewicz writes:
> 
> > mediabay shouldn't include <linux/ide.h> unconditionally so
> > remove the superfluous include from mediabay.c (<asm/mediabay.h>
> > will pull <linux/ide.h> in for CONFIG_BLK_DEV_IDE_PMAC=y).
> 
> I don't like relying on second-hand imports like that.  I prefer the
> previous patch, that made mediabay depend on CONFIG_BLOCK.

I missed it somehow...

OK, I found it now and it should fix the problem as well.

> BTW, if including <linux/ide.h> causes an error when CONFIG_BLOCK=n,
> then there is a bug in <linux/ide.h>, IMO.

<linux/ide.h> is for drivers/ide only.  mediabay lacks proper abstraction
layer and is probably the only abuser left.

Besides being a build fix my patch is a right step in cleaning this mess
so I'm going to apply it through ide tree.

Thanks,
Bart
