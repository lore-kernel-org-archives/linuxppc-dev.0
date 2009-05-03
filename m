Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BED9EDDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 06:19:44 +1000 (EST)
To: Sam Ravnborg <sam@ravnborg.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: unexpected non-allocatable section
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20090503200701.GA32601@uranus.ravnborg.org>
References: <20090502224126.641c63bf@lappy.seanm.ca>
	<20090503204546.691ec6e7.sfr@canb.auug.org.au>
	<20090503123959.0cc5c967@lappy.seanm.ca>
	<20090503193316.E72BC83420E8@gemini.denx.de>
	<20090503200701.GA32601@uranus.ravnborg.org>
Date: Sun, 03 May 2009 22:19:40 +0200
Message-Id: <20090503201940.82D3083420E8@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Sam,

in message <20090503200701.GA32601@uranus.ravnborg.org> you wrote:
>
> > The thing is, that I cannot reproduce this - I tested it with
> > v2.6.30-rc4, both with ELDK 4.1 (as you) and ELDK 4.2.
> > 
> > Both build the kernel image without any such warnings.
> 
> Anders already found the cause of this - it
> was a missing endian conversion.
> So you need to run this on a little endian target to
> see it. And you need to do a full kernel build
> so we run modpsot on vmlinux.

On a little endian target? I guess you mean LE build host, because the
target (warp board = ppc44x) is definitely big endian?

I ran the tests on a LE machine:

Linux gemini.denx.de 2.6.27.15-170.2.24.fc10.i686 #1 SMP Wed Feb 11 23:58:12 EST 2009 i686 i686 i386 GNU/Linux

> I will push the patch in a few minutes.
> 
> For reference it is below:
> 
> 	Sam
> 
> From: Anders Kaseorg <andersk@MIT.EDU>
> Subject: [PATCH] kbuild, modpost: fix unexpected non-allocatable section when cross compiling
> 
> The missing TO_NATIVE(sechdrs[i].sh_flags) was causing many
> unexpected non-allocatable section warnings when cross-compiling
> for an architecture with a different endianness.

I'm confused. Why didn't I see this, then?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
People have one thing in common: they are all different.
