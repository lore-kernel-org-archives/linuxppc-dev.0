From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Quad SMP on G4
Date: Tue, 17 Apr 2001 15:16:11 +0200
Message-Id: <20010417131611.2955@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10104171421420.11443-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10104171421420.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>How do you lock something in the _TLB_ ?
>
>Avoiding the removal/overwrite of some critical hashtable entries is fine,
>but you can't prevent any TLB entry from being purged by replacement HW.

Right, you can't lock on 6xx/7xx (well, maybe on 603 ?), I was thinking
about the hash table in fact.

>From an earlier discussion with Paul, I think the problem is in
flush_hash_segments, which must not flush anything used by the
flush_hash_segments routine itself
(so the kernel code and datas used by flash_hash_segments must be sticky).

This problem can't happen when using BATs for kernel memory obviously.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
