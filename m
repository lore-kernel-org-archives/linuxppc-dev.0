Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8F797B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 08:30:51 +1000 (EST)
To: "Steve Deiters" <SteveDeiters@BASLER.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: JFFS2 corruption when mounting filesystem with filenamesoflength>
	7
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <181804936ABC2349BE503168465576460F20D651@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F1AAEC6@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F1AAEE1@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F1AB73E@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F20CB90@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F20D651@exchserver.basler.com>
Date: Tue, 29 Jun 2010 00:30:47 +0200
Message-Id: <20100628223047.6F7F514EBF7@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear "Steve Deiters",

In message <181804936ABC2349BE503168465576460F20D651@exchserver.basler.com> you wrote:
> > I think there may be something weird going on with the memcpy 
> > in my build.  If I use the following patch I no longer get 
> > errors when I mount the filesystem.  All I did was replace 
> > the memcpy with a loop.
> > 
> > I'm not sure what's special about this particular use of 
> > memcpy.  I can't believe that things would be working as well 
> > as they do if memcpy was broken in general.
> > 
> > This is on a PowerPC 32 bit build for a MPC5121.  I am using 
> > a GCC 4.1.2 to compile.  Is anyone aware of any issues with 
> > memcpy in this configuration?
> > 
> > Thanks.
> 
> It seems this processor is mangling the data when it access unaligned
> addresses into Flash with a lwz instruction.  The memcpy implementation
> in copy_32.S aligns the destination, leaving the source possibly
> unaligned.  In this particular instance the source is an address into my
> Flash address space which is causing the problem.  When the filenames
> were < 8 it always does a bytewise copy which is why I wasn't having
> problems with those.
> 
> It seems this only occurs when I have the translation enabled.  If I
> clear the DR bit in the MSR and then repeat the instruction with the
> corresponding physical address it will read correctly.
> 
> I'm not sure if this is expected behavior with this core.  I can fix at
> least this one problem by using memcpy_fromio since it does alignment
> checks for the source and destination.

Both the MPC52xx and MPC512x have know problems (silent data
corruption) with unaligned accesses on the local bus.

This can be trivially demonstrated in U-Boot by reading the flash
memory with 32 bit accesses; for example like this:

=> md FC0C0000 20
fc0c0000: 7012ab65 01616464 636f6e73 3d736574    p..e.addcons=set
fc0c0010: 656e7620 626f6f74 61726773 20247b62    env bootargs ${b
fc0c0020: 6f6f7461 7267737d 20636f6e 736f6c65    ootargs} console
fc0c0030: 3d247b63 6f6e736f 6c657d2c 247b6261    =${console},${ba
fc0c0040: 75647261 74657d00 61646469 703d7365    udrate}.addip=se
fc0c0050: 74656e76 20626f6f 74617267 7320247b    tenv bootargs ${
fc0c0060: 626f6f74 61726773 7d206970 3d247b69    bootargs} ip=${i
fc0c0070: 70616464 727d3a24 7b736572 76657269    paddr}:${serveri
=> md FC0C0001 20
fc0c0001: 65726901 00000063 0000003d 00000065    eri....c...=...e
fc0c0011: 00000062 00000061 00000020 0000006f    ...b...a... ...o
fc0c0021: 00000072 00000020 00000073 0000003d    ...r... ...s...=
fc0c0031: 0000006f 0000006c 00000024 00000075    ...o...l...$...u
fc0c0041: 00000074 00000061 00000070 00000074    ...t...a...p...t
fc0c0051: 00000020 00000074 00000073 00000062    ... ...t...s...b
fc0c0061: 00000061 0000007d 0000003d 00000070    ...a...}...=...p
fc0c0071: 00000072 0000007b 00000076 00000070    ...r...{...v...p

> I'm not sure what the proper fix is for this.  If I use memcpy_fromio I
> think I'll just run into problems somewhere else.  Any other
> suggestions?

See http://article.gmane.org/gmane.comp.boot-loaders.u-boot/80278 for
how we fix this in U-Boot.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"On two occasions I have been  asked  [by  members  of  Parliament!],
'Pray,  Mr.  Babbage, if you put into the machine wrong figures, will
the right answers come out?' I am not able rightly to  apprehend  the
kind of confusion of ideas that could provoke such a question."
- Charles Babbage
