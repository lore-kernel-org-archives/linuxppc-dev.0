From: Benjamin Herrenschmidt <bh40@calva.net>
To: Joseph Garcia <jpgarcia@execpc.com>, <linuxppc-dev@lists.linuxppc.org>,
        <sleemburg@jvc.nl>
Subject: Re: powerbook hang from post-sleep cdrom access - fix
Date: Thu, 27 Jul 2000 12:32:26 +0200
Message-Id: <20000727103226.13755@mailhost.mipsys.com>
In-Reply-To: <397FEEE5.265963BF@execpc.com>
References: <397FEEE5.265963BF@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>So would this always be done on wake to hdc and hde?  I read Pismos, and
maybe
>iBooks, have their drives at hde.  I'm not sure if they are afflicted by this
>problem.

That's why this should be done from the kernel, I beleive. There, you can
know if the controller is hosting a hard disk, a cdrom or an ATAPI floppy.

>might also need to consider ide-floppy drives, like ls-120 and zip.  I don't
>have one myself, so I don't know if these need it either.  They dont
have much
>for ioctls, just eject.  If they have this problem, an ioctl to
>idefloppy_media_change may be needed.

Yep, probably, I'm not sure about those since I don't have one to test
with. I'm also considering adding code for force a disk access (spin up)
before trying to do the set features on wakeup.

>I'm not concerned about it, but might genuine floppies have the hang problem
>too?
>
>I assume a bay hard drive would error/exit without a problem because they
>can't
>change.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
