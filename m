In-Reply-To: <40A4C04A.8060508@intracom.gr>
References: <40A38968.6060701@intracom.gr> <40A4C04A.8060508@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F8A7B640-A5F0-11D8-9559-003065F9B7DC@embeddededge.com>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Tom Rini <trini@kernel.crashing.org>, Wolfgang Denk <wd@denx.de>,
	sanjeevr@myw.ltindia.com,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] Driver for FECs on motorola DUET (87x/88x)
Date: Fri, 14 May 2004 17:52:18 -0400
To: Pantelis Antoniou <panto@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 14, 2004, at 8:49 AM, Pantelis Antoniou wrote:

> Any mm hackers over there have any idea?

I have some ideas.  There are some "generic" functions
doing some lazy processing that isn't likely to be valid
on the 8xx, in particular the way demand zero pages
are handled.  Anyway, that's as far as I've traced it.
Sometimes it appears to work, but it could be that what
is happening still isn't correct, it just doesn't crash/hang.
There are few other things that caught my attention where
we used to execute generic PPC MM code without any
ill side effects, but when these were ported to 2.6 we
are now doing the wrong things on the 8xx.  We just have
to work our way though it with some applications and
testing.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
