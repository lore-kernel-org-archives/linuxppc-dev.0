From: Benjamin Herrenschmidt <bh40@calva.net>
To: Adrian Cox <apc@agelectronics.co.uk>, Gabriel Paubert <paubert@iram.es>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PATCH: improved processor config for G3s
Date: Mon, 4 Sep 2000 12:54:46 +0200
Message-Id: <20000904105446.26517@mailhost.mipsys.com>
In-Reply-To: <39B37AD2.120E2DE7@agelectronics.co.uk>
References: <39B37AD2.120E2DE7@agelectronics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> A rule of thumb is the following: fully SMP capable processors broadcast
>> eieio (and tlbie for that matter), others do not at least by default. On
>> an UP 750 (SMP 750 are an aberration in any case because of TLB issues),
>> I'd bet that it is more efficient to let the processor perform store
>> gathering when it can (an eieio between both stores will prevent it) and
>> to disable both ABE in the processor and store gathering in the bridge.
>> This will result in lower processor bus utilization.
>
>Remember that the processor store gathering is only capable of turning
>two 32-bit writes to uncached, nonguarded space into one 64-bit write.
>The bridge store gathering converts an arbitrary sequence of sequential
>writes into a PCI burst.
>
>The bridge store gathering should be able to produce far more IO
>improvement, and still works if the guard bit is set on the address
>space.
>
>I should have done a set of MPC107 experiments by the start of October,
>and I'll know for sure then.

Also, are you sure, Gabriel, that eieio() not beeing broadcast to the
bridge would harm ? The bridge is not allowed to do any re-ordering.
Maybe there are issues with devices not supporting burst access to
registers, but shouldn't those devices abort the burst after the first
access ?

Drivers sensitive to timing constraints must already do a read to flush
the bridge buffer, so...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
