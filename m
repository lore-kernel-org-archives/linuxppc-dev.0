Date: Fri, 19 Nov 1999 11:46:01 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geoff Hutchison <ghutchis@wso.williams.edu>
cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Building Question
In-Reply-To: <v04220805b45a473d1794@[129.105.9.179]>
Message-ID: <Pine.HPX.4.10.9911190941180.5120-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 18 Nov 1999, Geoff Hutchison wrote:

> After several days of investigation, I'm guessing it may be the "lot 
> of sections which happen not to be located together." The linker 
> script is the latest GNU libtool.
> 
> The code itself:
> a) doesn't use templates
> b) isn't "megatons" since individual C++ files weigh in at a few K.
> 
> Granted, I'm using bison and flex to generate some C++ code, but 
> these are still fairly small in the scheme of things. On an 
> individual basis, the object files are at most 50-100K.
> 
> So that would lead me to believe that the problem comes when linking 
> a few several MB shared or static libraries together. Does this sound 
> reasonable? Would these normally be in different sections as far as 
> the linker is concerned? (I'm not an expert on object file formats.)

Have a look with objdump --head to all the files you are trying to link
and try to sum the .text and .data sizes. I've just discovered that the
.plt and .got sections get linked _after_ all the data sections and I
wonder why it is so. The linker replaces calls to shared library with
calls to the .plt section where it puts glue code to call the actual
function. You might need a different linker script in which you put the
plt before the data, for example by taking the default script
(/usr/lib/ldscripts/elf32ppclinux.x) and moving the 

  .plt   : { *(.plt) }

line just after the start of the data section (between the ALIGN statement
and the start of the .data group). I've checked that it did not break a
small program: it simply makes the executable slightly bigger (200 bytes
in my case) because the PLT is now in the middle of the file rather than
being truncated.

Anyway, this probably means that the application has a lot initialized
data (a few big arrays with some elements statically initialized could
cause it but it's a wild guess). The resulting executable will be huge in
any case (objdump --head will tell you how much you would have saved by
looking at the size of the plt). 


> 
> >You might also want to use the longcall attribute (I never tested it),
> >from info gcc:
> 
> I'd obviously prefer to stay away from this if possible.
> 

I understand.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
