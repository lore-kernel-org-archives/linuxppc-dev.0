Date: Tue, 22 Jun 1999 09:52:49 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Reply-To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Peter Chang <weasel@cs.stanford.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: dl-load.c (ld.so) bug??
In-Reply-To: <v04205405b394c1fe1645@[209.239.164.131]>
Message-ID: <Pine.LNX.3.96L.990622094815.1625A-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 21 Jun 1999, Peter Chang wrote:
> 
> At 23:09 -0400 06.21.1999, Daniel Jacobowitz wrote:
> >On Mon, Jun 21, 1999 at 10:48:12PM -0400, Hollis R Blanchard wrote:
> > >
> > > I have two even simpler test cases for you:
> > >
> > > int main(void){
> > >     char *ptr=NULL;
> > >     free(ptr);
> > > }
> >
> >Well, that one would probably segfault anyway (or at least, is not
> >guaranteed not to).
> 
> Hmm... the docs taht I have say this:
> 

[snip]
>  If ptr is a null pointer, no action occurs.
[snip]

Right. In other words, that's legal and should not segfault.

> > > int main(void){
> > >     char *ptr = (char *)malloc(100);
> > > }
> >
> >That one's a problem, though :)
> 
> Why? Its allocating memory, but never freeing it. Its a leak, but not 
> accessing things out of bounds. I haven't used ElectricFence, but its 
> not going to catch a bounds error on this.

Try it. It segfaults. Add a free afterwords if you like. It still segfaults.
Add a printf in front of it, and that printf will never happen. The segfault
starts in __libc_start_main. It makes no sense, but anytime you put a malloc
or a free in a program, EFence makes it segfault (*before* running that malloc
or free).

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
