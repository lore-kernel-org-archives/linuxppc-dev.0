Message-ID: <38A1008D.BB560C55@netx4.com>
Date: Wed, 09 Feb 2000 00:52:13 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Peter Allworth <linsol@zeta.org.au>
CC: Jesper Skov <jskov@redhat.com>, linuxppc-embedded@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: more Re: Low memory problems in 8xx Linux
References: <20000201235813.4F5611B51A@elph.research.canon.com.au> <38977960.40E014A1@zeta.org.au> <ot1z6of1ws.fsf@thinktwice.zoftcorp.dk> <38A0BED6.AD2E336C@zeta.org.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a note to let you guys know you are getting just a little
carried away here.....

You are placing things in the TLB specific handler that are
supposed to be handled generically in places like arch/ppc/mm/fault.c.

Yes, it may be a little bit of a speed improvement, but you
are placing code in the TLB miss handler that logically should
be executed as part of the TLB Error handler.  In some cases,
it is appropriate to store something in the TLB that will cause
a subsequent fault into the TLB Error handler (i.e. a pte that
doesn't look valid).  If you continue down this path, you will
end up exceeding the space allocated for the trap handler, and
simply re-implement code found elsewhere.

While some of the updates are genuine bugs that should be corrected,
some of the other stuff isn't proper, so don't be surprised when
it doesn't show up in the real kernel sources.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
