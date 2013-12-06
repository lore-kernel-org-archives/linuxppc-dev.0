Return-Path: <scottwood@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 303BE2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 06:10:12 +1100 (EST)
Message-ID: <1386356996.7375.120.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc 8xx: Loading kernels over 8Mbytes without
 CONFIG_PIN_TLB
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Fri, 6 Dec 2013 13:09:56 -0600
In-Reply-To: <20131127110406.6DC8E1A504F@localhost.localdomain>
References: <20131127110406.6DC8E1A504F@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-27 at 12:04 +0100, Christophe Leroy wrote:
> Today, the only way to load kernels whose size is greater than 8Mbytes is to
> activate CONFIG_PIN_TLB. Otherwise, the physical memory initially mapped is
> limited to 8Mbytes. This patch sets up 24 Mbytes of initial memory regardless
> of whether CONFIG_PIN_TLB is active or not. It allows to load "big" kernels
> (for instance when activating CONFIG_LOCKDEP_SUPPORT) without having
> to activate CONFIG_PIN_TLB.

So, what happens on boards with less than 24M memory present?  Even if
you avoid explicitly referencing those addresses, what if there is a
speculative access -- or does 8xx not do that?

-Scott
