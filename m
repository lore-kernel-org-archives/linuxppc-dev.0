Message-ID: <3A8C5613.662D35DA@mvista.com>
Date: Thu, 15 Feb 2001 14:20:03 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: calling giveup_altivec on machine with no altivec!?
References: <20010215160658.P26702@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:
>
> My Motorola MTX just crashed after the following code in _swithc_to
> executed:
>
>         if ((prev->thread.regs && (prev->thread.regs->msr & MSR_VEC)))
>                 giveup_altivec(prev);
>
> Somehow prev->thread.regs->msr & MSR_VEC turned out true. I'm suspecting
> something got overwritten somewhere..
>
> This is an SMP machine so I'm wondering if there wasn't a race condition
> on something with task structs..

Is it possible that the MSR had the MSR_VEC bit set at some point?  One
IBM processor user's manual says "the reserved fields should be written
as 0 and read as __undefined__.  This is, when writing to a register with
a reserved field, write a 0 to the reserved field.  When reading from a
register with a reserved field, ignore that bit."

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
