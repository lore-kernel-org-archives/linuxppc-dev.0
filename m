Message-ID: <19990511225354.65466@ibrium.se>
Date: Tue, 11 May 1999 22:53:54 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: jenschrr@uni-bielefeld.de
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mac-on-linux is now working...
References: <19990510213309.43528@ibrium.se> <3737E133.164A@post.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3737E133.164A@post.uni-bielefeld.de>; from Jens Ch. Restemeier on Tue, May 11, 1999 at 09:50:12AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, May 11, 1999 at 09:50:12AM +0200, Jens Ch. Restemeier wrote:
> Hi !
> 
> I'm currently downloading the source. Do you have any suggestions for
> starting 603 support? What are the differences that need to be fixed?
> 
> Jens

I think it is only the MMU code which needs to be fixed. 
All processors except the 603 uses a TLB hash table for
page table entries. Mac-on-linux accesses this table
directly in a few places.

If the line

  #define NO_RELOAD_HTAB 1

is changed to

  #define NO_RELOAD_HTAB 0

in 'arch/ppc/kernel/head.S' and 'arch/ppc/mm/init.c',
then the kernel emulates a TLB hash table. Possibly
this will do the trick. (I would also suggest careful 
examination of the register contents for the faked 
"DSI/ISI" exception).

Some more modifications are necessary if one want
the 603 to behave as a 603 (and not as a 604).
I can't see why one should want that though.

/Samuel

-- 

----------------------------------------------------------
  E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
    Phone/fax: (home) +46 4418431, (work) +46 7908470   
----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
