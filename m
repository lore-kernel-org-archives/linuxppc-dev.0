Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Wed, 02 Apr 2008 18:52:08 +1100
Subject: [PATCH 0/4] [POWERPC] lockdep support for ppc64
Message-Id: <1207122728.672673.111194574046.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[Not to merge just yet ... almost]

This serie of patches adds lockdep support for 64 bits
powerpc. Dale's patch for 32 bits still need me to review
and test it which I'll try to do asap.

It needs the iSeries hardirq enable fix that I posted
earlier (which is probably 2.6.25 material).

Note that we can already see potential problems exposed
by it. So far on my list:

 - something wrong with iseries veth. Haven't got to figure
out what yet, could be a false positive

 - possible deadlock with the device-tree rwlock. The one that
I caught with lockdep here is pSeries rtas_set_rtc_time() calls
rtas_token() from softirq, which does on of_find_property(),
which takes the read lock. Other things can call prom_add_propety()
which can take the write lock, while softirqs are enabled -> boom.
Maybe we should forbid OF device-tree access from IRQs and thus
things that need to use rtas_token() will have to cache the token.
