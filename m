Message-ID: <3E54544E.2040804@embeddededge.com>
Date: Wed, 19 Feb 2003 23:06:38 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: lmw and stmw instructions not used copy functions
References: <D73A25AA6E54D511AD74009027B1110F3C066A@ORION> <004f01c2d861$c6cdab30$020120b0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I noticed that the lmw and stmw instructions are not used in copy_page(), clear_page() etc.
> Aren't these instructions faster than a bunch of lwz/stw?

Motorola doesn't guarantee these are any faster, and most documentation indicates
they are likely to be slower.  If you look closely, you may notice that not
too many places can utilize these instructions, and often the load or store
is done to take advantages of some pipeline optimizations with comparisons
to values in well known registers.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
