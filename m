From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
	Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: CONFIG_PIN_TLB and telnet problems
Date: Tue, 4 Jun 2002 14:37:08 +0200
Message-Id: <20020604123708.13854@smtp.adsl.oleane.com>
In-Reply-To: <20020604122046.29082@mailhost.mipsys.com>
References: <20020604122046.29082@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>To add to these comments, I can reproduce the problem as well on a
>unix socket shared either between two processes, or read & written
>by a single process.
>
>After doing various tests, the problem appears rarely and randomly
>with half the RAM mapped with fixed TLBs, and very reproduceably
>with all the RAM mapped this way. So it seems that reducing the
>kernel pressure on TLBs, thus allowing userland TLBs to live much
>longer, exhibit the problem.
>
>I tried adding a call to _tlbia (not the instruction but our tlbwe
>based implementation) in set_context to make sure I only ever have
>one userland context loaded in the TLB and this appear to kill the
>problem (I'm currently running 2 offending test programs simultaneously
>on the box and none failed yet after a few Gb transferred).

Hrm... I added isync/sync (actually, the sync is probably too much)
to set_context() in head_4xx.S in order to invalidate the shadow TLBs
and it seems to work ! I'll test a few hours and let you know.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
