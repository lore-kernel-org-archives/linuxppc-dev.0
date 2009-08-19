Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CB898B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 21:24:40 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id E840FDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 21:24:39 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so953880fga.16
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 04:24:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090819115301.563be6da@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.00.0908190022570.3361@localhost.localdomain>
	<DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
	<7099.1250674686@redhat.com>
	<20090819115301.563be6da@lxorguk.ukuu.org.uk>
Date: Wed, 19 Aug 2009 13:16:48 +0200
Message-ID: <c384c5ea0908190416r4e0b5508x4765381888516484@mail.gmail.com>
Subject: Re: spin_is_locked() broken for uniprocessor?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
	Linux-Kernel List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, Aug 19, 2009 at 12:53 PM, Alan Cox<alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 19 Aug 2009 10:38:06 +0100
>
> in drivers because there is driver code that uses spin_is_locked() in
> fairly sensible fashion when dealing with locking.
>
One use is to measure lock contention hits on a particular spin lock.


However I wonder if there are tracing capabilities to measure lock
contention on a particular lock?

Currently I have inserted code much like this to get a feeling on the
contention:

this_cpu = get_cpu();
put_cpu();
contention = spin_is_locked(&lock);
spin_lock*(&lock);
if (contention) {
  /* spin lock was contended, prev_cpu, this_cpu */
  /* no hard guarantee, as we had a possible race inbetween
is_locked() and lock(), but works for driver/irq spin lock */
}

/* critical section */

prev_cpu = this_cpu;
spin_unlock*(&lock);

Regards,
-- 
Leon
