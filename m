Message-ID: <381F39F5.93DE3ED8@netx4.com>
Date: Tue, 02 Nov 1999 14:22:29 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Grant Erickson <grant@lcse.umn.edu>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: ASM-PPC Include File Rework Proposal: Processor / Board Header Files
References: <Pine.SGI.4.10.9911011256160.155416-100000@brule.lcse.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I read this, thought about it, slept for a while, read it again.....
Here are some comments :-).

Grant Erickson wrote:

> As more PowerPC processor variants get added and as more board types are
> supported by the stock Linux/PPC distribution the current state of affairs
> in the asm-ppc directory is going to get a little unruly.


It isn't only the include directory, it is the entire structure
of the generic software we all want to utilize, plus the ability
(especially for embedded stuff) to remove any configuration items
we really don't want.



> The real ugliness comes with the large number of ifdef's sprinkled all
> over the place.


Beauty is in the eye of the beholder :-).  I don't really think
it is that bad.  There are a few nasty spots, but overall it is
much neater than some commercial projects I have seen in the past.


> Dan has a nice solution to board-specific information with the mpc8xx.h

Perhaps this is where we start with your 4xx stuff.  Although I
have currently stretched the "mpc8xx.h" to include some of the
new 82xx stuff, you could just add your 4xx into it as well.
Change the name if you like, but make it work first.


> ....... Any other C file or other
> include file which needs board-specific (NOT processor specific)
> information includes board.h and ONLY board.h.



Although it is logical and certainly appropriate to separate
this information, from my experience this is getting harder to
do because of the integration of the processors.  Processors
either dictate a certain board configuration, or are so flexible
the board configuration describes a processor configuration.
Your "generic" processor definitions become very few.


> Also, processor.h has a smattering of all sorts of information. Some of it
> processor related, some of it board related, and almost all of it specific
> to the 6xx/7xx processor cores.


This is where Linux/PPC started and most of the work continues.


> ..... I'd like to define several new files,

Here is where I have a _real_ opinion.   I don't like lots of
files that basically describe the same thing.  The problem lies
in the update of generic software.  When I make a kernel modification
that affects everyone, I have to update several different files
in a similar manner and hope I don't break something for someone
else.  As I have said in a previous e-mail, my goal is to remove
all of these 8xx board specific files by reprogramming the 8xx
to a generic Linux/PPC address space.

When all of this is in a single place, it forces you to think about
how your unique changes are going to affect everyone else.  It
should also make you try to find a more generic solution to your
new addition.  In the end, it will make it easier for everyone
to maintain.

I tend to find processor.h rather convenient.  There are others
in this list as well, like pgtable.h and mmu.h.  When you start
changing things for a new processor or board type, you have
all of the current information described there.

We recently split head.S into head.S and head_8xx.S.  I don't
think that was such a good idea......Now, generic changes to
the VM or task subsystem have to be applied in both files.  It
actually makes it harder for me because I now have to track
6xx/7xx changes more carefully to make sure 8xx still works.


> .... I'm open to suggestions and debate on the subject.

My suggestion is to simply add your 4xx along the path of the
8xx and let's try to sort out some kind of "embedded" solution.

There is a long history of Prep/CHRP/PMac and 6xx/7xx software
that has defined the structure of the Linux/PPC kernel, and I
would rather not change that.  I have been working on the kernel
almost daily for many years now, and there are few others that
do the same.  When you get old like me, it helps to have some
consistency in your life :-).  I know what is in all of the
files and where to go and change something.

As I said in the beginning, I don't find the confusion or
challenge in the include/asm directory.  The challenge is in
the source code itself, trying to sort out all of the configuration
options and utilizing the generic software.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
