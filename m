From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15971.61695.795360.163200@argo.ozlabs.ibm.com>
Date: Tue, 4 Mar 2003 11:19:11 +1100
To: Dan Malek <dan@embeddededge.com>
Cc: joakim.tjernlund@lumentis.se,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
In-Reply-To: <3E63C905.5000306@embeddededge.com>
References: <IGEFJKJNHJDCBKALBJLLOEKGFKAA.joakim.tjernlund@lumentis.se>
	<3E63C905.5000306@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> And don't forget....many applications aren't heavily 'copy-centric' and it
> may be beneficial to not blow away the caches in those cases.  That is, if

Using dcbz on the destination won't blow away the caches any more than
doing the copy without dcbz would anyway.

The thing you have to be careful of when using dcbz, particularly when
you are dbcz'ing one or more cache lines ahead, is that you only dcbz
cache lines that are completely contained within the destination area.
That introduces extra complexity and makes the code bigger, so you
have to be careful that you don't make small copies slower.

I did some measurements once and found that almost all of the copies
in the kernel (memcpy and copy_tofrom_user) were either relatively
small, i.e. less than 256 bytes, or were page-sized and page-aligned.
In the optimized copy routines I did in the ppc64 kernel.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
