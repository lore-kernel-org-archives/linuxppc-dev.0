Date: Fri, 17 Dec 1999 12:09:29 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Jason Haas <jhaas@www.linuxppc.org>
cc: Jonathan Brauer <brauer@texmemsys.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64 bit powerpcs
In-Reply-To: <Pine.LNX.4.04.9912161506590.3730-100000@www.linuxppc.org>
Message-ID: <Pine.HPX.4.10.9912171025440.8289-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




On Thu, 16 Dec 1999, Jason Haas wrote:

> 
> On Thu, 16 Dec 1999, Jonathan Brauer wrote:
> 
> > 
> > I was looking to see if anyone had any experiance getting and or using 64 bit 
> > PPC chips in embedded systems.  TIA.
> 
> AFAIK, Cort Dougan was/is going to start working on porting Linux to that
> chipset, but I have no further information.
> 
> Linux not running on them would definately be an obstacle to using them.

Well, the problem is that now there are 2 kinnds of 64 bit PPC: the
workstation ones (Power3) and the embdeed ones. Find the BookE
specification and be horrified: they are totally incompatible, actually
I suspect that there is no binutils/gcc support for the embedded flavor
right now (and by the way the current CONFIG_PPC64 in Linux/PPC is
actually running a 64 bit PPC in 32 bit mode). 

Actually if you take into account the very different MM architectures of
embedded and desktop PPC, this makes 4 very different archs:
1) 32 bit PPC (6xx, 7xx, 7xxx and 8240)
2) 64 bit (620 if it ever existed, Power3, upcoming Power4,...)
3) embedded 32 bit (82x, 82xx, 86x, 4xx and I forget certainly some)
4) embedded 64 bit (IBM has a core I think, Motorola not yet AFAICT)

grossly speaking 2 and 4 are vastly different supersets of the other 2
varieties. 32 bit application code is basically the same on all cores
(integer only, FPU may be present or not), 64 bit application running on
2) will not run on 4) and vv. MMU fall into 2 classes: the hash table
based for 1) and 2) and the tree based for 3) and 4) with many other
differences...

	Gabriel.

P.S: I hate book E. A few years ago there was a paper claiming PPC being a
64 bit arch with a 32 bit subset, book E just kills this. Now it is a 32
bit arch with 2 incompatible 64 bit extensions, and I'm very upset about
this :-(


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
