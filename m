Message-ID: <3D78BC19.7000506@embeddededge.com>
Date: Fri, 06 Sep 2002 10:30:49 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Hans dot Feldt at uab.ericsson.se" <"Hans dot Feldt at uab.ericsson.se"@uab.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: immap_8260.h: volatile missing in immr definition
References: <200209061149.g86BnwH05287@wnaw252.uab.ericsson.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hans dot Feldt at uab.ericsson.se wrote:

> Change from: extern immap_t *immr:
> to: extern volatile immap_t *immr;

Rather than do this, I would prefer you use a function local variable
and load the global immr into it.  You should also get into the habit
of using barrier operations between such I/O accesses that must be
properly ordered.  The global volatile declaration isn't sufficient
to enforce ordered operations.  You just got lucky this time.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
