Date: Fri, 21 Feb 2003 09:31:49 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: lmw and stmw instructions not used copy functions
In-reply-to: <3E54544E.2040804@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLGEHIFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I noticed that the lmw and stmw instructions are not used in copy_page(), clear_page() etc.
> > Aren't these instructions faster than a bunch of lwz/stw?
>
> Motorola doesn't guarantee these are any faster, and most documentation indicates
> they are likely to be slower.  If you look closely, you may notice that not
> too many places can utilize these instructions, and often the load or store
> is done to take advantages of some pipeline optimizations with comparisons
> to values in well known registers.

Did some crude benchmarking using clear_page() as my test function.
I made a version that uses stmw and compared that with the orginal
clear_page().

Result:
 The stmw version was much slower. When I increased the number of
 bytes to copy per loop to 32, it became as fast as the orginal.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
