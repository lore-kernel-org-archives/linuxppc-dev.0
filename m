From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: Gabriel Paubert <paubert@iram.es>
Subject: Tr: xtime_lock
Date: Fri, 19 Jul 2002 16:35:25 +0200
Message-Id: <20020719143525.3334@192.168.4.1>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm forwarding your message to linuxppc-dev mailing list

---------------- Début du message transmis ----------------
Sujet: xtime_lock
Envoyé: vendredi 19 juillet 2002 15:31
De: Jeroen T. Vermeulen <jtv@xs4all.nl>
À: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hi Ben,

I was just trying to learn a bit more about the kernel's locking
primitives and execution model, when I came across xtime_lock and your
comment about wanting to get rid of it (arch/ppc/kernel/time.c).

So here's my question: would it be feasible (and/or pointful) to replace
the xtime_lock in do_gettimeofday() by a simple optimistic approach?  If
the machine is fast enough compared to timer resolution, I imagine one
could just read the clock twice and compare the results to verify that
you got consistent data.  Of course whether that saves you any time is
another matter; perhaps it would make sense with SMP but not for
uniprocessor machines, or something.

A detail that could make it more feasible AFAICS is that you don't
need to re-read the least significant--and most volatile!--part of the
time value for the "second opinion" check, because you only get an
actual inconsistent result if there's been a rollover while you were
reading.  Or am I forgetting to take nonlinear clock changes into
account?  OTOH they mean you get weird results anyway...

Oh, and on a side note, why the loop to convert "superfluous" usecs to
secs?  Is this because the number of iterations is so low that the
conditional is faster than a division plus a remainder operation?

I mean

	while (usec >= 1000000) {
	  	sec++;
		usec -= 1000000;
	}

vs.

	sec += (usec / 1000000);
	usec %= 1000000;


----------------- Fin du message transmis -----------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
