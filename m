Date: Thu, 1 Feb 2001 11:50:15 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Chris Boot <bootc@worldnet.fr>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010201115015.A11149@allspice.cs.swarthmore.edu>
References: <20010130165710.B22219@allspice.cs.swarthmore.edu> <B69DFE88.9197%bootc@worldnet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B69DFE88.9197%bootc@worldnet.fr>; from bootc@worldnet.fr on Wed, Jan 31, 2001 at 05:40:24PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 31, 2001 at 05:40:24PM +0100, Chris Boot <bootc@worldnet.fr> wrote:
>
> >> It might be something PPC specific as well and have nothing to do with
> >> Paul's drivers.
> >
> > This is why I asked in a previous email whether anyone had ever burned
> > a disk in DAO mode successfully on a pmac or in fact on any powerpc
> > machine, but I've received no responses.  Hmm, maybe I should try to
> > conduct a quick survey of this on linuxppc-user and/or debian-powerpc.
>
> Well, I can't write a dao disk on my Panasonic CW-7502.  cdrecord complains
> that it can't send the cue sheet, but the SCSI bus doesn't die in any way, I
> can still mount and use disks on it afterwards (I only have the built-in
> CD-ROM and my CD-R on it).  I can provide exactly what cdrecord says and any
> other info if you wish.

That would be great -- any additional info that we can get helps.  Is
there a 200 second wait before it fails, or does it fail immediately?

> This is on a Performa 5400/180 with an early pull of the 2.4.0 kernel from
> bk.  Everything seems to be working fine, except for this (which isn't too
> important for me).

What SCSI driver do you use?  (If you don't know offhand, you should be
able to tell from the kernel boot messages.)

If you're willing to do a little bit more work, could you compile a
kernel with all the SCSI debugging support (there are two config
options) enabled, and before you try to burn a disk in DAO mode, type
(as root) "echo scsi log all > /proc/scsi/scsi"?  (The logging will be
turned off again when you next reboot.)  And then send us the resultant
syslog?

My working hypothesis is that there is something powerpc specific that
derails the send_cue_sheet command, but the lockup is because of the
mesh driver not handling the error well.  If this is correct, these
would both be good problems to fix.

Thanks,
Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
