From: "Petersen, David (MED, GEMS-IT)" <David.Petersen@med.ge.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <B1243F436404D511A5CF009027E705DA148191C2@uswaumsx09medge.med.ge.com>
Subject: m8260_cpm_hostalloc() data reads incorrect data
Date: Thu, 6 Nov 2003 08:52:55 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	I am working on a platform with an mpc8270 processor running a
kernel from the latest 2.4 development tree.  I have created a driver based
on uart.c for one of the SCCs.
The receive buffers are allocated using the m8260_cpm_hostalloc(). I am
getting receive interrupts and verfied that the data is written by the cpm
to the correct physical memory location using a logic analyzer. However the
data that is read from the buffer is incorrect.  As a sanity check, I
allocated my buffers using m8260_cpm_dpalloc() and I then read the correct
data.

	I've looked through the hostalloc function as well as the
__alloc_bootmem() function that initially allocates two pages of data for
the CPM in mpc8260_cpm_reset(). It is unclear to me how this memory can be
in a PAGE_NO_CACHE region as it needs to be for the CPM. I'm not sure if it
is something in my system initialization that would put the memory that
alloc_bootmem() uses in a noncacheable area or if the memory initially
allocated for the CPM in mpc8260_cpm_reset() needs to be done differently.


Tom

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
