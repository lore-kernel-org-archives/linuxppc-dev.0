From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lars Brinkhoff <lars@nocrew.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Linux 2.4 on 2001 G4
Date: Tue, 10 Apr 2001 10:54:07 +0200
Message-Id: <20010410085407.26331@mailhost.mipsys.com>
In-Reply-To: <85puelrwck.fsf@junk.nocrew.org>
References: <85puelrwck.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It seems to hang in smp_core99_kick_cpu(), probably when the CPU takes
>the exception.  I inserted some debug messages around the call to
>mdelay() like so:
>
> if (ppc_md.progress) ppc_md.progress("!", 0);
> mdelay(1);
> if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu: after
mdelay", 0);
>
>When booting, "!" is printed, but the other message is not.
>
>Is there anything else I can do to diagnose the problem?

I beleive it hangs in the second CPU entry point in head.S. My new CPU
identification & setup mecanism was not tested on SMP yet, so I beleive
it still has bugs. I'll look into this today or later this week.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
