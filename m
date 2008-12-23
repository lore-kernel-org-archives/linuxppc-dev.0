Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB3FBDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 07:20:02 +1100 (EST)
Subject: Re: [PATCH RESEND] powerpc: make udbg 16550 boot console
	configurable for EMBEDDED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <1230037894-26837-1-git-send-email-jacmet@sunsite.dk>
References: <1230037894-26837-1-git-send-email-jacmet@sunsite.dk>
Content-Type: text/plain
Date: Wed, 24 Dec 2008 07:19:56 +1100
Message-Id: <1230063596.7292.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-23 at 14:11 +0100, Peter Korsgaard wrote:
> The udbg console is currently always enabled for platforms selecting
> the PPC_UDBG_16550 symbol (needed to create platform devices for
> 8250 SoC UARTs from DT).
> 
> Now, the udbg console is nice for debugging as it works so early, but
> it also has a number of disadvantages:

 .../...

I don't think that's the right approach.

I think a better one is to make a config option that selects whether the
udbg console is registered. ie. CONFIG_UDBG_CONSOLE which would affect
the calls sites in setup_32/64.c or the register_udbg_console() function
itself in udbg.c

Ben.
