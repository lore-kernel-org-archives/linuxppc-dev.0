To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux 2.4 on 2001 G4
References: <857l0utbu5.fsf@junk.nocrew.org>
	<20010409160621.12920@mailhost.mipsys.com>
From: Lars Brinkhoff <lars@nocrew.org>
Date: 10 Apr 2001 10:29:47 +0200
In-Reply-To: <20010409160621.12920@mailhost.mipsys.com>
Message-ID: <85puelrwck.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> >How is the SMP support for the Dual 533MHz G4 in your tree?
> It should work but some of my latest stuffs were not tested on SMP

It seems to hang in smp_core99_kick_cpu(), probably when the CPU takes
the exception.  I inserted some debug messages around the call to
mdelay() like so:

 if (ppc_md.progress) ppc_md.progress("!", 0);
 mdelay(1);
 if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu: after mdelay", 0);

When booting, "!" is printed, but the other message is not.

Is there anything else I can do to diagnose the problem?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
