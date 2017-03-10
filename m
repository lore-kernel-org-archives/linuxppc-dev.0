Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfs6N6J9dzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2017 02:45:32 +1100 (AEDT)
Date: Fri, 10 Mar 2017 09:41:39 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: sysdev: cpm1: Optimise gpio bit calculation
Message-ID: <20170310154139.GM31469@gate.crashing.org>
References: <20170309094206.A832167992@localhost.localdomain>
 <87a88tle0y.fsf@concordia.ellerman.id.au>
 <534d8795-ce21-9af6-498d-22597213a3a2@c-s.fr>
 <20170310130630.GH31469@gate.crashing.org>
 <906c025b-47d0-f906-2613-291f350bd48d@c-s.fr>
 <20170310143241.GJ31469@gate.crashing.org>
 <777e903f-b816-5efa-2ece-e4e16fab27c6@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <777e903f-b816-5efa-2ece-e4e16fab27c6@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 10, 2017 at 03:41:23PM +0100, Christophe LEROY wrote:
> >>>>gpio_get() and gpio_set() are used extensively by some GPIO based
> >>>>drivers like SPI, NAND, so it may be worth it as it doesn't impair
> >>>>readability (if anyone prefers, we could write  (1 << 31) >> i  instead
> >>>>of  0x80000000 >> i )
> >>>
> >>>1 << 31 is undefined behaviour, of course.
> >>
> >>Shall it be 1U << 31 ?
> >
> >Sure, that works.  "1 << (31 - i)" is most readable (but it doesn't yet
> >generate the code you want).
> 
> Euh .... I'm a bit lost. Do you mean the form we have today is the 
> driver is wrong ?

Heh, yes.  But is't okay with GCC, so don't worry about it.

The point is that "0x80000000 >> i" is less readable.


Segher
