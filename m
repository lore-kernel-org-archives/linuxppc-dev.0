Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99328B7BA4
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Oct 2009 18:23:45 +1100 (EST)
Date: Mon, 19 Oct 2009 09:23:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/3] powerpc: perf_event: Hide iseries_check_pending_irqs
Message-ID: <20091019072334.GA17960@elte.hu>
References: <20091018112328.GN4808@kryten> <20091018112406.GO4808@kryten>
	<20091018112429.GP4808@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091018112429.GP4808@kryten>
Cc: paulus@samba.org, a.p.zijlstra@chello.nl, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Anton Blanchard <anton@samba.org> wrote:

> If CONFIG_PPC_ISERIES isn't defined we end up with iseries_check_pending_irqs
> and do_work at the same address. perf ends up picking
> iseries_check_pending_irqs which creates confusing backtraces. Hide it.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Just to confirm - these 3 symbol fixes are for the PowerPC tree, not for 
the perf events tree, right? There's nothing perf specific about the 
fixes - kgdb, systemtap and other debugging/instrumentation frameworks 
will benefit from more precise symbol generation too.

	Ingo
