From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Cc: <paulus@samba.org>
Subject: Re: tlbia and PPC603
Date: Wed, 19 Jun 2002 05:10:37 +0200
Message-Id: <20020619031038.28719@smtp.wanadoo.fr>
In-Reply-To: <20020619201733E.ekato@ees.hokudai.ac.jp>
References: <20020619201733E.ekato@ees.hokudai.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, after more investigations it appears that:

 - There is no tlbia on 603. Actually, tlbia is #defined in the
kernel to be a loop of tlbie's

 - According to the PEM, tlbie requires a context synchronizing
instruction _before_, and a context sync. or a plain "sync"
instruction _after_. We did have the later but lacked the former
in our _tlbia function (though we did have it in our _tlbie
implementation).

So the proper fix, according to the spec, would be to just replace
the sync we currently do before with an isync. I've updated my rsync
with such a fix, can you confirm it works ?

If it's stable this way, i'll push the fix to the bk trees and
to Marcelo.

I'm not completely sure if we should or shouldn't keep the sync
around. We might have a pending store, I'm not too sure how it may
be affected by the tlbia and if the isync is enough to sync it.
For now, I removed it, but I would like someone from IBM or moto
to speak up here.

That's all for the 603. However, for the hashtable based CPUs, I
noticed we don't have strict context sync. neither before doing
tlbie's in the hash table management code (flush_hash_page,
add_hash_page, and hash_page). The hash miss code path might not
be a problem as the exception itself should be context synchronizing,
but I'm worried about add_hash_page() and flush_hash_page(). The
former is supposed to only add a valid HPTE where none existed, and
whatever may get evicted doesn't really become invalid, so I don't
think there is much risk here. flush_hash_page() should be used only
on a mapping that is beeing teared down; so I don't expect much
pending stores to it neither. But still, I would like advice from
some expert here...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
