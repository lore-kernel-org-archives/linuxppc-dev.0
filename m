Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: dc* (Data Cache)  instructions in mem*() and *_page() functions not used on 8xx
Date: Tue, 29 Oct 2002 17:02:57 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLOEHIFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3DBEA8F9.8030304@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> >>I found that on 8xx these are not used. Why? Are there 8xx variants that can't handle them?
> >>Do 860 work with these?
>
> The TLB/Exception side effects of using these instructions in the 8xx varied
> with different silicon versions.  Rather than have a bunch of unique code for
> different silicon revisions (and in some cases the side effects didn't occur
> at all so the instructions couldn't be used) it is just easier to not use the
> instructions.  Any performance gained by using these instructions was lost
> in the special exception handling.

That figures, just out of curiosity I removed those restrictions in misc.S and
string.S on my 860, rev D4 to see what happened.
Result: It hung in init.
Now I exclude 8xx in __copy_tofrom_user in string.S.
Result: Now it works just fine.

It seems that even the newest 8xx chips still has problems. I did not expect that.

 Jocke

>
> >>Also, why is not dcbtst(write a cache line) used
>
> Because dcbtst performs a load operation on a line you know is going to
> replaced.  That generates unnecessary bus traffic and is why the dcbz is
> used instead.

OK, thanks.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
