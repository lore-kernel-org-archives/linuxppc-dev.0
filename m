Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>,
	"Tom Rini" <trini@kernel.crashing.org>
Cc: "Daniel Jacobowitz" <drow@false.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: RE: Improved copy_page() function, about 30% speed up for mpc860!
Date: Tue, 4 Mar 2003 23:01:59 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLEEMPFKAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E64DB91.4050508@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
> Joakim Tjernlund wrote:
>
> > Does this workaround also work for dcbz on kernel addresses?
>
> It may, depending upon the silicon revision. :-)
>
> IIRC, the real reason for this code is to work around errata in
> some silicon versions where the DAR isn't loaded  properly.  In
> addition, this also helps when we use kernel debuggers for setting
> breakpoints when the text area is write enabled.

I can't find any further info about this bug/workaround. There is nothing in
linux that indicates that the workaround is dependant on any revision.
Further, dcbi and dcbz are pretty similar in behavior w.r.t TLB error so
I suspect that if this works for dcbi it also works for dcbz, only
on kernel addresses though.

Maybe user space also can be fixed with instruction decoding
as Daniel said even if it's ugly. Then you would not have to worry about
apps/libs using dcbz, at least it would work but perhaps the performance sucks

Tom, can you shed some light on this? The BK log lists you as the one
who committed this change.

> If nothing else, you are learning more than you bargained for. ;-)

Definitly :-)

 Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
