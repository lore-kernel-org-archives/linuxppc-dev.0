Message-ID: <XFMail.990415125632.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <37158D29.132CCFC1@wanadoo.fr>
Date: Thu, 15 Apr 1999 12:56:32 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Martin Costabel <costabel@wanadoo.fr>
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
Cc: bug-gnuplot@dartmouth.edu, linuxppc-dev@lists.linuxppc.org,
        Tom Rini <tmrini@ntplx.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 15-Apr-99 Martin Costabel wrote:
> 
> Tom Rini wrote:
> 
>> Hmm.  I don't use gnuplot (and thus didn't see the bug and don't have the
>> source handy), so if any x86/Linux users with glibc 2.1.x installed could
>> see if they run into the bug..
> 
> When gnuplot-3.7 came out, this problem was mentioned to one of the
> gnuplot discussion groups (which I don't normally read, I use gnuplot
> only occasionally, with octave, for example). It didn't get much
> attention, because it seems to affect only linuxppc (and who's using
> that, anyway?)
>  
>> > Or could someone find out what's wrong with the fprintf function in
>> > LinuPPC? Note that this is not specific for one version of glibc. I
>> > tried it on several from glibc-961212 to glibc-2.1.1-3a. Same result.
>> 
>> It failed under the old libs?
> 
> Yes, I compiled gnuplot-3.7 under glibc-961212 (rev 1o, IIRC), and the
> result was the same. I managed to track the problem down to the fprintf
> call, but I don't know enough C and glibc to go any further.
> 

I'm not familiar with the specifics of the problem being discussed here but
it seems to be a "varargs" problem.  One of the key differences between
Linux/PPC (and indeed PowerPC in general) and virtually every other system
is how "varargs" works.  For most architectures a simple pointer to a 
list of items [typically on the stack] is used.  On the PowerPC, however,
there is an invisible structure which is used to manage the parameters.
Where just copying a pointer works fine on other architectures, these sort
of operations fail on the PowerPC.

This is where I'd look to start with.  (Note: I'm not volunteering :-)

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
