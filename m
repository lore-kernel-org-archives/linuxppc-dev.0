From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14971.34502.222006.311092@diego.linuxcare.com.au>
Date: Sat, 3 Feb 2001 15:19:18 +1100 (EST)
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
In-Reply-To: <20010202023834.A17159@allspice.cs.swarthmore.edu>
References: <20010130165710.B22219@allspice.cs.swarthmore.edu>
	<B69DFE88.9197%bootc@worldnet.fr>
	<20010201115015.A11149@allspice.cs.swarthmore.edu>
	<20010202023834.A17159@allspice.cs.swarthmore.edu>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Eisenbud writes:

> A patch will have to wait until tomorrow morning, but I have just burned
> my first CD in DAO mode!  :-)  The problem was a table in mesh.c and
> about four or five other drivers specifying which SCSI commands write
> data to the drive (as opposed to reading from it.)  send_cue_sheet
> (0x5d) was not in the table, nor mentioned in include/scsi/scsi.h.
> Adding the appropriate #define to scsi.h and the appropriate table entry
> to mesh.c fixed things nicely!

Great!  It's a long time ago now that I wrote the mesh driver, but
IIRC the mesh works best if the driver can predict what SCSI phases
are going to be needed in what order.  Recall that with SCSI, the
target (i.e. the disk or CD-writer or whatever) controls what kinds of
things (commands, data, messages, status etc.) get transferred on the
SCSI bus and in what direction, and the host is just supposed to obey.
With the mesh the driver sets it up for what would normally happen
next at each stage and if the target actually wants something
different, you get a phase mismatch error.  The driver then needs to
look at what the target wants and set up the mesh to do that.

As I said, it's been a while, and what I don't remember is whether the
mesh gives you a phase mismatch interrupt if you tell it to receive
data (do an IN operation) when the target also expects to receive data
(i.e. do an OUT operation).  I have a vague idea that it might do so
in PIO mode but not in DMA mode or something.  It's quite believable
that the whole thing would lock up in this situation.

> There are still some issues outstanding:
> 1)	The same table is duplicated in five or six drivers.  I think it
> would make lots of sense to have a macro for the case statment in just
> one place.  Should it go in scsi.h?  Or its own new file?

Well, it could be declared in scsi.h but the actual table of values
should go in a .c file.

> 2)	It's a little bit worrisome that the whole mesh bus locks up
> because of this.  What if some other unknown SCSI command tries to write
> data?  The whole problem will repeat itself.  How do most of the SCSI
> drivers avoid needing this information, or from what alternate source do
> they get it?  Is there something about OldWorld mac hardware that
> particularly makes mesh.c and mac53c94.c need this table?

See above.  I spent many long evenings back maybe 4 years ago
hammering on the mesh in my 7500, trying to get the driver to handle
all the possible situations that can arise.  I recall also that there
are bugs in the mesh that I had to work around.  The mesh is
documented in Apple's "Macintosh Technology in CHRP" document
reasonably well, but as a specification rather than as a user's manual
which might warn you about potential problems.

The 53c94 is another story; I never found any decent documentation for
it, I just had to work from the open firmware methods for it plus some
other drivers which seemed to be for similar chips.  I got the
mac53c94 driver to the stage where it seemed to work mostly but I
never had the time and the motivation to stress-test it and to
implement things like disconnect/reconnect.

> 3)	It continues to be worrisome that the mesh driver doesn't handle
> aborts right or retry lost arbitration (nor does mac53c94.)  Is there
> anywhere that the way to do these things is documented?  I'm willing to
> try my hand at fixing them.

I was never sure exactly how the higher levels of the scsi code
expected the host adaptor drivers (like mesh.c) to do aborts.  At the
time I tried to read the code but I found it to be quite opaque; it
was very complicated and not very well structured.  I haven't looked
at it lately, although I know Alan Cox was trying to tidy it up a bit
at one stage.

I thought the mesh driver did retry lost arbitration though.

If you want to try to fix the problems and implement the aborts and
resets properly, that would be great.  You would at least need a copy
of the SCSI-2 standard (or at least a late draft) plus the "Macintosh
Technology in CHRP" document.

Ideally the driver should cope with the target wanting to do an OUT
when we expect to do an IN, which would make it less critical that the
data_goes_out() function is correct.  The critical thing to find out
is whether the mesh gives you a phase mismatch exception in the case
where the target is expecting to do an OUT phase (i.e. receive data)
but we tell the mesh to do an IN phase with DMA.

> A quick patch will follow in the morning, and based on people's opinions
> about issue 1 above, I'll make a more definitive patch to send to Linus
> and Alan Cox and whoever one sends these things to.

I would very much like to see the proposed patches before they are
sent to Linus & Alan.

Paul.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
