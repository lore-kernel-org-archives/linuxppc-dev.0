In-Reply-To: <1091620178.2578.97.camel@c68.115.86.108.roc.mn.charter.com>
References: <1091574342.2578.83.camel@c68.115.86.108.roc.mn.charter.com> <20040803171641.B5454@home.com> <1091620178.2578.97.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7FA32080-E634-11D8-852B-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Large TLBs on 40x
Date: Wed, 4 Aug 2004 12:36:56 -0400
To: Josh Boyer <jwboyer@charter.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 4, 2004, at 7:49 AM, Josh Boyer wrote:

> Maybe pinning a read-only TLB entry for most of the text pages for
> however large you can get would work...  or maybe not.

The problem is BATs and pinned TLBs require alignment restrictions
that don't allow this.

> .....But when someone is writing new drivers, randomly poking
> holes in the kernel text pages and then executing instructions from
> there leads to some strange panics.  Although, the new driver should be
> suspect in that case anyway :).

Then, on MPC8xx don't select pinned TLBs to cover the kernel
space, and on traditional PPC MMUs select  the 'nobat' option
on the command line.  This will write protect the kernel text pages.
However, if you select something like CONFIG_KGDB, this will
allow writing of the text pages to set breakpoints.  You will need
to use a debugger like the BDI2000 and use hardware breakpoints
to do your debugging.  When you are done, you can enable the
performance TLB options again.  I thought the 4xx allowed
something like this as well.  If not, it could and probably should.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
