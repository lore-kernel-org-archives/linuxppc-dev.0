From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 11 Mar 2003 11:45:11 -0700
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030311184511.GA3776@rover.farnsworth.org>
References: <15973.18737.651334.824024@argo.ozlabs.ibm.com> <20030305010318.6A4D3C6E0C@atlas.denx.de> <15973.24544.124365.553602@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15973.24544.124365.553602@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 05, 2003 at 02:24:32AM +0000, Paul Mackerras wrote:
> Well, there is no reason why the secondary hold code shouldn't just
> reference an ordinary variable in the kernel data section.  It would
> take a couple more instructions, but that shouldn't be a problem.  The
> starting address for the secondary hold code needs to be well-known
> (at least to the prep boot wrapper) but the variable that it spins on
> doesn't.
>
> Paul.

I took a stab at implementing this.  It's simple when the kernel text
and data are relocated as a unit and PIC references work.  Unfortunately,
that doesn't always happen.  On OF machines, prom_hold_cpus() in
prom_init.c only copies the first 0x100 bytes of kernel text to
location 0 and starts the secondary cpus running at secondary_hold()
within that area.  I thought of passing in a pointer to kernel data,
but that's not sufficient because it looks like in some cases kernel
data is relocated while secondary_hold() is running.

So, if kernel data may be relocated while secondary_hold is polling,
the polled location can't be in kernel data.  Location 0x0 and 0x4 are
beginning to look good to me.

Does this seem right, or am I misreading the code?

-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
