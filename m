To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 8xx_io/uart.c 
In-Reply-To: Message from Dan Malek <dan@embeddededge.com>
   of "Mon, 10 Feb 2003 13:52:04 CDT." <3E47F4D4.5070202@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Feb 2003 12:13:49 +1100
Message-ID: <30768.1044926029@ull>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 10 Feb 2003 13:52:04 -0500, Dan Malek <dan@embeddededge.com> writes:
>> ... I for one would like to see this bug fixed.
>
>Prove it's a bug, it will get fixed.

If you simply looked at the code you would see the problem we are talking
about. What are you suggesting? That kgdb and xmon will _NEVER_ send a
character with decimal value 10 via my_console_write()?

>I will mildly apoligize, but you have to understand I get lots of patches
>from people claiming "bugs", when it isn't one and they don't take the time
>to understand why something was done or even how it works.  I'll add the
>code, it won't have any effect, it that makes you happy.

I really don't care either way - I gave up worrying about this sort of thing
a long time ago. I do think you have the wrong attitude for the position you
have assumed for yourself in the linuxppc community - you are unnecessarily
aggressive, assuming that everyone is a moron until proven otherwise.

However, having said this, I very much appreciate the effort you (and others)
put into it - the positives outweigh the negatives. This is why I keep my mouth
shut (usually), and will keep my mouth shut in the future (after this message).
If I don't like it, I will put my effort where my mouth is - or go use a
kernel tree set up by someone else.

>I took the time to look for something from you in the past and didn't find
>anything.  If it showed up, you would have received the same discussion.

http://lists.linuxppc.org/linuxppc-embedded/200205/msg00268.html

You probably didn't find it because I compressed the patch. I guess this is
a good example of why one shouldn't compress patches sent to the list.

>The 8260 driver was just a copy of this one with only the necessary changes
>to make it work on that processor.

That much is clear to all who are working on linuxppc on the 8260, I'm sure.

>> This serves to highlight the difficulty of getting stuff into the "official"
>> linuxppc kernel sources,
>
>The real difficulty arises from the time many of us have to spend proving
>patches work correctly or that a real bug exists.  In this case, no one took
>the time to prove it was a bug, which it isn't, or that it was even fixed.

It didn't need proving by testing - it was a simple logic exercise. Either
the first test against IMAP_ADDR is redundant, or the same test is needed
in the second instance of the code in the case where the character being
transmitted is equal to 10 (decimal). Please can't you just view the piece
of code under discussion and see what we are talking about?

>The reason we have only a few people with the ability to actually update
>the trees is we take the time to understand how all of this stuff works
>and do our best to ensure we aren't creating more problems than we are solving.

Like I said, I think you have the wrong attitude - are you suggesting that
I am incapable of understanding this stuff? The question under discussion is
quite trivial and if you'd actually look at it instead of assuming I was a
moron, you'd see.

>For example, was someone supposed to blindly accept Jocke's patch to make
>the serial port fifos so much larger?  I had to take the time (over and over)
>:-)
>to explain why this wasn't a bug.

You are mis-representing what I said. I wasn't suggesting blind acceptance.
What I am suggesting is that the list be used to discuss patches, and if after
a certain amount of time and discussion there are not any *objections* to a
patch, it should make its way into the *development* tree. If it then breaks
something, it can be backed out (easy with bk), and the person who sent it
can resubmit it via the list at a later stage when they have fixed the
reason it was breaking things. The development tree is supposed to be used
this way. When after time there is no obvious problem with a patch, it can
make its way into the stable tree - this process must be handled more
carefully, of course - the stable tree *must* be stable.

And in fact, the system worked well in the case you cited - the discussion in
the list led Jocke to look elsewhere for the cause of his problem and the result
was a patch to drivers/char/n_tty.c (which must be submitted via the linux
kernel mailing list, since it is a patch to a non-ppc file). I am sure Jocke
appreciated your input, and the issue was resolved satisfactorily.

>It would be nice if some of you went through
>the learning curve to understand how things are supposed to work before you
>just declare bugs and submit patches.

I actually have done so. Dan Malek is not the only person in the world who
understands this stuff. Like I say, you have a bad attitude - but again, I am
not in a position to put in the effort required to displace you, so I will just
put up with it.

> > ...I don't know what to do about this, ...
>
>The thing to do about it is for _you_ to invest the time in some engineering
>practices and show that you really found a bug, you can reproduce the bug,
>you implemented some feature enhancement, your modifications didn't introduce
>other problems, the code considers effects on other platforms, and that
>your update does what it claims.

This was a logic (i.e. thinking) exercise - not an engineering problem. For
less trivial examples, I am very careful about any code I submit - but of
course, no-one is perfect - including yourself.

>When I have to do this, the priority of
>these updates falls well below my own work.

You are not god's gift to linuxppc - other people have worthy contributions
to make and understand the way it all works just as well as (if not better
than) you. Most of your message was informing us how much effort you put in
and for us to put up or shut up, then you come out with this - which basically
says that you don't have the time to put in all this effort.

I admit I don't have the time. I will contribute as much as I can, when I can,
but if my patches are not accepted, I am not going to lose any sleep over that.
The patches are out there on the public record for anyone to use if they so
wish - they just need to put in a bit of effort to find them.

Please don't let my (hopefully constructive) criticism affect the amount of
effort you put in. I know you contribute a lot and you shouldn't say "well
bugger them, I'm not doing any more for the ungrateful bastards". I am grateful.
To you, and all the others who participate in this list. I have fixed quite a
few problems on our board from patches in the list that have not made it into
the "official" linuxppc tree.

A good example of this is the 8260 FCC ethernet driver - in fcc_restart(). If
you want to set Full Duplex, then both the Full Duplex Enable (FDE) bit *and*
the Local Protect (LPB) bit need to be set - if the LPB bit is not set, the
receiver is blocked while transmitting, thus negating true full duplex
operation. The symptom is poor throughput on fcc ethernet reception. A number
of people, including myself (although I didn't "discover" it, I just use it in
my local tree), have posted this fix, and it still has not made it into the
"official" linuxppc source. There is a lot of other good stuff out there - the
Denx site has heaps of good code that hasn't been accepted.

I will restate my position, then shut up. It needs to be made easier to get
code into the *development* kernel tree. The level of testing required is
by definition less than required for the "stable" tree. The current system is
not optimum. If there is a lack of time on the part of the current people
with write permission to the linuxppc *development* tree, then there needs to
be more "writers". Doing this will inevitably lead to problems, but the gains
will outweigh them, I'm sure. BitKeeper allows easy management of the problems.
Someone needs to be appointed the judge, or there needs to be a panel of
"judges", so that writers will not have patch backout wars. All this has been
done quite successfully in other projects. And finally, at the very least, it
needs to be seen to be fair, so that certain people and/or companies must not
appear to receive favourable treatment.

This discussion is wasting everyone's time (well, mine at least). Lets just
agree to disagree and get on with our work. While the current situation is
not optimal, I am getting by with it as it is. So unless you are going to
say "ahh, I see the problem, I will try to change the way I do things", there
really isn't any point in responding. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
