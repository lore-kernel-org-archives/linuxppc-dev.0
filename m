From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14786.65401.393966.936283@argo.linuxcare.com.au>
Date: Sat, 16 Sep 2000 16:04:57 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: recent fixes in devel tree
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been fixing a few things in the development kernel (2.4.0-test8)
lately:

PCMCIA.  I have fixed an endianness bug in the pcmcia/cardbus support
in the kernel, and added some code to get the interrupt routing right
on my 1999 G3 powerbook ("lombard").  I also fixed a bad bug that we
had in our free_irq() implementation.  I have been testing with a 3com
combo ethernet/modem card which seems to work just fine now, although
there does seem to be some sort of a problem on the initial card
insertion still.

Machine checks on accesses to non-existent I/O ports on powermacs.
I changed the definitions of inb/w/l and outb/w/l so that they use a
sync instruction after the load or store, instead of eieio.  If the
location doesn't respond and we get a machine check, it should occur
at the sync instruction and we then use the existing exception
handling mechanism that we use for get_user/put_user etc. to recover
and keep going.  An inb/w/l to a non-existent port will return -1
rather than crashing the system as before.

As part of this I added code to sort the exception table.  Because we
have so many sections (pmac, prep, chrp, apus, etc. as well as the
usual init section and the main text section) the exception table gets
out of order and it is necessary to sort it so that the binary search
works correctly.

Copy speedups using cache prefetching.  I found that on the G4, using
the dcbt instruction to prefetch data into the cache in the inner loop
of copy_to/from_user and copy_page gives very substantial speedups.
For example, `cat largefile >/dev/null' used to go at around 140MB/s
on my 450MHz G4 cube (assuming largefile fits into memory) and now it
goes at around 400MB/s. :-)  Interestingly, dcbt makes no difference
at all on the G3 machines I tried.  I presume it is a no-op on the G3.

The fixes are in the linuxppc_2_3 bk tree and in my rsync tree at
ppc.samba.org::linux-pmac-devel.  Cort or I will send some patches to
Linus soon and hopefully they will go in.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
