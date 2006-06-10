Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 1621E67C4B
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 22:54:10 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: console_initcall ordering issues
Date: Sat, 10 Jun 2006 14:53:34 +0200
References: <20060610121622.GQ23891@krispykreme>
In-Reply-To: <20060610121622.GQ23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606101453.35055.arnd@arndb.de>
Cc: akpm@osdl.org, paulus@samba.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Saturday 10 June 2006 14:16 schrieb Anton Blanchard:
> The add_preferred_console call in rtas_console.c was not causing the
> console to be selected. It turns out that the add_preferred_console
> was being called after the hvc_console driver was registered. It only
> works when it is called before the console driver is registered.

Great, thanks for nailing this one down. We've had multiple people trying
without success to figure out why it couldn't automatically find the console.

	Arnd <><
