Date: Tue, 6 Nov 2001 18:47:17 -0700
From: Val Henson <val@nmt.edu>
To: Tom Rini <trini@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Heartbeat revisited
Message-ID: <20011106184716.A18004@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Y'all will recall the debate a few months ago about the proper
behaviour of the ppc_md.heartbeat function.  The conclusion was that
the heartbeat function should be run once on each cpu per hearbeat
interval.

Unfortunately, the solution made the interval between calls of the
heartbeat function dependent on the number of cpus in the system:

	if (ppc_md.heartbeat && !ppc_md.heartbeat_count--)
		ppc_md.heartbeat();

Since it decrements the heartbeat_count once per cpu per timer
interrupt.  If this is declared to be the desired and intended
behavior, I'll change Gemini to work around it.  Otherwise, I suggest
something like:

	if (ppc_md.heartbeat) {
		if (!smp_processor_id())
			ppc_md.heartbeat_count--;
		if (!ppc_md.heartbeat_count)
			ppc_md.heartbeat();
	}

Or the simpler and originally intended form that only executes on one CPU:

	if (ppc_md.heartbeat && !smp_processor_id() &&
	    !ppc_md.heartbeat_count--)
		ppc_md.heartbeat();

Also, you need to be careful to reset the heartbeat even if you aren't
executing the heartbeat function.  The last heartbeat discussion left
Gemini with a negative heartbeat count after a few calls of the
heartbeat function.

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
