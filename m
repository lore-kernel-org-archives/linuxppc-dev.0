Date: Wed, 22 Dec 1999 19:08:35 -0800 (PST)
From: Ted Merrill <ted@arraycomm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: questions
Message-ID: <Pine.SOL.4.21.9912221739140.20123-100000@eunice.arraycomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



First a general comment:

There were some good comments about board support packages in the
mail archive for this list.
Yes, i realize board support packages are a pain, however:
The linux kernel source is going to explode if it has to support 
directly all of the board variations that will have linux ports.
Statements like "switch(machine_type)" won't cut it.
A more achievable goal is to have the kernel support directly
all of the common cpu chips, bus controllers and the like,
and configure the kernel with a combination of ifs and #ifs controlled
by configuration variables of fairly fine grain, selectable by
a board support configuration file that lives at a distance from
the rest of the code.

Now for the specific question of interest to me:

For the sort of projects that my company is working on,
vxWorks is a better fit than Linux because we don't really need
separate process/kernel address spaces.
What we're doing on the main processor isn't really that complicated
but does require IP networking... thus vxWorks or Linux.
We can (i hope) put up with this unwanted feature of Linux 
in order to get the good stuff, principally the publicly developed
networking software and debugging tools.
I'm thinking the doable thing with Linux is to have only a single
process (filling in for the init process) with multiple threads.
Sounds like the "sash" program could be the beginning of the model for this.
The single process approach combined with static linking
blows away the whole problem of stripping down the C library to fit...
I was trying to make a list of processes running on my pc
that might be needed (and so would be a problem).
We won't have a local disk and we won't be serving very much
but we probably will want to serve both telnet (to a debugging shell, not sh)
and snmp for debug and management purposes, thus we may need inetd ...
this might be some amount of work to turn into library functions.
I'm pretty clueless how snmpd can be reasonably used in an embedded
system were some of the data is in a process and some in the kernel...
i'll have to read up more.
Can anyone share any experience with this?

Thanks
Ted Merrill
ArrayComm, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
