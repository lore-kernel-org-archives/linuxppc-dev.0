Date: Fri, 2 Feb 2001 02:38:35 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
        Paul Mackerras <paulus@linuxcare.com>
Subject: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010202023834.A17159@allspice.cs.swarthmore.edu>
References: <20010130165710.B22219@allspice.cs.swarthmore.edu> <B69DFE88.9197%bootc@worldnet.fr> <20010201115015.A11149@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010201115015.A11149@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Thu, Feb 01, 2001 at 11:50:15AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A patch will have to wait until tomorrow morning, but I have just burned
my first CD in DAO mode!  :-)  The problem was a table in mesh.c and
about four or five other drivers specifying which SCSI commands write
data to the drive (as opposed to reading from it.)  send_cue_sheet
(0x5d) was not in the table, nor mentioned in include/scsi/scsi.h.
Adding the appropriate #define to scsi.h and the appropriate table entry
to mesh.c fixed things nicely!

There are still some issues outstanding:
1)	The same table is duplicated in five or six drivers.  I think it
would make lots of sense to have a macro for the case statment in just
one place.  Should it go in scsi.h?  Or its own new file?

2)	It's a little bit worrisome that the whole mesh bus locks up
because of this.  What if some other unknown SCSI command tries to write
data?  The whole problem will repeat itself.  How do most of the SCSI
drivers avoid needing this information, or from what alternate source do
they get it?  Is there something about OldWorld mac hardware that
particularly makes mesh.c and mac53c94.c need this table?

3)	It continues to be worrisome that the mesh driver doesn't handle
aborts right or retry lost arbitration (nor does mac53c94.)  Is there
anywhere that the way to do these things is documented?  I'm willing to
try my hand at fixing them.

A quick patch will follow in the morning, and based on people's opinions
about issue 1 above, I'll make a more definitive patch to send to Linus
and Alan Cox and whoever one sends these things to.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
