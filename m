Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17762.9524.67555.778549@cargo.ozlabs.ibm.com>
Date: Tue, 21 Nov 2006 08:59:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/22] powerpc: convert idle_loop to use hard_irq_disable()
In-Reply-To: <20061120180520.418063000@arndb.de>
References: <20061120174454.067872000@arndb.de>
	<20061120180520.418063000@arndb.de>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> I got a bug report that I believe might be fixed by this
> patch. The problem seems to be that with soft-disabled
> interrupts in power_save, we can still get external exceptions
> on Cell, even if we are in pause(0) a.k.a. sleep state.

[snip]

> -				local_irq_disable();
> +				hard_irq_disable();

This would mean that any platform-specific power_save function that
wants to re-enable interrupts (as the pseries ones do) would have to
do hard_irq_enable instead of local_irq_enable.  Also, I don't think
this change will be good on iSeries.

What we want is an irq-disable function that is like local_irq_disable
but also clears MSR_EE and the hard irq enabled flag (provided we
aren't running on iSeries).

Paul.
