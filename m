In-Reply-To: <000f01c48a95$e18e5c20$0301a8c0@chuck2>
References: <Pine.LNX.4.60.0408241141110.6489@localhost.localdomain> <000f01c48a95$e18e5c20$0301a8c0@chuck2>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FE902A72-F6AB-11D8-918A-003065F9B7DC@embeddededge.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: value of XIP?  and whether it works with 2.6 kernel?
Date: Wed, 25 Aug 2004 11:32:37 -0400
To: "Mark Chambers" <markc@mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 25, 2004, at 7:22 AM, Mark Chambers wrote:

> The main value, I believe, is as part of a rapid boot setup - you can
> avoid the decompress and copy phase.

The XIP has little effect on this.  Wolfgang hit the important points.
I originally did XIP on the 8xx many years ago for an embedded
appliance that was DRAM challenged.  It saved a little memory,
but along with it came the pinned TLB which helped a little with
performance.

The kernel code was tightly integrated with the initialization
code.  This is where the start up time was reduced.  The
initialization code was minimal, and it also immediately put
up some graphics on the screen which made the user
aware the appliance was "doing something."  After minimal
part set up, the kernel then started running was modified
to continue the screen update as it booted.  In the end, it
really didn't boot much faster, but at least the activity on
the screen was psychologically useful :-)

The three big things that slow down the boot process are
serial console output (which can be many seconds), timeouts
in the boot code waiting for user input, and diagnostic
tests (testing memory, checksum of images in flash, etc.)

With the large amount of memory in all systems these days,
XIP does nothing to help that.  The XIP on its own doesn't
do anything to speed up the operation of the system.   In
the whole of a system design XIP can be a useful tool, but
just enabling the option without any larger problem to
solve is just entertaining, not very useful :-)

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
