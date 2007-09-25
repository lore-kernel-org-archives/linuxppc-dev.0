Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4490BDDECF
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 02:00:11 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l8PG07Nt028514
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 11:00:08 -0500
Date: Tue, 25 Sep 2007 19:59:59 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC8560 CPM2 SCC(UART) Driver CPM_UART_CONSOLE
Message-ID: <20070925195959.531b2fe5@kernel.crashing.org>
In-Reply-To: <20070925104704.M46195@cdotd.ernet.in>
References: <20070925104704.M46195@cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Deepak,

On Tue, 25 Sep 2007 17:33:59 +0630
Deepak Gaur wrote:

> Hi all,
> 
> I am writing a kernel module which is required to parse the characters received from a
> device attached to MPC8560 SCC2 (UART slave mode) on serial interface. This SCC is
> required to be configured for single-buffer, character based operation. Moreover on
> another SCC (SCC1 UART master mode) the board debug interface(console) is connected.
> 
> While trying to figure out CPM UART device driver interface available in file
> drivers/serial/cpm_uart/cpm_uart_core.c for my kernel module I found that some of the
> functions are available when CPM_UART_CONSOLE is enabled. 
> 
> My doubt is regarding status of this flag for my hardware setup. Should this flag be
> enabled or not. If it is required to be enabled for supporting SCC1 then how SCC2 will
> be handled?
> 
well, console is normally initialized early, before actual uart driver, that's why those bits are hidden
behind CPM_UART_CONSOLE.

I suppose you'll just have to get SCC2 uart to work and use ttyCPM1... or if you application is more specific, write another driver
using cpm_uart_core.c as a reference. But I would not recommend  using CPM_UART_CONSOLE stuff - it's pretty restricted and assumes very early triggering, with plenty of stuff not initialized.
> As I am a novice in this area , I shall be grateful if you please guide me in
> understanding this driver code.
> 
> with regards,
> 
> Deepak Gaur
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Sincerely, Vitaly
