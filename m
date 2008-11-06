Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18706.30114.75625.811901@cargo.ozlabs.ibm.com>
Date: Thu, 6 Nov 2008 15:42:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 14/16 v2] powerpc: expand vs demux ipi actions per message
In-Reply-To: <patch-ipi-2-v2@bga.com>
References: <patch-ipi-2@bga.com>
	<patch-ipi-2-v2@bga.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller writes:

> With the new generic smp call function helpers, I noticed the code in
> smp_message_recv was a single function call in many cases.  While
> getting the message number from the ipi data is easy, we can reduce
> the path length by a function and data dependent switch by registering
> separate ipi actions for these simple calls.

With this I get:

  CC      arch/powerpc/kernel/smp.o
arch/powerpc/kernel/smp.c: In function 'smp_request_message_ipi':
arch/powerpc/kernel/smp.c:177: error: 'ipi_names' undeclared (first use in this function)
arch/powerpc/kernel/smp.c:177: error: (Each undeclared identifier is reported only once
arch/powerpc/kernel/smp.c:177: error: for each function it appears in.)
make[2]: *** [arch/powerpc/kernel/smp.o] Error 1

I think you need smp_ipi_name rather than ipi_names here:

> +	WARN(err < 0, "unable to request_irq %d for %s (rc %d)\n",
> +		virq, ipi_names[msg], err);

Paul.
