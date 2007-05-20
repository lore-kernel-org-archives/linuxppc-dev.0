Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 32E31DDE27
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 02:50:55 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.22-rc2 built on ppc
Date: Sun, 20 May 2007 18:49:28 +0200
References: <20070520112904.GM3253@aragorn.home.lxtec.de>
	<46506EE0.9000405@s5r6.in-berlin.de>
In-Reply-To: <46506EE0.9000405@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705201849.29805.arnd@arndb.de>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux1394-devel@lists.sourceforge.net,
	Elimar Riesebieter <riesebie@lxtec.de>, ben.collins@ubuntu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 20 May 2007, Stefan Richter wrote:
> I don't know what's to blame for the warnings --- new gcc versions or
> the change from do { } while (0) to ((void)0)? =A0Either way, the compiler
> should comprehend that the arguments stuffed into the dma_unmap_single
> macro are _not_ unused by accident; it should stay quiet and optimize
> the unused variables away if run with -Osomething.

There is not much that the compiler can do by itself, since the macro
expansion happens in the preprocessor.

I think the best solution would be to replace the macros with
inline functions, so that the compiler can see them. This will
also give gcc the chance to do type checking on the arguments.

	Arnd <><
