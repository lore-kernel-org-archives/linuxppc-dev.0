Date: Thu, 21 Feb 2002 11:56:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patch to make ppc_md.progress useful on 4xx
Message-ID: <20020221005647.GA19976@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Currently, ppc_md.progress on 4xx just does a printk(), which means
its messages won't be displayed until console_init() at which point
it's usually too late to be useful.

The patch below changes ppc4xx_progress() to write directly to the
serial port.  I'd like to get comments before pushing the change,
because I don't want to break 4xx machines that I don't have (and so
can't test).

At the moment it should only affect 405GP.  NP405H and NP405L support
should be trivial (I've only refrained from adding it because I can't
test it myself).  STBxxxx should be possible but will be much
yuckier.  It would be nice to have it work on all 4xx though, to get
rid of the nasty #ifdef in ppc4xx_setup.c.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
