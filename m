Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 76950DDF4E
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 23:46:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Fri, 29 Jun 2007 15:45:53 +0200
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
In-Reply-To: <18052.42546.78964.805791@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706291545.53890.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 June 2007, Paul Mackerras wrote:
> It turns out that with Arnd's patches we now get "-mcpu=3Dpowerpc64" on
> the command line, and that means that gcc *doesn't* put "-mppc64" the
> as command line, and as barfs on the 64-bit instructions. =A0That's
> presumably a gcc bug, but we'll have to work around it. =A0I think the
> best thing is just to not put the -mcpu=3Dpowerpc64 in CFLAGS when no
> specific CPU is selected.

I can't reproduce the problem here unfortunately. My idea was to always
pass _some_ -mcpu=3D flag, in order to make sure it does not use
an inappropriate default, e.g. when the compiler is built for a default
for power4 but you actually want to build a power3 kernel.

Would it work reliably if we switch the arguments to
'-mcpu=3Dpowerpc64 -m64' instead of '-m64 -mcpu=3Dpowerpc64'? That
might be better than taking it out entirely.

	Arnd <><
