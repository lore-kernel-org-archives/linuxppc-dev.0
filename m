Message-ID: <40B1FB42.1040306@intracom.gr>
Date: Mon, 24 May 2004 16:40:18 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Tom Rini <trini@kernel.crashing.org>, Wolfgang Denk <wd@denx.de>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Driver for FECs on motorola DUET (87x/88x)
References: <40A38968.6060701@intracom.gr> <40A4C04A.8060508@intracom.gr> <F8A7B640-A5F0-11D8-9559-003065F9B7DC@embeddededge.com>
In-Reply-To: <F8A7B640-A5F0-11D8-9559-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> On May 14, 2004, at 8:49 AM, Pantelis Antoniou wrote:
>
>> Any mm hackers over there have any idea?
>
>
> I have some ideas.  There are some "generic" functions
> doing some lazy processing that isn't likely to be valid
> on the 8xx, in particular the way demand zero pages
> are handled.  Anyway, that's as far as I've traced it.
> Sometimes it appears to work, but it could be that what
> is happening still isn't correct, it just doesn't crash/hang.
> There are few other things that caught my attention where
> we used to execute generic PPC MM code without any
> ill side effects, but when these were ported to 2.6 we
> are now doing the wrong things on the 8xx.  We just have
> to work our way though it with some applications and
> testing.

I have made some progress...

I have ported the CPM UART driver by Kumar Gala to the 8xx.

It works correctly but still the same problem persists...

It correctly mounts the NFS root, and after the first write
by init it hangs.

By breaking in using my BDI2000 I see it stuck at default_idle.

Networking & interrupts appear OK, since I can still ping.

It seems that for some reason no user space scheduling takes place.

Apparently the scheduling is controlled by the _TIF_NEED_RESCHED
flag which is no where to be found in head_8xx.S.

Before I submerge into the assembly of head_8xx.S does anyone have any
ideas?

>
>     -- Dan
>
>
Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
