Message-ID: <36CCB670.CE42A873@mailserv.rz.fh-muenchen.de>
Date: Fri, 19 Feb 1999 01:55:12 +0100
From: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Bill Davidsen <davidsen@prodigy.com>,
        Cort Dougan <cort@persephone.cs.nmt.edu>,
        "David A. Gatwood" <marsmail@globegate.utm.edu>,
        Douglas Godfrey <dvdoug@tiac.net>, Gabriel Paubert <paubert@iram.es>,
        Jesper Skov <jskov@cygnus.co.uk>, Troy Benjegerdes <hozer@drgw.net>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: [ppc-dev] Summary: Restructuring Efforts
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Well, I started (yet again) with some questions and remarks about
restructuring the kernel, so I guess I should summarize the outcome so
far. I tried to summarize all statements I got so far (you will find the
individual summaries below). I hope that I didn't made major mistakes in
language usage or that I mixed up the statements (If so, I'm sorry and I
apologize for it).

1. CVS

There should be another cvs tree used for developers. A lot of
(inofficial) patches are floating around. So, this tree can be used as
the common base where developers can start with their patches upon.
These patches will be (carefully) added (by Cort). There is no need for
r/w access for everyone. However, it is a developers kernel, so patches
can be made much easier in this tree than in an official one. Perhaps
the use of bitkeeper might also be of help.

2. GENERIC KERNEL

Cort wants to have one generic kernel for all desktops. There are
difficulties with APUS because of the 'non byte swapping io accesses',
though. 
The usage of OpenFirmware by supporting functions should be compiled in
into the generic kernel. Using the variable _having_of will then help to
decide whether to use these functions or not. This can happen either at
run-time or, when _having_of is made a constant, the optimizer of gcc
will/might remove this code. 
Arch specific functions might be grouped into a structure. This
structure is initialized at startup.  
To many integration might result in performance penalty because of to
many functionpointer lookups. Though, careful design (cache boundaries)
of this structure might reduce this performance penalty.
Traps might also be useful to emulate unsupported processor
instructions. 

3. SEPARATIONS

There have been no suggestions so far about if and how all the pmac_*,
prep_*, etc. should be seperated into a seperate directory. However,
Cort stated that head.S will be seperated.
After the restructuration is completed, it is then easy to support
different machines by just dropping another directory into the arch/ppc
directory and doing some minor changes to the Makefile and maybe also to
config.in.


Of course, I'd like to add some comments here:

1.
This is actually what I had in mind when asking about another cvs tree.
If you ask about r/w access, I guess everyone working on a port would
like to have r/w access, but this is not what I had in mind initially. 
I guess, a lot people are using Corey+Troy+... patches. These are the
patches I would see to be in the developers cvs. (Or declared as the
'official developers' patch, or whatever... )

2.
I also started with Corey's patches. So, many things are already
seperated. However, I ran into difficulties with the initialization
routines, mainly head.S and mm/init.c. Routines like those are only used
during initialization and, I think, are not needed to be made generic. 
Having a structure for the arch specific functions are only necessary if
you want to support different architectures at run time. Perhaps it's a
better to 'let the linker decide' which system the kernel should be
linked to. You could even use a library (with ar) of generic functions
having the same function names as the system specific object file. These
library functions are then 'overwritten' by the system specific
functions.
I don't like having OF supporting functions automatically built in into
the kernel when they are not needed. I'm not sure (right now) how easy
it is to build an interface between the kernel and those functions (eg.
in arch/ppc/mm).

3.
I'd like to see the pmac_*, chrp_*, prep_* stuff put into seperate
directories. 
I think head.S could be seperated into a system specific head.S and
trap.S. 



Thanks,
Christian

--------
Individual Summaries

Cort
- wants to avoid another tree for restructuring
- asks for a 'behaved' redesign (ie. not quick'n'dirty)
- bootloader cleanups are underway (eg. mbxboot for embedded)
- 2.2 supposed to be stable with only few changes; restructuring is
necessary, though
- there is a FTP access for patches; different ideas for restructuring
should be evaluated
- only 'mainstream' boards should be supported in kernel, but easy
integration should be possible
- single kernel for all desktops ('cos they have enough RAM and it's
easier to test); embedded: specifically for target
- generic kernel for PMAC,CHRP,PreP,APUS
- kernel/head.S will be seperated
- code supporting openFirmware only used in init-sections which get
dropped (possibly: use of have_of)
- generic kernel with constant _machine values are optimized by the
compiler

Troy
- careful redesign should result into a second tree on a central place
- a large bunch of incompatible chaotic patches floating around
- this 'bleeding edge tree' might also be easier to integrate into 2.3
- favours Corey's work to seperate archs

Cort
- cvs problems:
  o move things from our tree to vger to linus; vger important for
testing
  o to many, perhaps also imcompatible patches might come in
- asking how many people would like to have cvs r/w access
- there are only a few mostly overlapping patches
- use vger instead of an own cvs
- corey's work will be integrated soon
- restructuring efforts: corey's work, irq.c, pci-config

Gabriel
- there is no need for r/w access
- vger is to public; no real developer tree as we need it
- there are problems accessing vger
- is using currently a kernel with corey,troy,prepboot and a few own
patches
- APUS I/O needs 'non byte swapped instructions'
- kernel shouldn't execute conditional code or a call to subroutine for
every I/O access

Bill
- Current work not supposed to get into 2.3
- supporting multiple archs indicates to use directories rather than
putting everything inline with ifdefs
- easy to support another arch by dropping the directory and changing
symbolic links and changes to generic part mostly have not impact
- generic kernel desires also an 'all purpose' init in a dir of its own
- possible use of arrays of functions like *fct[_machine], or defines
for the functions

Benjamin
- prefers own cvs for developers tree instead of vger 

Troy
- we should try out bitkeeper

Benjamin
- likes function pointers (eg. in structures) 
- optimizing tables to cache boundaries

David
- BSD is using static structures with pointers to certain routines

Gabriel
- is against using vger

Jesper
- APUS doesn't require byte swapping; however, he doesn't see the
problems for integrating APUS into the generic kernel
- is also concerned having additional memory accesses to call IO
subroutines using function pointers

Gabriel
- integrating APUS desires having also pointers to IO functions
resulting in a huge performance penalty 
- (see. io.h)

Cort
- using traps to emulate non existant instructions like tlbia



-- 
Christian Zankel       <zankel@mailserv.rz.fh-muenchen.de>

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
