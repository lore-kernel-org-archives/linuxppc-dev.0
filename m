From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hfs cdrom broken in 2.4.13pre
Date: Tue, 23 Oct 2001 21:59:16 +0200
Message-Id: <20011023195916.18893@smtp.wanadoo.fr>
In-Reply-To: <XFMail.20011023151612.pochini@shiny.it>
References: <XFMail.20011023151612.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> One would hope so. All I remember about CDROMs is they use a different
>> blocksize which causes all sorts of funny side effects in generic code
>> that assumes the only sane blocksize is 512.
>
>No. The point is that filesystems should not make assumptions about
>hardware block size (except it being power of 2 I believe). If there
>was code in block layer to provide broken FS's compatibility and that
>code has been removed, then we must fix the FS. Who's HFS maintainer ?
>
>> So mounting HFS CDROMs no longer panics ?
>
>They always worked fine for me.

I don't know if there's still an active HFS maintainer. That is not
the only bugs in HFS. Locking is broken and HFS can easily deadlock
on an SMP box. I've been reported disk corruption with it, and
experienced corrupted file when written from linux occasionally,
I suspect something must be wrong with btree rebalancing.

I have done some work on locking (replacing most broken spinlocks with
semaphores) but never really finished it. Most people rely on HFS tools,
not on the HFS fs. I don't have the time to work more seriously on it,
but it would be an interesting project for someone motivated, especially
since you now have Apple's implementation to use as a reference ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
