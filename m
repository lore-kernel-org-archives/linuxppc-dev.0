Message-ID: <3882F748.503E34A4@yahoo.com>
Date: Mon, 17 Jan 2000 06:04:40 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Grant Erickson <grant@lcse.umn.edu>
CC: Niklaus Giger <n.giger@netstal.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Help Sought: 8390-Ethernet Troubles on PowerPC 4xx Port
References: <Pine.SGI.4.10.10001141230510.254646-100000@brule.borg.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 
> Niklaus (and others),
> 
> Thanks again for the insight on the Oak 8390-based Ethernet driver. The
> polled register read/write macros did the trick (at least partially so).
> 
> I've done the modification fairly cleanly; however, I'm not sure that the
> kernel maintainers will accept the attendant changes to 8390.[ch] via the
> nic_{i,o}[s]{b,w}[p] macros. We'll see.

Hard to say without seeing it.  Not worth bending over backwards to try
and adapt the current 8390 if it means obfuscating things in the process 
(the EI_SHIFT trickery may lie somehwere in this grey area).  Code 
duplication is no longer considered supreme evil (wrt linux drivers
anyway) 
if it makes life easier.  

> The board now at least ARPs through the interface to the NFS server and
> the NFS server responds. However, that's as far as it gets at this point
> (see below). Any ideas? In the interim, I'm going to try experimenting
> with a few more things.

Sounds like your driver isn't Rx'ing the arp reply properly and handing 
it off to the upper layers where it can get put into the ARP table.
I assume /proc/net/arp isn't showing your NFS server.

What is the scoop on these cards?  At a glance oaknet.c in 2.3.40 looks
pretty much like ne.c but stripped of the PCI crud.

Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
