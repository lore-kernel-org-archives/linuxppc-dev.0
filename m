Mime-Version: 1.0
Message-Id: <v04220805b45a473d1794@[129.105.9.179]>
In-Reply-To: <Pine.HPX.4.10.9911161657160.5120-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.9911161657160.5120-100000@gra-ux1.iram.es>
Date: Thu, 18 Nov 1999 18:20:41 -0600
To: Gabriel Paubert <paubert@iram.es>
From: Geoff Hutchison <ghutchis@wso.williams.edu>
Subject: Re: Building Question
Cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:15 PM +0100 11/16/99, Gabriel Paubert wrote:
>Note that actually the so called 24 bit is a signed 26 bit value branch
>relative offset. This means that you try to jump more than +/-32 Mb away
>from the code which is quite strange, unless you are generating megatons
>of template based code... (You truly need several millions line of code
>or your code is spread across a lot of sections which happen
>not to be located together). Check also the linker script if there is
>one just in case...

After several days of investigation, I'm guessing it may be the "lot 
of sections which happen not to be located together." The linker 
script is the latest GNU libtool.

The code itself:
a) doesn't use templates
b) isn't "megatons" since individual C++ files weigh in at a few K.

Granted, I'm using bison and flex to generate some C++ code, but 
these are still fairly small in the scheme of things. On an 
individual basis, the object files are at most 50-100K.

So that would lead me to believe that the problem comes when linking 
a few several MB shared or static libraries together. Does this sound 
reasonable? Would these normally be in different sections as far as 
the linker is concerned? (I'm not an expert on object file formats.)

>You might also want to use the longcall attribute (I never tested it),
>from info gcc:

I'd obviously prefer to stay away from this if possible.

-Geoff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
