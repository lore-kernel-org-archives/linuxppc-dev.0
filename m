Date: Tue, 15 Jul 2003 09:25:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
Message-ID: <20030715162506.GR1211@ip68-0-152-218.tc.ph.cox.net>
References: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com> <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com> <5.1.0.14.2.20030715091031.029e37b0@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030715091031.029e37b0@mail.ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 15, 2003 at 09:20:24AM -0700, Eugene Surovegin wrote:
> At 08:46 AM 7/15/2003, Tom Rini wrote:
> >Well, one thing that is worth noting is that the USB people knew this
> >was a problem, and it was / should have been fixed in the 2.5 cycle.
> >Similarly, SCSI was cleaned up a lot, so perhaps this has been fixed
> >there.  I think it's generally known that doing DMA off of the stack is
> >a bad idea, and should be fixed when found.
>
> I agree this is VERY bad idea but the fact is that there is a code which
> does such nasty things.
>
> I truly hope all this will/was fixed in 2.5 but frankly I wouldn't be so
> sure :)

Well, I would be, of the USB code.  SCSI might have had it fixed, and
others that we haven't found yet may or may not.  But the important
point is that doing this is a driver bug and it's OK to beat driver
authors over the head with patches to fix the behavior. :)

> Unfortunately, for production 2.5 is unusable and will be for some time.
> A lot of people (I think majority) still use 2.4. And 2.4 (as of
> 2.4.22-pre6) is still broken in this respect...

Yes, the changes to USB and SCSI probably won't be backported for some
time, if ever.  So there is still a question of should we workaround
this in 2.4 (Or, more to the point, do we leave it up to every
$(EMBEDDED VENDOR) to do it, or bite the bullet and commit it to the 2.4
mainline.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
