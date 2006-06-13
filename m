Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17551.16830.186314.247458@cargo.ozlabs.ibm.com>
Date: Wed, 14 Jun 2006 08:52:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 32 bit userland on G5
In-Reply-To: <1150202709.12423.21.camel@hades.cambridge.redhat.com>
References: <1150194348.9208.33.camel@johannes>
	<1150202709.12423.21.camel@hades.cambridge.redhat.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Why? Just because older hardware wasn't capable of enforcing the
> permissions, that doesn't mean that we shouldn't enforce them now.

Historically the PPC32 ELF ABI has used an executable PLT, containing
instructions constructed at runtime, located next to the BSS, and
without the corresponding program header entry indicating execute
permission.  Alan Modra devised a new way of doing the PLT which
doesn't require it to be executable, but of course it is only used in
programs that have been built since the new method went into the
toolchain (in fact all of the .o files being linked have to have been
compiled with the new method in order for it to be used).

So if you are absolutely sure that every program you will ever want to
run on your kernel has been built with an up-to-date toolchain, you
can turn on enforcement of execute permissions for 32-bit processes.
It would be a "courageous" step (in the Yes Minister sense :) for a
distro to do it, IMHO.

Paul.
