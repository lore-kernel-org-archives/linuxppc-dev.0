Date: Thu, 20 Jun 2002 13:15:41 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Etsushi Kato <ekato@ees.hokudai.ac.jp>,
	<linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>
Subject: Re: tlbia and PPC603
In-Reply-To: <20020619031038.28719@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0206201256050.27936-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 Jun 2002, Benjamin Herrenschmidt wrote:

>
> Ok, after more investigations it appears that:
>
>  - There is no tlbia on 603. Actually, tlbia is #defined in the
> kernel to be a loop of tlbie's
>
>  - According to the PEM, tlbie requires a context synchronizing
> instruction _before_, and a context sync. or a plain "sync"
> instruction _after_. We did have the later but lacked the former
> in our _tlbia function (though we did have it in our _tlbie
> implementation).
>
> So the proper fix, according to the spec, would be to just replace
> the sync we currently do before with an isync. I've updated my rsync
> with such a fix, can you confirm it works ?

IMHO, this can't be the problem. A sync synchronizes the memory queues so
it should work with either.

>
> If it's stable this way, i'll push the fix to the bk trees and
> to Marcelo.
>
> I'm not completely sure if we should or shouldn't keep the sync
> around. We might have a pending store, I'm not too sure how it may
> be affected by the tlbia and if the isync is enough to sync it.
> For now, I removed it, but I would like someone from IBM or moto
> to speak up here.

If the processor is not buggy (sadly a big if on PPC it seems) an isync
will not allow the following instructions to be executed until after all
the previous instructions have got past the point where they can produce
exceptions, of course this includes TLB faults. After this point the store
is considered committed, the data may still be in a store queue along with
its physical address for cache reloads, etc..., but the only possible
remaining exception is a machine check.

> That's all for the 603. However, for the hashtable based CPUs, I
> noticed we don't have strict context sync. neither before doing
> tlbie's in the hash table management code (flush_hash_page,
> add_hash_page, and hash_page). The hash miss code path might not
> be a problem as the exception itself should be context synchronizing,
> but I'm worried about add_hash_page() and flush_hash_page(). The
> former is supposed to only add a valid HPTE where none existed, and
> whatever may get evicted doesn't really become invalid, so I don't
> think there is much risk here.

Do we actually do the tlbie if somebody munmaps the evicted page and we
find that the entry is not present in the hash table ?

If not, a tlbie on the preceding valid virtual address is necessary.
Rebuilding the virtual address from the previous first word of the hash
table is trivial.

And I'd certainly prefer to have the guarantee that the TLB are always
a strict subset of the hash table. I don't believe that trying to allow
such dangling TLB entries has any advantage.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
