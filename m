Subject: Re: Anyone using an IBM RISCWatch ICE?
To: "Wright, David" <dwright@infiniswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF066CA2C2.DF02D161-ON85256AA9.005D3E88@raleigh.ibm.com>
From: "John F Davis" <johndavi@us.ibm.com>
Date: Wed, 15 Aug 2001 13:15:25 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I am not a riscwatch expert, but its the only thing I've ever used.  Maybe
I can help.


I don't know how you could use the virtual address.  But, here is a simple
thing you can do.  Insert a tight loop in the code where you want to break,
like:

jump:
     if (foo) {
          goto jump;
     }

Then run your code and stop it. When things are to your liking, clear
foo and restart it.

Also, when you stop the code, examine the IAR.  Maybe the physical address
you were using wasn't the same one
the IAR shows.

Lastly, when you are stopped, be careful about examining memory.  By
default the memory window will try to examine memory
at location 0.  On the 405 system I use, this causes a page fault and thus
oops my kernel when I restart it.  I don't if this is happening to
you when you reach your breakpoint or not.  I fixed this problem my using a
TLB entry to map memory address zero to a non used
location.  That way I can use the memory window.  If you know how to bring
up the memory window at an address other than
zero I would like to know.

I am sure that when Chip gets off vacation, he can help you more.

Good luck,

John



"Wright, David" <dwright@infiniswitch.com>@lists.linuxppc.org on 08/15/2001
11:12:17 AM

Sent by:  owner-linuxppc-embedded@lists.linuxppc.org


To:   <linuxppc-embedded@lists.linuxppc.org>
cc:
Subject:  Anyone using an IBM RISCWatch ICE?




Hi,

I've been attempting to use an IBM RISCWatch ICE on a Walnut system
and I'm having problems.  (Spare me any lectures about how I should
be using a BDI.  I'm just trying to find out how usable the IBM is,
since it's already here.)

The specific problem I'm trying to solve is this:  how do I set a
breakpoint early in kernel startup, say at start_kernel (just as
the MMU is enabled)?  I've tried booting the Walnut so that it
comes up into its ROM monitor, then stopping it with the ICE, and
setting a hardware breakpoint at the start_kernel virtual address.
Problem is, when I start the CPU running again, the Walnut is no
longer responding to the keyboard (serial line).  Can't do anything
except reset it at that point.  Using the ICE reveals that the CPU
is still running, but I have no real idea what it's doing.  It sure
isn't responding to the serial port.

As an alternative, I tried setting a hardware breakpoint at the
physical address of "start_here".  That doesn't hang, but the
breakpoint is never hit, either.

Any ideas gratefully accepted.  I've tried this kind of thing with
a BDI and had no problems.

  -- David Wright, InfiniSwitch Corp.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
