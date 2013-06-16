Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8444F2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 13:39:59 +1000 (EST)
Message-ID: <1371353865.21896.94.camel@pasglop>
Subject: Re: [PATCH -V10 00/15] THP support for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 16 Jun 2013 13:37:45 +1000
In-Reply-To: <1371348007.21896.62.camel@pasglop>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1371348007.21896.62.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrea Arcangeli <aarcange@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-16 at 12:00 +1000, Benjamin Herrenschmidt wrote:
> So at this point, hash_page might *still* see the old pmd. Unless I
> missed something, you did nothing that will prevent that (the only way
> to lock against hash_page is really an IPI & wait or to take the PTE's
> busy and make them !present or something). So as far as I can tell,
> a concurrent hash_page can still sneak into the hash some "small"
> entries after you have supposedly flushed them.

Note that the _PAGE_PRESENT bit is removed eventually ... but much
later, in __collapse_huge_page_copy() which will also flush the hash, so
at least we will remove a stale hash entry that would have been added by
the race above I suppose...  but:

 - _PAGE_ACCESSED can still potentially be set after it was supposed to
be stable

 - The clearing happens *after* copy_user_highpage(), ie, unless I
missed something here, we potentially still have something writing to
the 4k page while it's being copied, which is BAD.

Now, let me know if I did miss something here :-)

Cheers,
Ben.
