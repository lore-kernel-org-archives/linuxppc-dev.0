Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C74591A1A3B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 21:25:27 +1000 (AEST)
In-Reply-To: <1437130018-3430-1-git-send-email-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, anton@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: powerpc/rtas: Introduce rtas_get_sensor_fast() for IRQ handlers
Message-Id: <20150722112527.B36E01402C8@ozlabs.org>
Date: Wed, 22 Jul 2015 21:25:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-17-07 at 10:46:58 UTC, Thomas Huth wrote:
> The EPOW interrupt handler uses rtas_get_sensor(), which in turn
> uses rtas_busy_delay() to wait for RTAS becoming ready in case it
> is necessary. But rtas_busy_delay() is annotated with might_sleep()
> and thus may not be used by interrupts handlers like the EPOW handler!
> This leads to the following BUG when CONFIG_DEBUG_ATOMIC_SLEEP is
> enabled:

When did we break this?

cheers
