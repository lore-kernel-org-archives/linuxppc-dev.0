Message-ID: <38B25749.2C4B0E1A@cnet.francetelecom.fr>
Date: Tue, 22 Feb 2000 10:30:49 +0100
From: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch for optimize context switch
References: <38B1183A.AC6214E0@cnet.francetelecom.fr> <00022210165901.14669@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> On Mon, 21 Feb 2000, FASSINO Jean-Philippe wrote:
>
> > The aim of this patch is to optimize context switch on PPC.
> > It permit to optimize pipeline and reduce near 30 instructions per
> > context switch.
> > I'm using it on my computer and it work well, please test it !
>
> Interesting.  How much does it reduce the context switch time?  Did you
> run lmbench or something to see if it makes it go faster?
>
> The reason I ask is that it is possible that unrolling the loop as you
> have done could actually make it go slower due to increased i-cache
> misses.  The bdnz instruction on PPC has essentially zero overhead since it
> is pulled out of the instruction stream in the fetch/decode unit by the
> branch processing unit.  Also, it is very easy to predict whether a bdnz
> will branch or not.

There are two advantages of this patch :
    - unrolling the loop (suppress the bdnz instructions),
    - statically designate segment register (suppress one add per loop).
The main disadvantage is :
    - possibly increase i-cache misses (depend of function alignment)

To conclude, i'm trying to run lmbench and when i got result i send it.

Jean-Philippe

--
--------------------------------------------------------------------------
Jean-Philippe FASSINO  Tel :  04 76 76 45 52
CNET : DTL/ASR         mailto:jeanphilippe.fassino@cnet.francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
