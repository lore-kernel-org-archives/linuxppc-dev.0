From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Rydh <samuel@ibrium.se>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: I-cache flushing on the 7400
Date: Sat, 31 Mar 2001 19:07:01 +0200
Message-Id: <20010331170701.14967@smtp.wanadoo.fr>
In-Reply-To: <20010331153031.A10946@ibrium.se>
References: <20010331153031.A10946@ibrium.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>did not work properly on a G4s (but it did work flawlessly on my G3).
>To make the i-cache flush effective, I had to insert an extra
>'sync' before the last isync. Consulting my Motorola manuals,
>the recommended sequence for the 7400 (but not for the 750) did have
>that extra sync. Looking at the 2.4.3-pre8 BK source, I discovered
>the 'sync' was sometimes missing (in flush_icache_range and in a
>few places in head.S). Shouldn't the sync really be added?

Well, if you had a problem without it and if moto says it's needed, then
I'd go for it, especially since it's not much overhead since this routine
is not used very often.

I'll push that to my tree asap and to bk soon.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
