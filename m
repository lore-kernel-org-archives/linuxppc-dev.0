Date: Tue, 15 Jul 2003 16:51:16 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
Message-ID: <20030715165116.B8616@home.com>
References: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com> <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com> <20030715091731.C6208@home.com> <5.1.0.14.2.20030715092123.02ef0d20@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030715092123.02ef0d20@mail.ebshome.net>; from ebs@ebshome.net on Tue, Jul 15, 2003 at 09:27:10AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 15, 2003 at 09:27:10AM -0700, Eugene Surovegin wrote:
>
> At 09:17 AM 7/15/2003, Matt Porter wrote:
> >I'll agree that it's a better hack, but since the offending areas in
> >the SCSI subsystem are easily located, it seems wiser to fix upstream.
>
> Matt, the problem is it wasn't that *easy* to locate this, at least for me :)
> I'm not sure that this is the only place..

I didn't mean to trivialize the difficulty of finding this from the path
of tracking the symptom to the source. :)  I merely was pointing out
that now that you know the source of the problem, it's not *too* difficult
to look for buffers allocated on the stack by simple inspection of the
SCSI code.  I only jumped in on this because I felt a little guilty that
when I noticed this sometime back I got distracted and never tried to
send a patch to the maintainers. :-/

> >We still need someone with interest AND time to properly fix the
> >consistent alloc from irq issue. :)  All of the patches post to date
> >are incomplete bandaids.
>
> Uhh, I switched to solution which uses pre allocated consistent memory (10
> pages are enough for sym53c8xx_2).
> It's still not a generic solution, but at least it's safe :)

Are you doing this in the sym_2 driver or in the ppc consistent_*
implementations?  I only ask because I finally convinced myself
recently that attempting to make all the locking safe in the VM
subsystem was too much work.  I think Paul suggested at one point
that we might just preallocate a pool for atomic consistent allocations
anyway.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
