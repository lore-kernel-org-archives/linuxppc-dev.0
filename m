Date: Thu, 8 Mar 2001 03:51:51 -0700
From: Matt Porter <mmporter@home.com>
To: Dan Malek <dan@mvista.com>
Cc: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Sandpoint added to 2_5 tree
Message-ID: <20010308035151.A17584@cx258813-a.chnd1.az.home.com>
References: <3AA4293B.8633F08F@mvista.com> <3AA6F769.E9EE5931@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AA6F769.E9EE5931@mvista.com>; from dan@mvista.com on Wed, Mar 07, 2001 at 10:07:21PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 07, 2001 at 10:07:21PM -0500, Dan Malek wrote:
>
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

The generic solution has already been proposed on the commit list
in some other thread.  My PCI "exception" system would provide a
system to take care of this (among other things).  In the case of
a "don't touch" exception you have to have bus and devfn. Of course,
bus doesn't mean much since it's abstracted in multi hose systems.
Now, ideally we would use an IDSEL path/tree to uniquely identify a
device and eventually couple that with a hose identifier since it's
possible to have duplicate IDSEL chains on two separate hoses.

For the first cut, I'm just using bus/devfn to identify the device.
The exceptions can be registered as part of a device driver or
in the arch/ppc/ bringup code, wherever is the logical place
to put it.  In the case of the Sandpoint's problem (feature),
the exception should be registered in sandpoint_pci.c since it's
board specific.

Anyway, the kludge is all we should do for now...

Oh, and yes I'm planning to show the code when I make enough time to
finish it...

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
