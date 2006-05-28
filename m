Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7820267A3E
	for <linuxppc-dev@ozlabs.org>; Sun, 28 May 2006 22:07:55 +1000 (EST)
Date: Sun, 28 May 2006 14:07:48 +0200
From: Olaf Hering <olh@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: add dmesg command to xmon
Message-ID: <20060528120748.GA7608@suse.de>
References: <20060528104621.GA7126@suse.de> <200605281404.26070.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200605281404.26070.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, May 28, Arnd Bergmann wrote:

> This whole function looks fishy to me. It seems unnecessarily rude to me to
> use kallsyms_lookup_name in order to get at a static variable from another
> file. Can't you instead add a global function to kernel/printk.c to return
> the buffer?

Its possible, but it wont end up in Linus tree.

> Also, what's the purpose of the sync/__delay code in here? If you use that
> to check for a possible machine check that may have happened, why not in
> the case where the lookup fails?

I just copied the other usages. Accessing the dmesg buffer itself may
need similar checks.
