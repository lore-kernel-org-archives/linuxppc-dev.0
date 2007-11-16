Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6A24DDDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 18:39:11 +1100 (EST)
Date: Fri, 16 Nov 2007 01:40:25 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix 44x Machine Check handling
Message-ID: <20071116074025.GA4741@lixom.net>
References: <20071116072149.350ADDDDF4@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071116072149.350ADDDDF4@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 16, 2007 at 06:21:06PM +1100, Benjamin Herrenschmidt wrote:
> This removes the old CONFIG_440A which was a pain for multiplatform
> kernel and wasn't set properly by default and replaces it with a
> CPU feature. This makes Machine Check reporting work correctly on
> my Ebony (440GP) board.

I'm not sure I like this. It introduces another cpu feature flag,
that we'll soon run out of if it's used to signify version info per
implementation like this.

1) The SET_IVOR could be done from the cpu_setups for 440A instead
(i.e. introduce one).

2) Please just move the machine check handlers out to individual ones
instead of using the generic one. That way you don't need runtime checks
between the two (they don't seem to share much of it as-is anyway).

With the above two changes, you shouldn't need the feature bit any more.


-Olof
