Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 958D2DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 05:55:03 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 12/18] Uartlite: Let the console be initialized earlier
Date: Fri, 28 Sep 2007 21:40:06 +0200
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181754.18608.52779.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20070928181754.18608.52779.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709282140.07000.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 28 September 2007, Grant Likely wrote:
> +#else /* CONFIG_OF */
> +static void __init ulite_console_of_find_device(int id) { /* do nothing */ }
> +#endif /* CONFIG_OF */

Shouldn't this be inline? It shouldn't matter much since most of the time
gcc -funit-at-a-time takes care of this, but it's common to make the inlining
explicit.

	Arnd <><
