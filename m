From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddy Raineri <eraineri@axiom-tx.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Quad SMP on G4
Date: Mon, 16 Apr 2001 19:01:58 +0200
Message-Id: <20010416170158.17749@smtp.wanadoo.fr>
In-Reply-To: <000d01c0c68c$b65be250$3e03a8c0@dnaent.com>
References: <000d01c0c68c$b65be250$3e03a8c0@dnaent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>4)  One more simple question.  I'm unclear as to which 2_4 version I should
>pull from I have been using the linuxppc_2_4 kernel and not linus' is this
>correct?  I'm trying to stay current on the PPC fixes for the 2_4 kernel.  I
>am assuming that any fixes Linus makes to the kernel will be put into the
>linuxppc_2_4 version however any fixes made in general by the PPC group
>might not make it into the Linus version.
>
>I apologize if this is repeated.  I'm trying desperately to find the
>resources necessary for me to stay informed but may have not found it yet.
>

The linuxppc_2_4 is the current kernel for PPC, yes. It contains the
latest PPC fixes and Linus patches are regulary merged in (it's currently
at 2.4.4pre3).

As far as you lock problem is concerned, I can't help you. All I can say
for now is that it workes well on other SMP machines like the Apple dual
G4, so this makes me think you might have a bus arbitration problem.

Also, do you have the kernel BAT mapped or did you remove that optim ?
I'm not too sure the hash table code is very safe to run without this.
I beleive that without the BAT mapping, the code & data that are
touched when the hash table lock is held should be locked in the TLB as
well to avoid deadlocks.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
