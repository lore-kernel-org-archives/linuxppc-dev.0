Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17748.17364.884083.164844@cargo.ozlabs.ibm.com>
Date: Fri, 10 Nov 2006 20:18:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 4/5] ppc64: make soft_enabled irqs preempt safe
In-Reply-To: <Pine.LNX.4.64.0610311841570.26470@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0610311841570.26470@blonde.wat.veritas.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hugh Dickins writes:

> local_irq_restore be careful to access hard_enabled and lppaca before
> setting soft_enabled, which may well permit preemption.  Use local_paca

The reason for testing hard_enabled *after* setting soft_enabled is to
avoid a race.  If we load hard_enabled first, as your patch does, then
an interrupt could come in between that load and the store that sets
soft_enabled, and we would miss that and not hard-enable as we should.

I'm not sure what the solution is.  I suppose we could disable
preemption, although I'd rather something lighter-weight if possible.

Paul.
