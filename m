Date: Tue, 5 Mar 2002 16:06:42 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200203060006.g2606g123689@xdr.com>
To: bcrl@redhat.com
Subject: Re: mmap wrapping around to 0 revisited
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Wrong fix.  sys_mmap on ppc should really be using do_mmap which already
>includes the cast to unsigned long and checks for overflow.  Arguably,
>it could well check for -'ve offsets and reject them, but traditionally
>Linux has accepted up to 4GB offsets with its 32 bit APIs and changing
>this would break a few things like X.
>
>                -ben


In older versions (like 2.4.2-hhl) the sys_mmap did go through do_mmap, but
for some reason that was changed. The do_mmap itself is broken, the check
for overflow is like this:
	if ((offset + PAGE_ALIGN(len)) < offset)
		goto out;

It should be:
	if ((offset + PAGE_ALIGN(len)-1) < offset)
		goto out;

So: changing sys_mmap to go through do_mmap won't fix the problem unless
the above fix is done to do_mmap.

do_mmap appears to be defunct, and the new method seems to be more standard
across architectures. The problem was as I stated, and the fix I presented
is the best one.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
