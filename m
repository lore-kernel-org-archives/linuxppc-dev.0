Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0E936DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 21:33:44 +1000 (EST)
Date: Thu, 23 Aug 2007 15:33:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v7 0/3] [POWERPC] fsl_soc: add support for fsl_spi
Message-ID: <20070823113349.GA11870@localhost.localdomain>
References: <20070822145415.GA22595@localhost.localdomain>
	<20070822145732.GA22686@localhost.localdomain>
	<20070823132421.d2b230af.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070823132421.d2b230af.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2007 at 01:24:21PM +1000, Stephen Rothwell wrote:
> Hi Anton,
> 
> On Wed, 22 Aug 2007 18:57:32 +0400 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> >
> > +	sysclk = *(u32 *)of_get_property(np, "bus-frequency", NULL);
> 
> I just cringe everytime I see someone dereference a pointer they got from
> somewhere (effectively) external without checking for NULL.

Actually, sitting at the editor I thought twice before _removing_ NULL
checks, and obviously was wrong with final decision. ;-)

I just knew that there is already many places in fsl_soc that don't
check for NULLs, especially when:

> I realise
> that sometimes "that can't happen" ...

Probably to save some code space. But now I seem to comprehend it: not
checking for NULL properties is not a some kind of rule for fsl_soc,
but exceptions which probably should be fixed someday.

Thanks.


[Not related to this particular answer]

Heh.. honestly speaking, I myself don't like externs I introducing in
the board file. Okay, let's risk, and do whole thing correctly:
placing externs into asm/qe.h, trivial patch that could end up with
long discussion. ;-)

Lucky numbered v7 is following.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
