Message-ID: <3DC5D6CC.6010905@embeddededge.com>
Date: Sun, 03 Nov 2002 21:09:16 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dc* (Data Cache)  instructions in mem*() and *_page() functions
 not used on 8xx
References: <IGEFJKJNHJDCBKALBJLLAEIPFHAA.joakim.tjernlund@lumentis.se> <3DC2BAD9.5020907@embeddededge.com> <002501c281dc$c92182c0$0200a8c0@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I don't follow you here, do you need to do all this for a modern(>=D4) 8xx CPU?

Yes.  On "working" silicon, the dcbz (among others) requires special
processing.....probably enough to ensure it costs more to use this
instruction in a general purpose case.

> I hope not, but something needs to be done since copytofrom_user does not
> work for me.

What do you mean it doesn't work?  It should work fine if you don't
try to use the dcbz.  That is, leave the code alone.  The bigger problem
is the newer glibc library has to be modified to conditionally not use
this as well.

> The same resoning goes for the new option. If you have a new enough(>=D4) CPU,
> then you can enable this optimization(I think?!).

I don't know.  Linux is the only OS that will cause VM faults on a dcbz,
maybe it will never work.  Until someone verifies it works on the newer
silicon we can't assume it will.  This certainly isn't a reason to not use
the processor or not ship products.......

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
