Date: Sun, 28 Jan 2001 02:16:59 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010128021658.A18189@allspice.cs.swarthmore.edu>
References: <20010126160441.B16573@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de> <20010127163115.B2695@allspice.cs.swarthmore.edu> <20010127195924.A19744@allspice.cs.swarthmore.edu> <20010127202500.A21618@allspice.cs.swarthmore.edu> <20010127213401.A26295@allspice.cs.swarthmore.edu> <20010128000929.A9218@allspice.cs.swarthmore.edu> <20010128001147.B9218@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010128001147.B9218@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sun, Jan 28, 2001 at 12:11:47AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


More output.  It looks like SCSI dies when cdrecord sends the cue sheet,
which it only does in DAO mode, the SCSI driver dies, as exemplified in
this portion of its output in verbose mode:

Executing 'send_cue_sheet' command on Bus 0 Target 3, Lun 0 timeout 200s
CDB:  5D 00 00 00 00 00 00 00 20 00
DMA addr: 0x100404F0 size: 32 - using copy buffer
pack_len: 36, reply_len: 36 pack_id: 70 result: 0 sense[0]: 00
cmd finished after 200.500s timeout 200s

As you can see, it times out.  Attached is a bzip2'ed tar file of the
strace output (with timings, this time) and output of burning the same
very short track (which happens to be the TOC of an audio CD, not that
it seems to matter) in TAO mode and DAO mode.

Now to get to the bottom of what about the "send_cue_sheet" command is
losing.  But I need to get some sleep first.  If anyone has any ideas
about what I might do to actually see the packet and actually watch what
happens as it goes through the SCSI subsystem, that would be great.  I
can see xmon looming in my future.  :-)

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
