Date: Mon, 29 Jan 2001 18:20:35 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010129182034.A25828@allspice.cs.swarthmore.edu>
References: <20010127195924.A19744@allspice.cs.swarthmore.edu> <Pine.LNX.4.30.0101291528550.2636-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0101291528550.2636-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@mail.biophys.uni-duesseldorf.de on Mon, Jan 29, 2001 at 03:29:16PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 29, 2001 at 03:29:16PM +0100, Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> wrote:
> > > > So put just that one line redirecting log output to /dev/tty7 into
> > > > syslog.conf temporarily and kill -1 syslogd before starting the test.
> > >
> > > I'll try this variation in a few minutes.
> >
> > This worked, but I didn't get any useful log output until I started
> > getting error 600 from the SCSI midlevel and errors from ext2fs.  I'm
> > going to try again, making sure that I have dmesg set as high as
>
> Please report the precise message text.

Here is what appears to be the relevant part of the log.  I have more of
it, which I can send to anyone if they need more context.  Note that in
the full log, there are _no_ _more_ messages from the mesh driver ever
after the last one you see in this segment.  It just crawls into a
corner and dies.

Note that this is from turning mesh debugging on for all hosts in
mesh.c, and turning on SCSI debugging by compiling in the option and
then doing "echo scsi log all > /proc/scsi/scsi".

-Daniel

Jan 29 10:42:50 cumulonimbus kernel: sg_unlink_reserve: req->use_sg=0
Jan 29 10:42:50 cumulonimbus kernel: sg_write: dev=2, count=78
Jan 29 10:42:50 cumulonimbus kernel: Open returning 1
Jan 29 10:42:50 cumulonimbus kernel: sg_write:   scsi opcode=0x5d, cmd_size=10
Jan 29 10:42:50 cumulonimbus kernel: sg_start_req: max_buff_size=32
Jan 29 10:42:50 cumulonimbus kernel: sg_link_reserve: size=32
Jan 29 10:42:50 cumulonimbus kernel: sg_write_xfer: num_write_xfer=32, use_sg=0
Jan 29 10:42:50 cumulonimbus kernel: Activating command for device 3 (1)
Jan 29 10:42:50 cumulonimbus kernel: scsi_do_cmd (host = 0, channel = 0 target = 3, buffer =c3490000, bufflen = 32, done = c00e149c, timeout = 20050, retries = 1)
Jan 29 10:42:50 cumulonimbus kernel: command : 5d  00  00  00  00  00  00  00  20  00
Jan 29 10:42:50 cumulonimbus kernel: internal_cmnd (host = 0, channel = 0, target = 3, command = c033c245, buffer = c3490000,
Jan 29 10:42:50 cumulonimbus kernel: bufflen = 32, done = c00e149c)
Jan 29 10:42:50 cumulonimbus kernel: queuecommand : routine at c00e39f4
Jan 29 10:42:50 cumulonimbus kernel: mesh_start: c033c200 ser=1518 tgt=3 cmd= 5d 0 0 0 0 0 0 0 20 0 use_sg=0 buffer=c3490000 bufflen=32
Jan 29 10:42:50 cumulonimbus kernel: leaving internal_cmnd()
Jan 29 10:42:50 cumulonimbus kernel: Leaving scsi_do_cmd()
Jan 29 10:42:50 cumulonimbus kernel: mesh: sending 1 msg bytes: c0
Jan 29 10:42:50 cumulonimbus kernel: sg_read: dev=2, count=36
Jan 29 10:42:50 cumulonimbus kernel: Open returning 1
Jan 29 10:46:10 cumulonimbus kernel: Command timed out active=1 busy=1 failed=1
Jan 29 10:46:11 cumulonimbus kernel: Error handler waking up
Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Checking to see if we need to request sense
Jan 29 10:46:11 cumulonimbus kernel: Command to ID 3 timedout
Jan 29 10:46:11 cumulonimbus kernel: Total of 0+1 commands on 1 devices require eh work
Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Checking to see if we want to try abort
Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Checking to see if we want to try BDR
Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Try hard bus reset
Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Try hard host reset
Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Take device offline
Jan 29 10:46:11 cumulonimbus kernel: Finishing command for device 3 6000000
Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Returning
Jan 29 10:46:11 cumulonimbus kernel: Clearing timer for command c033c200
Jan 29 10:46:11 cumulonimbus kernel: scsi_error.c: Waking up host to restart
Jan 29 10:46:11 cumulonimbus kernel: Calling request function to restart things...
Jan 29 10:46:11 cumulonimbus last message repeated 2 times
Jan 29 10:46:11 cumulonimbus kernel: scsi_error.c: device offline - report as SUCCESS
Jan 29 10:46:11 cumulonimbus kernel: Command finished 1 0 0x6000000
Jan 29 10:46:11 cumulonimbus kernel: Notifying upper driver of completion for device 3 6000000
Jan 29 10:46:11 cumulonimbus kernel: sg__done: dev=2, scsi_stat=0, res=0x6000000
Jan 29 10:46:11 cumulonimbus kernel: Deactivating command for device 3 (active=0, failed=0)
Jan 29 10:46:11 cumulonimbus kernel: Error handler sleeping
Jan 29 10:46:11 cumulonimbus kernel: sg_finish_rem_req: res_used=1
Jan 29 10:46:11 cumulonimbus kernel: sg_unlink_reserve: req->use_sg=0

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
