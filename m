Message-ID: <3AA7CB70.DCF55576@mvista.com>
Date: Thu, 08 Mar 2001 11:12:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sandpoint added to 2_5 tree
References: <3AA4293B.8633F08F@mvista.com> <3AA6F769.E9EE5931@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:

> "Mark A. Greer" wrote:
> >
> > For those of you with sandpoints, there has been sandpoint support
> > pushed out into the 2_5 tree.  It requires the patch at:
> > ftp://ftp.mvista.com/pub/Area51/sandpoint/sp_patch_2_5
>
> This is a "don't touch yourself", right?  Shouldn't this be generally
> useful (or required)?  Why don't other architectures have this
> problem and can we create a generic solution (i.e. we shouldn't have
> to hard-code the device number)?

Yes, its the "don't touch yourself" problem with 824x & 107 bridges.
Most boards don't have the IDSEL wired up so its not an issue for them.
I expect more & more people to start wiring it up, though, so I think it
will become more of an issue.

Yes, there should be some general feature for skipping PCI slots, it
just doesn't exist yet.  There are 2 places that this skip needs to be
put in, drivers/pci/pci.c and arch/ppc/kerner/pci_auto.c.  I chose to
make a patch instead of cluttering up those files (plus the
drivers/pci/pci.c #ifdef would probably never be accepted into
kernel.org).

Matt Porter has a scheme for doing the skipping (plus other stuff), he
just hasn't had the time to do it yet.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
