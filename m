Message-ID: <2156.80.7.99.14.1087499676.squirrel@www.solinno.co.uk>
In-Reply-To: <20040617185506.GA811@smtp.west.cox.net>
References: <1859.80.7.99.14.1086887283.squirrel@www.solinno.co.uk>
    <20040617185506.GA811@smtp.west.cox.net>
Date: Thu, 17 Jun 2004 20:14:36 +0100 (BST)
Subject: Re: [RFC][PATCH 7/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini said:
> On Thu, Jun 10, 2004 at 06:08:03PM +0100, Leigh Brown wrote:
>> This is to support the old OpenPICs in old E20/E30 machines.  They
>> seem to be mapped as I/O instead of memory mapped.  These also seem
>> to have a bug that the spurious interrupt always seems to be reported
>> as 255.  Changing the OPENPIC_VEC_SPURIOUS to 239 (which maps to
>> 255 after adding the offset of 16) seems to make it work.  As the
>> change seems to make no difference on other machines, it seems better
>> to do that than have special code for it.  However, I don't really
>> understand how this spurious vector stuff works, so....
>
> If we don't change OPENPIC_VEC_SPURIOUS, how do the E20/E30 behave?  Do
> they blow up badly, or just have some spurious bad interrupts?  I've
> played with that hunk a bit on a sandpoint and lopec, and didn't see
> anything go wrong (lopec didn't get any bad w/ or w/o, sandpoint, always
> gets a few bad ones).  If it's a non-fatal problem, I'd rather err on
> the side of caution, and leave it be, or export openpic_set_spurious, so
> you can give it the right setting on E20/E30.

It hangs on boot.  This is the code (trimmed) that has the problem:

arch/ppc/kernel/irq.c:

void do_IRQ(struct pt_regs *regs)
{
        .
        .
        .
        while ((irq = ppc_md.get_irq(regs)) >= 0) {
                ppc_irq_dispatch_handler(regs, irq);
                first = 0;
        }

arch/ppc/syslib/open_pic.c:

int openpic_get_irq(struct pt_regs *regs)
{
        int irq = openpic_irq();

        if (irq == openpic_cascade_irq && openpic_cascade_fn != NULL) {
                .
                .
                .
        } else if (irq == OPENPIC_VEC_SPURIOUS + open_pic_irq_offset)
                irq = -1;
        return irq;
}

As far as I understand it, the openpic ignores the spurious vector
setting, so when a spurious interrupt occurs, instead of setting
irq to -1, allowing do_IRQ to exit, it just returns 255 and we end
up in an infinite loop.

I think one way to do this is to make a new variable
openpic_spurious_vec, initialised to OPENPIC_VEC_SPURIOUS, then
override it to 239 when it detects the particular OpenPICs which
have this problem.  Does that sound okay?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
