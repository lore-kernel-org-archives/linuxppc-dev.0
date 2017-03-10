Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfnnQ4kyMzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2017 00:15:38 +1100 (AEDT)
Date: Fri, 10 Mar 2017 07:06:30 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: sysdev: cpm1: Optimise gpio bit calculation
Message-ID: <20170310130630.GH31469@gate.crashing.org>
References: <20170309094206.A832167992@localhost.localdomain>
 <87a88tle0y.fsf@concordia.ellerman.id.au>
 <534d8795-ce21-9af6-498d-22597213a3a2@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <534d8795-ce21-9af6-498d-22597213a3a2@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 10, 2017 at 11:54:19AM +0100, Christophe LEROY wrote:
> gpio_get() and gpio_set() are used extensively by some GPIO based 
> drivers like SPI, NAND, so it may be worth it as it doesn't impair 
> readability (if anyone prefers, we could write  (1 << 31) >> i  instead 
> of  0x80000000 >> i )

1 << 31 is undefined behaviour, of course.


Segher
