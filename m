From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: nall <nall@themountaingoats.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ifdef in asm/atomic.h
Date: Tue, 9 Jul 2002 11:48:16 +0200
Message-Id: <20020709094816.5908@192.168.4.1>
In-Reply-To: <1026183653.15084.43.camel@reykjavik.themountaingoats.net>
References: <1026183653.15084.43.camel@reykjavik.themountaingoats.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>in /usr/src/linux/include/asm-ppc/atomic.h, an #ifdef __KERNEL__
>surrounds the contents of the file. this causes the GNU CommonC++ build
>to break on ppc (it wants to use atomic_* functions). i looked at the
>asm-i386/atomic.h, and it has no #ifdef __KERNEL__ guard. is there a
>reason ppc should have this and i386 should not? if you're not the right
>person to ask about this, sorry for the inbox clutter. just point me in
>the right direction.

Well, it was decided that userland should not rely on kernel implementation
of such functions, but rather re-implement it's own.

If you look at the atomic functions, you'll notice several problems if
you try to use them from userland

 - the use of the SMP_ISYNC macro which depends on kernel config
   options
 - in 2_4_devel, the use of PPC405_ERR77 macro, which also depends
   on kernel config options
 - some of them might not be inlined (atomic_set/clear_mask) though
   that should probably be fixed

You should probably re-implement them the "safest" way, that is using all
of the additional workarounds the kernel does (based on what the
linuxppc_2_4_devel tree does).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
