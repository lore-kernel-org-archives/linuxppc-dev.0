Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvMy83TtMzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 11:36:48 +1100 (AEDT)
Date: Fri, 31 Mar 2017 11:36:45 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, xinhui.pan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 2/3] powerpc/xmon: drop the nobt option from xmon plus
 minor fixes
Message-ID: <20170331003645.GA12861@fergus.ozlabs.ibm.com>
References: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
 <20170322192751.30531-3-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170322192751.30531-3-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 22, 2017 at 04:27:50PM -0300, Guilherme G. Piccoli wrote:
> The xmon parameter nobt was added long time ago, by commit 26c8af5f01df
> ("[POWERPC] print backtrace when entering xmon"). The problem that time
> was that during a crash in a machine with USB keyboard, xmon wouldn't
> respond to commands from the keyboard, so printing the backtrace wouldn't
> be possible.
> 
> Idea then was to show automatically the backtrace on xmon crash for the
> first time it's invoked (if it recovers, next time xmon won't show
> backtrace automatically). The nobt parameter was added _only_ to prevent
> this automatic trace show. Seems long time ago USB keyboards didn't work
> that well!

Xmon still can't use a USB keyboard.  It's not a question of how well
USB keyboards work, it's that having a non-interrupt-driven USB stack
with (at least) an OHCI host controller driver and a keyboard driver
in xmon is impractical.

Paul.
