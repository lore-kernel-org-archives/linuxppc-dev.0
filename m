To: James Goodwin <jamesg@Filanet.com>
Cc: linux1394-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: SBP-2 on PPC
From: Daniel Berlin <dberlin@redhat.com>
Date: 26 Feb 2001 23:48:03 -0500
Message-ID: <x7k86cviik.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


More investigation shows that even thought we get a status writeback
saying we the request went okay, and no errors at all, it never
actually wrote the login response where we told it.

I memset'd the login response to all ff's, rather than all 0's, and
sure 'nuf, it was still all ff's afterwards.

Of course, then our command block orb has an address that's wrong,which  is invariably the reason the scsi commands timeout.

At first I thought it was probably a bug in my ohci fixes, but looking
back a few weeks, someone experienced this exact problem using the
pcilynx driver on a PPC.

So it's not likely to be my fault.

I tried every combination of byte swapping I can think of, with no
success. I tried fiddling with the flags we pass to allocate memory,
etc. you name the stupid little variable, i tried it.

The orb offset in the status block we get when it writes back the
status is correct for the login orb we sent.

Why would it be able to write *that* in our host memory, but not be
able to write something else in our host memory?

I've copied it to the PPC development list, in case somebody knows
something I don't.

--Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
