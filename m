Message-ID: <3E64AB2B.6030804@embeddededge.com>
Date: Tue, 04 Mar 2003 08:33:31 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Daniel Jacobowitz <drow@false.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
References: <IGEFJKJNHJDCBKALBJLLIEMEFKAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I and Daniel discussed it, mostly in private. It fails horribly for
> me too in user space(init hangs, don't know any details) and that's why
> I split copy_tofrom_user into 2 functions( see yesterdays mail) as a test. With that
> change my system is stable.

Well, I suspect it's luck more than stable. :-)

I suggest you debug the failure cases and determine what is really
wrong.  We know from past history that the cache instructions on 8xx
are troublesome and if we avoid them the system is truly stable.  The
execution of the cache instructions is identical whether you are using
them on kernel or user pages, the main difference is you are more likely
to hit TLB refill/update cases when using user space pages, exactly
one of the problem triggers.  If it's working on kernel pages and not
user pages, or some other combinations, you are just being lucky.  The
cache instructions will do the right thing if the mapping is present
in the TLB (and you don't get a write/update miss) and the page is
cached.  If you don't have the page cached or you get any TLB exception
the results are unpredictable and the result varies depending upon
silicon revision.

This is something that is difficult to debug and we can't dismiss this
with a solution of different copy functions.  The clear/copy functions
for the 8xx should be identical to all other PowerPC cores, and if they
don't work that way we need to determine why.  At least you have the
knowledge that these instructions are troublesome.  It took me many months
to discover this the first time, and perhaps they still misbehave.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
