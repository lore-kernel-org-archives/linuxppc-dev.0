From: Paul Mackerras <paulus@linuxcare.com>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch for optimize context switch
Date: Tue, 22 Feb 2000 10:12:59 +1100
Content-Type: text/plain
References: <38B1183A.AC6214E0@cnet.francetelecom.fr>
MIME-Version: 1.0
Message-Id: <00022210165901.14669@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 21 Feb 2000, FASSINO Jean-Philippe wrote:

> The aim of this patch is to optimize context switch on PPC.
> It permit to optimize pipeline and reduce near 30 instructions per
> context switch.
> I'm using it on my computer and it work well, please test it !

Interesting.  How much does it reduce the context switch time?  Did you
run lmbench or something to see if it makes it go faster?

The reason I ask is that it is possible that unrolling the loop as you
have done could actually make it go slower due to increased i-cache
misses.  The bdnz instruction on PPC has essentially zero overhead since it
is pulled out of the instruction stream in the fetch/decode unit by the
branch processing unit.  Also, it is very easy to predict whether a bdnz
will branch or not.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
