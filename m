Date: Fri, 2 Feb 2001 13:58:44 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
        Paul Mackerras <paulus@linuxcare.com>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in
 dao mode
In-Reply-To: <20010202023834.A17159@allspice.cs.swarthmore.edu>
Message-ID: <Pine.LNX.4.30.0102021043380.15482-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> A patch will have to wait until tomorrow morning, but I have just burned
> my first CD in DAO mode!  :-)  The problem was a table in mesh.c and
> about four or five other drivers specifying which SCSI commands write
> data to the drive (as opposed to reading from it.)  send_cue_sheet
> (0x5d) was not in the table, nor mentioned in include/scsi/scsi.h.
> Adding the appropriate #define to scsi.h and the appropriate table entry
> to mesh.c fixed things nicely!

Good work :-)

>
> There are still some issues outstanding:
> 1)	The same table is duplicated in five or six drivers.  I think it
> would make lots of sense to have a macro for the case statment in just
> one place.  Should it go in scsi.h?  Or its own new file?

scsi.h is used by all drivers, and describes mostly midlevel stuff. Your
command table is only needed by some lowlevel drivers so it should go into
some separate header included only by those drivers.

Only MHO, ask a Linux SCSI guru.

Better yet, find another way to determine which commands send data from
the command bytes directly (what do all those drivers that don't use the
table use instead?)

> 3)	It continues to be worrisome that the mesh driver doesn't handle
> aborts right or retry lost arbitration (nor does mac53c94.)  Is there
> anywhere that the way to do these things is documented?  I'm willing to
> try my hand at fixing them.

The SCSI specs are probably the authoritative guide here. Plus the MESH
and 53C94 data sheets.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
