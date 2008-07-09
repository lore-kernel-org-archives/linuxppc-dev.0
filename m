Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F1ADDE23D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 23:22:13 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69DMACN023940
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 09:22:10 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m69DMAGj223180
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 09:22:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m69DM9ck008610
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 09:22:09 -0400
Date: Wed, 9 Jul 2008 09:18:46 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Updates to powerpc.git
Message-ID: <20080709091846.69b08e34@zod.rchland.ibm.com>
In-Reply-To: <1215588881.8970.358.camel@pasglop>
References: <1215588881.8970.358.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 Jul 2008 17:34:41 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I've pushed some updates to my version of powerpc.git.
>=20
> The tree itself is at:
>=20
> =EF=BB=BF  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>=20
> It contains 3 branches:
>=20
>   - merge  : this is for merging with the current stable and doesn't
>              currently contain anything interesting
>=20
>   - master : this is our current "powerpc.git" tree, it may contain
>              various experimental stuff that may or may not go upstream
>              or may contain dependent patches that we rely on but that
>              are to be merged via some other tree.
>=20
>   - next   : this is the candidate stuff for linux-next and the next
>              merge window
>=20
> (Andrew, you -may- want to pull that instead of paulus one until
> he's back from vacation).
>=20
> Until today, master and next pointed to the same commit, which was
> the same as paulus master and powerpc-next branches. Tonight, I've
> pushed some patches to master that I intend to have in next, but
> I'd like to let them sit in master for a couple of days to make sure
> nothing is badly broken mostly and make sure I didn't screw up in
> my various patch monkeying operations.

One thing to point out is that if you decide to only select a few of
those patches, you'll need to cherry-pick them into your next branch
(or rebase). That means that when you pull from Linus into your master
branch during/after the merge window, you'll get all kinds of funny
merge commits.

If you want to use your master branch as a place for experimental
stuff, that's fine by me.  But you'll want to keep next separate from
it so it's as "clean" as possible for those trying to track what is
definitely going into the next release.

If it were up to me (which it's not), I would have master just track
Linus, next track what's going into the next release, and "bleeding" or
"experimental" track stuff that isn't fully vetted yet.  I might start
doing that with my tree in the very near future.

Also, Paul is pretty good about not rebasing his branches when at all
possible, and I suspect that's why his master and next were often the
same.  It makes life lots easier for the sub-maintainers and anyone
trying to track against the tree.  I humbly beg you to keep that going.

josh
