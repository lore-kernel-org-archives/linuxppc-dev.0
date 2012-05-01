Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 78ECAB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2012 10:33:46 +1000 (EST)
Message-ID: <1335832418.20866.95.camel@pasglop>
Subject: Re: linux-next ppc64: RCU mods cause __might_sleep BUGs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Tue, 01 May 2012 10:33:38 +1000
In-Reply-To: <alpine.LSU.2.00.1204301451270.2986@eggly.anvils>
References: <alpine.LSU.2.00.1204301451270.2986@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-30 at 15:37 -0700, Hugh Dickins wrote:
> 
> BUG: sleeping function called from invalid context at include/linux/pagemap.h:354
> in_atomic(): 0, irqs_disabled(): 0, pid: 6886, name: cc1

Hrm ... in_atomic and irqs_disabled are both 0 ... so yeah it smells
like a preempt count problem... odd.

Did you get a specific bisect target yet ?

Cheers,
Ben.

> Call Trace:
> [c0000001a99f78e0] [c00000000000f34c] .show_stack+0x6c/0x16c (unreliable)
> [c0000001a99f7990] [c000000000077b40] .__might_sleep+0x11c/0x134
> [c0000001a99f7a10] [c0000000000c6228] .filemap_fault+0x1fc/0x494
> [c0000001a99f7af0] [c0000000000e7c9c] .__do_fault+0x120/0x684
> [c0000001a99f7c00] [c000000000025790] .do_page_fault+0x458/0x664
> [c0000001a99f7e30] [c000000000005868] handle_page_fault+0x10/0x30
> 
> I've plenty more examples, most of them from page faults or from kswapd;
> but I don't think there's any more useful information in them.
> 
> Anything I can try later on? 
