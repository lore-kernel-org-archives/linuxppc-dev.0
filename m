Message-ID: <3D831F3E.ED96A88F@koffie.nl>
Date: Sat, 14 Sep 2002 13:36:29 +0200
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
References: <3D80F2F7.3FB3AE4B@koffie.nl> <15745.23603.313915.127474@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
> I'm curious - how are you going to cope with the fact that different
> PPC implementations have different numbers of PMCs and different
> sets of events (and numbering of the events) that the PMCs will count?

The kernel module doesn't care, except for not allowing illegal values;
userland doesn't care all that much either, really, as a number is just
a number :)  It's mostly the user that cares.

Ah well, an example might clarify:


ppcprofile --pmc1=6 --pmc2=6 ./hello_world

ppcprofile will look for existence of /proc/sys/debug/pmc/pmc[12], and
do some sysctls on it.  i.e., the kernel module will only make entries
for available hardware.

Note that the kernel module doesn't need to check if a certain event
number is defined; it only needs to check if it fits into the number
of bits allocated to it.


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
