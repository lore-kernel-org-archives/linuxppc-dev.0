From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: i8259.c spinlocks unnecessary
Date: Sat, 29 Jun 2002 15:55:42 +0200
Message-Id: <20020629135542.31287@192.168.4.1>
In-Reply-To: <20020628152929.K3851@host110.fsmlabs.com>
References: <20020628152929.K3851@host110.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I looked through the 8259 code and I believe the spinlocks there are
>unnecessary.  The code is covered by a spinlock when called from irq.c.
>
>I instrumented the code and after running quite some time my code review
>matches what I've seen.
>
>Anyone comment?  Does someone want to remove them?

irc.c don't have a global spinlock, only per-desc locks, so you can well
have one CPU dealing with an incoming interrupt and another CPU doing
a disable/enable_irq() on a different interrupt at the same time for
example. My understanding is that i8259 should be protected against
such races.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
