Date: Tue, 16 Nov 1999 17:15:53 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geoff Hutchison <ghutchis@wso.williams.edu>
cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Building Question
In-Reply-To: <v04220800b4572678a8f9@[129.105.9.226]>
Message-ID: <Pine.HPX.4.10.9911161657160.5120-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 16 Nov 1999, Geoff Hutchison wrote:

> 
> At 11:23 AM +0100 11/16/99, Martin Costabel wrote:
> >Fix the "undefined reference" error.
> >You mean "undefined reference" isn't an error on x86?
> 
> That's my point--people compiling the *same* code don't get that error.
> 
> At 9:27 AM +0100 11/16/99, Wolfgang Denk wrote:
> >I'm not really sure, but can you please check how  big  your  code  /
> >data  segments  are? The PPC addressing model is limited in range for
> >relative addressing - "REL24" indicates that you are overrunning  the
> >relacatable range using 24 bit offsets...
> 
> I was afraid of that. Thanks. I'll see if I can tweak the linking 
> order and see if that helps a bit. I'll also try gcc -Os and see if 
> that helps.

Note that actually the so called 24 bit is a signed 26 bit value branch
relative offset. This means that you try to jump more than +/-32 Mb away
from the code which is quite strange, unless you are generating megatons
of template based code... (You truly need several millions line of code
or your code is spread across a lot of sections which happen
not to be located together). Check also the linker script if there is
one just in case...

You might also want to use the longcall attribute (I never tested it),
from info gcc: 

`longcall'
     On the RS/6000 and PowerPC, the `longcall' attribute causes the
     compiler to always call the function via a pointer, so that
     functions which reside further than 64 megabytes (67,108,864
     bytes) from the current location can be called.

for portability I would it use it in the following way: 
#ifdef __powerpc__
#define __faraway __attribute__((__longcall__))
#else
#define __faraway
#endif
and then declare the offending functions __faraway...

Note: It might also be used for the linux kernel in modules, declaring a
function longcall would avoid the jump through linker generated (actually
module loader generated) code if I understand correctly what it does.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
