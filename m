Date: Tue, 16 Mar 2004 12:40:30 +0100
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI Memory mapping
Message-ID: <20040316114030.GB7133@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am currently trying the following

 +-----+        +-----+
 | mem |        | mem |
 +-----+        +-----+
    |              |
 +-----+        +-----+
 | ppc |        | dsp |
 +-----+        +-----+
    |     pci      |
    +--------------+

For a number of reasons (load on ppc, dsp silicon bug), we are trying to
transform the ppc dma transfers (ppc master write) to transfers
initiated by the dsp; where the memory block that is the result of
processing by the ppc is fetched by the dsp (ppc slave read).

Mapping pci devices registers and memory  into ppc kernel memory is well
documented, but I seem to be missing information about the other way
around: I (ppc) want to signal the dsp that data is ready at address
0xXXXXXXXX, come and get it (virt_to_bus(0xXXXXXXXX)?).

Most likely I have been searching archives with the wrong keywords since
I haven't found a good reference next to some notes in IO-mapping.txt
which seem to indicate that this is possible.

Any pointers about making cpu memory visible on the pci bus would greatly
be appreciated.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
