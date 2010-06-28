Return-Path: <stevedeiters@basler.com>
Received: from tethra.basler.com (tethra.basler.com [206.107.254.19])
	by ozlabs.org (Postfix) with ESMTP id 98691B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 07:25:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: JFFS2 corruption when mounting filesystem with filenamesoflength>
	7
Date: Mon, 28 Jun 2010 16:25:02 -0500
Message-ID: <181804936ABC2349BE503168465576460F20D651@exchserver.basler.com>
In-Reply-To: <181804936ABC2349BE503168465576460F20CB90@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F1AAEC6@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F1AAEE1@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F1AB73E@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F20CB90@exchserver.basler.com>
From: "Steve Deiters" <SteveDeiters@BASLER.com>
To: <linux-mtd@lists.infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I think there may be something weird going on with the memcpy=20
> in my build.  If I use the following patch I no longer get=20
> errors when I mount the filesystem.  All I did was replace=20
> the memcpy with a loop.
>=20
> I'm not sure what's special about this particular use of=20
> memcpy.  I can't believe that things would be working as well=20
> as they do if memcpy was broken in general.
>=20
> This is on a PowerPC 32 bit build for a MPC5121.  I am using=20
> a GCC 4.1.2 to compile.  Is anyone aware of any issues with=20
> memcpy in this configuration?
>=20
> Thanks.

It seems this processor is mangling the data when it access unaligned
addresses into Flash with a lwz instruction.  The memcpy implementation
in copy_32.S aligns the destination, leaving the source possibly
unaligned.  In this particular instance the source is an address into=
 my
Flash address space which is causing the problem.  When the filenames
were < 8 it always does a bytewise copy which is why I wasn't having
problems with those.

It seems this only occurs when I have the translation enabled.  If I
clear the DR bit in the MSR and then repeat the instruction with the
corresponding physical address it will read correctly.

I'm not sure if this is expected behavior with this core.  I can fix at
least this one problem by using memcpy_fromio since it does alignment
checks for the source and destination.

I'm not sure what the proper fix is for this.  If I use memcpy_fromio=
 I
think I'll just run into problems somewhere else.  Any other
suggestions?

Thanks.
