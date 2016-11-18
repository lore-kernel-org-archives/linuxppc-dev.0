Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKn8h1h24zDvtf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 16:48:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH 2/4] powerpc: kprobe: add arch specific blacklist
In-Reply-To: <e34af1637b3c190cc0f2e41131f2524e75720ed3.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <e34af1637b3c190cc0f2e41131f2524e75720ed3.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Fri, 18 Nov 2016 16:48:01 +1100
Message-ID: <87y40hgwz2.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Add symbol to mark end of entry_*.S and use the same to blacklist all
> addresses from kernel start (_stext) to entry code from kprobes. Much of
> this code is early exception handling where we can't really take a trap.

I'm not sure about this. entry_*.S is actually a bit of jumble,
especially the 64bit version. I've been wanting to split it up for a
long time.

It doesn't actually contain any early exception handling. It does
contain the common syscall handler, and the exception return paths, some
of which should be black listed. And lots of other junk.

Also I'm not sure if it's guaranteed that there won't be other code
between _stext and the end of entry, it's not handled explicitly in the
linker script, it just tends to get linked early because it's in head-y.

So I think it would be better if we had a clearer picture of exactly
what in this file we want to blacklist.

cheers
