Message-ID: <3CFC16A4.7090902@embeddededge.com>
Date: Mon, 03 Jun 2002 21:23:48 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pt_regs.dbcr0/1
References: <15608.22230.504008.818858@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> Is anyone prepared to speak up for the dbcr0 and dbcr1 fields that
> someone added to struct pt_regs for 4xx in the 2_4_devel tree?

I believe they were moved because those registers are copied between
the application context and the debugger.  I was part of making this
work, but not for moving the registers :-)  IIRC, the reason was we
wanted gdb to be '4xx-aware' so it could use more of the debug capabilities.
There is also a problem of context switching these registers when you
are trying to debug the kernel or applications.

> If not, they are going.  If so, we can discuss it.

You just can't toss them, they have to be context switched, but I think
the thread struct is the proper place.  There are always problems with
trying to run any combination of background debuggers, kgdb, or application
gdb at the same time, which raises the discussion as to where these
registers should be context switched.  I think we just resign ourselves
to only one debug interface active at a time and simplify the kernel.


> Better still, does anyone have a clearly thought-out vision of how the
> debug facilities on 4xx should be managed?

With better hardware support? :-)  The debug registers just have to be
context switched between the different threads (and the kernel if you
want to debug that as well).  A separate discussion is how much we want
gdb to be specifically aware of the 4xx, which will change the kernel
ptrace() interface and functions.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
