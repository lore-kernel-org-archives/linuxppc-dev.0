Message-ID: <37A17EA6.C3D20B38@ica.net>
Date: Fri, 30 Jul 1999 06:30:01 -0400
From: trevor <trevor@ica.net>
Reply-To: trevor@ica.net
MIME-Version: 1.0
To: LinuxPPC dev <linuxppc-dev@lists.linuxppc.org>
Subject: creating EABI stack frames
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello,

i was wondering if some kind soul out there might be able to help me to
understand the EABI a little bit more, specifically how it pertains to stack
frames. i think i've read all the documentation but it took a little bit of
time to sink in and i've got a question or two.

i guess first of all i would like confirmation that LinuxPPC is setup to use
the EABI. if this isn't the case then i'd like to know what it uses (but i'm
quite sure this is the case).

i really like assembly language and was trying to tackle PowerPC assembly. one
of the first hurdles to overcome was for me to create some simple way to be
able to create (and un-create) stack frames for my programs and functions.
after slugging away for some time using "templates" and working from one
experiment to the next i decided that it would be really nice and helpful to
write a macro (or two) for creating and destroying stack frames -- so i did.
but in the course of writing these macros i came across this little
uncertainty. i'm uncertain how to handle the "padding" field.

from what i understand a stack frame is supposed to look like the following:

 high address
   +----------------------+
   |  non-volatile FPRs   |
   +----------------------+
   |  non-volatile GPRs   |
   +----------------------+
   |  Condition Register  |
   +----------------------+
   |  Local Variables     |
   +----------------------+
   |  Function Parameters |
   +----------------------+
   |  Padding             |
   +----------------------+
   |  Link Register       |
   +----------------------+
   |  Back Chain          |
   +----------------------+
 low address

and it is supposed to be double-word aligned (on addresses divisible by 8).

let's imagine that i've created a function which calls some C library function
such as (for example) printf(). also let's assume that i'm passing MANY
arguments to printf(), too many to be passed exclusively through GPRs 2 - 10.
this means i have to store some of the arguments onto the stack frame into the
"Function Parameters" area. so i need to be able to construct a "valid" stack
frame in order for printf() to be able to acquire all the necessary parameters.

let's pretend, for our first case, that i created a stack frame which has:
  1 FPR
  2 GPRs
  1 CR
  1 Parameter
  1 LR
  1 BackLink

if the start address of our stack is, say, 56 (decimal for simplicity) then we
would create a stack like the following:

56 +----------------------+
   |  non-volatile FPR    |
   +                      + 52
   |                      |
48 +----------------------+
   |  non-volatile GPR 1  |
   +----------------------+ 44
   |  non-volatile GPR 2  |
40 +----------------------+
   |  Condition Register  |
   +----------------------+ 36
   |  Function Parameter  |
32 +----------------------+
   |  Link Register       |
   +----------------------+ 28
   |  Back Chain          |
24 +----------------------+

and when we create this stack we'd discover that it is double-word aligned and
therefore there would be no need for any padding. if we called printf() it
would grab (presumably) the argument at address 32 which it would get by using
its BackLink to get to my stack frame and then skipping over the BackLink and LR.

now let's assume the same situation except that we now need to preserve only 1
GPR. in this case our stack frame would look like the following:

56 +----------------------+
   |  non-volatile FPR    |
   +                      + 52
   |                      |
48 +----------------------+
   |  non-volatile GPR 1  |
   +----------------------+ 44
   |  Condition Register  |
40 +----------------------+
   |  Function Parameter  |
   +----------------------+ 36
   |  Link Register       |
32 +----------------------+
   |  Back Chain          |
   +----------------------+ 28

in which case we'd realize we're not double-word aligned in which case we'd
need to add a word of padding:

56 +----------------------+
   |  non-volatile FPR    |
   +                      + 52
   |                      |
48 +----------------------+
   |  non-volatile GPR 1  |
   +----------------------+ 44
   |  Condition Register  |
40 +----------------------+
   |  Function Parameter  |
   +----------------------+ 36
   |  Padding             |
32 +----------------------+
   |  Link Register       |
   +----------------------+ 28
   |  Back Chain          |
24 +----------------------+

but how would printf() know to get our argument at address 36?

for the time being i've ignored this problem in my macros and to be honest
there might not ever be a time when i'd need to pass so many parameters to any
function (although if you think of window libraries... they tend to required
loads of parameters...).

can someone please help? i'm really sorry for the length, i know it's not nice
but i don't know how else to explain my question unambiguously. perhaps
someone could direct me to some source file i could look over. where, in the
linux sources, would i find something like this?

thank you and best regards,
  trevor woerner

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
