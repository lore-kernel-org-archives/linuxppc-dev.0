Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cgH22XCTzF1Q0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 15:16:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback from
 console code
In-Reply-To: <20180430145558.4308-5-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
 <20180430145558.4308-5-npiggin@gmail.com>
Date: Fri, 04 May 2018 15:16:37 +1000
Message-ID: <87muxg80ga.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Use the more refined and tested event polling loop from opal_put_chars
> as the fallback console flush in the opal-kmsg path. This loop is used
> by the console driver today, whereas the opal-kmsg fallback is not
> likely to have been used for years.
>
> Use WARN_ONCE rather than a printk when the fallback is invoked to
> prepare for moving the console flush into a common function.

Do we want to add a WARN in that path? If we're panicking things might
get worse if we WARN (which takes a trap).

cheers
