Date: Tue, 22 Feb 2000 10:27:08 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@linuxcare.com>
cc: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch for optimize context switch
In-Reply-To: <00022210165901.14669@argo.linuxcare.com.au>
Message-ID: <Pine.HPX.4.10.10002221001530.4957-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 22 Feb 2000, Paul Mackerras wrote:

>
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

Exactly, context switches are infrequent and should be benchmarked at
least after having invalidated the code from the instruction cache
(whether it should also be pushed out of the L2 cache is more questionable
but I would also push it out since L2 cache is only direct mapped or 2 way
set associative on most processors). Besides the time of the loop is
dominated by the execution synchronized mtsrin. Actually the only
processor on which it might be a clear win is the 601.

	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
