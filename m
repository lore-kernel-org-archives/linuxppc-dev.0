Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id EB581DDDE3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 16:23:27 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: benh@kernel.crashing.org
Subject: Re: Regarding select() on PPC
Date: Wed, 24 Sep 2008 08:23:12 +0200
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<1222160853.12085.136.camel@pasglop>
In-Reply-To: <1222160853.12085.136.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809240823.12484.arnd@arndb.de>
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 23 September 2008, Benjamin Herrenschmidt wrote:
> 
> > Means argument checking in ppc_select() can be removed??
> > Than shall I post patch to linuxppc-dev@ozlabs.org
> 
> ppc_select can probably be removed alltogether and ppc32_select too

I think ppc32_select needs to stay. It never did the hack for
supporting the old_select calling conventions, but it does the
sign extension for the 32 bit arguments, which I think you still
want.

In any way, both the 32 bit emulation and the native ppc32 code
path should do the same thing, which currently they don't.

	Arnd <><
