Message-ID: <3A82EED9.59E1519D@mvista.com>
Date: Thu, 08 Feb 2001 14:09:13 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: DMA mapping and loadable modules
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It's amazing how things like this happen.........Today, at least
three different instances of this bug appeared, including one of
my own.

There is a problem when loadable drivers with "static" data stuctures
try to determine the physical address for DMA.  The "virt_to_bus"
macro doesn't work for these (or for any dynamically allocated memory).
These drivers will work fine when compiled in, and break when loaded
as modules.

As part of the IBM4xx and MPC8xx updates I have hanging around in my
tree, I have modified the virt_to_bus and other macros to be a little
smarter, and work the same on all platforms.  Basically, if there isn't
a BAT or other large mapping, it will search the page tables for the
proper physical address.  It still doesn't work exactly correct on the
PMac, but I hope to have it done today.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
