Date: Sat, 27 Jan 2001 21:34:01 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010127213401.A26295@allspice.cs.swarthmore.edu>
References: <20010126160441.B16573@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101262206390.1670-100000@zirkon.biophys.uni-duesseldorf.de> <20010127163115.B2695@allspice.cs.swarthmore.edu> <20010127195924.A19744@allspice.cs.swarthmore.edu> <20010127202500.A21618@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010127202500.A21618@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sat, Jan 27, 2001 at 08:25:00PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 27, 2001 at 08:25:00PM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
> In fact, it looks like the mesh driver has significant debugging code.
> My last attempt of this evening will be to turn that on and see if it
> does anything.  If not, I'll look at this again tomorrow or the day
> after.

Well, the mesh driver debugging code did not trigger.  However, I have
some new information: cdrdao eventually exits with
"cdrdao: Device not configured.  Cannot set SG_SET_TIMEOUT"
I also get a message that the SCSI subsystem gave a return code of
6000000 (looking at the source, this is actually in hex) while trying to
access my internal disk.

There also appear to be reports of this happening on the single
(non-mesh) SCSI bus of a powermac 7200.  I just replied to one of them
on the mailing list.  In that case, it's not clear that this only dies
when trying to burn in disk-at-once mode.  There's another report of
trouble on the mailing list from someone who was trying to burn in
disk-at-once mode but didn't specify on what hardware.  I'm about to
respnd to that one to see if I can get a little bit closer to tracking
this down.  The non-mesh report makes me wonder if the problem is in
some other layer.  Maybe the sg driver has a subtle endianness issue on
PowerPC?  Has anyone ever successfully burned a disk in disk-at-once
mode with a SCSI CD-R or CD-RW on a powerppc machine?  On a powermac?

Maybe the next thing to do (why didn't I think of this sooner?) is to
strace cdrdao and cdrecord and see what system call they're really
hanging in, and what difference there is between what they do in dao
mode and what they do in tao mode.  More later!

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
