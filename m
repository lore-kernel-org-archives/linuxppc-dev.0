MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15027.39447.636455.251242@ipa.ne.mediaone.net>
Date: Sat, 17 Mar 2001 12:08:39 -0500
From: R Shapiro <reshapiro@mediaone.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: scsi cd-r problem in linuxcare kernel 2.4.3-pre3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a G4 single processor 450 with the usual builtin ide cd/dvd
drive and an external scsi cd-r connected to an Adaptec card (AIC7XXX
driver).  For awhile now I've been running kernels with ide-cd
disabled and ide->scsi emulation enabled, so I can treat the internal
cd drive as a scsi device (cdda2wav requires this).  This worked fine
through 2.4.2 but stopped working properly in 2.4.3-pre3.

In particular, if I run a 2.4.3-pre3 kernel configured in this way,
I'm unable to write a cd from an iso image file.  But if I enable
ide-cd and disable ide->scsi emulation, in other words if I treat the
internal drive as ide rather than scsi, I have no problem writing an
image file to cd-r.  Note that I'm not trying to copy a cd, I'm just
dumping a mkisofs image file sitting on /dev/hda.  I'm not accessing
the internal cd at all for this operation.

I'm sure scsi changed in some way between 2.4.2 and 2.4.3-pre3, since
the device mapping is different.  Up through 2.4.2, the internal cd
drive would be mapped to /dev/scd0 if the external cd-r was off at
boot time, and to /dev/scd1 if the cd-r was on at boot time (the cd-r
would be /dev/scd0 in the second case).  In 2.4.3-pre3, the internal
drive is always /dev/scd0 and the external cd-r drive is /dev/scd1 if
it's on at boot time.

Is this a newly introduced kernel bug, related to whatever has changed
in scsi support, or is it something wrong with my local config? I'd
like to switch the internal drive back to scsi if I can.


--
reshapiro@mediaone.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
