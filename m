Message-ID: <3CFD3AEF.9020908@embeddededge.com>
Date: Tue, 04 Jun 2002 18:10:55 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: pt_regs.dbcr0/1
References: <D68E7052-7802-11D6-B64C-003065BFB10E@motorola.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kumar Gala wrote:

> I am not seeing where the other debug registers that are associated with
> the debug state are being state changed and managed....


They aren't, and are the reason for the gdb 4xx-aware discussion.  Today,
all of those features are handled in the generic manner with code modification.
The only thing the debug registers are used to support are single step.
If the book-E MSR would have kept the single step, we wouldn't need any
of the debug context switching to be compliant with other PPCs.

Many of the processors have some form of (incompatible :-) hardware debug
capability.  I know the external debuggers use these registers, but we
don't use these with standard software tools.  I guess if we knew gdb
was setting a breakpoint (instead of just the modification of memory), we
could have the kernel set these registers.  The alternative is to make
gdb aware of all of these different hardware debug capabilities and have
some interface to support it.

This isn't a 4xx or even book-E specific discussion.  The MPC8xx, and I
believe the 7xx and 74xx all have some form of hardware debug support
accessible from software.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
