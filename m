Mime-Version: 1.0
Message-Id: <v04205405b394c1fe1645@[209.239.164.131]>
In-Reply-To: <19990621230921.A20471@drow.res.cmu.edu>
References: <Pine.LNX.4.04.9906212045480.27642-100000@narn.local.drgw.net>
 <Pine.LNX.3.96L.990621222014.5237C-100000@unix47.andrew.cmu.edu>
 <19990621230921.A20471@drow.res.cmu.edu>
Date: Mon, 21 Jun 1999 21:36:58 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Peter Chang <weasel@cs.stanford.edu>
Subject: Re: dl-load.c (ld.so) bug??
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 23:09 -0400 06.21.1999, Daniel Jacobowitz wrote:
>On Mon, Jun 21, 1999 at 10:48:12PM -0400, Hollis R Blanchard wrote:
> >
> > > No. Electric Fence is designed to catch programming errors, such as
> > > attempting to access memory which was not 'malloc'ed. I have traced this
> > > down extensively a couple of months ago, and found that it does indeed
> > > appear to overrun what it malloced.
> >
> > I have two even simpler test cases for you:
> >
> > int main(void){
> >     char *ptr=NULL;
> >     free(ptr);
> > }
>
>Well, that one would probably segfault anyway (or at least, is not
>guaranteed not to).

Hmm... the docs taht I have say this:

2 The free function causes the space pointed to by ptr to be 
deallocated, that is, made
available for further allocation. If ptr is a null pointer, no action 
occurs. Otherwise, if
the argument does not match a pointer earlier returned by the calloc, malloc,or
realloc function, or if the space has been deallocated by a call to 
free or realloc,
the behavior is undefined.

> > int main(void){
> >     char *ptr = (char *)malloc(100);
> > }
>
>That one's a problem, though :)

Why? Its allocating memory, but never freeing it. Its a leak, but not 
accessing things out of bounds. I haven't used ElectricFence, but its 
not going to catch a bounds error on this.

> > If this were the case, wouldn't you expect ridiculous levels of 
>instability?
>
>Depends entirely on what it overwrote.

Especially, if the malloc (like most) was sub-allocating from an os 
allocated block. In this case it might be possible that the block 
after the overwritten block was not holding any valid data or at 
least wasn't ever given out by malloc/calloc/realloc.

\p

---
sed quis custodiet ipsos custodes
		--Juvenal *Satire* VI, 165

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
