Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CE421A05A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 21:00:26 +1100 (AEDT)
Message-ID: <1444644025.31951.1.camel@ellerman.id.au>
Subject: Re: [PATCH 1/6] powerpc/kconfig: Move NR_IRQS into "Kernel Options"
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org, thuth@redhat.com
Date: Mon, 12 Oct 2015 21:00:25 +1100
In-Reply-To: <7826129.RXlL8kStvO@wuerfel>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
 <7826129.RXlL8kStvO@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-08 at 23:30 +0200, Arnd Bergmann wrote:
> On Friday 09 October 2015 08:09:12 Michael Ellerman wrote:
> > Currently the NR_IRQS option sits at the top level, which is ugly in
> > menuconfig. It's not something users will commonly need to worry about
> > so move it into "Kernel Options".
> 
> Is this option actually still meaningful at all, when you select CONFIG_SPARSE_IRQ
> unconditionally?

It's still used for #define NR_IRQS, which is still used by the generic irq
code and also some drivers.

So we need some value for that, whether it needs to be user defined or if we
could just pick a value I'm not sure. x86 seem to just define it based on
NR_CPUs and some other factors.

cheers
