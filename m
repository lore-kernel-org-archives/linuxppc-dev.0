From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 21:28:34 -0700
To: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030305042834.GA5355@rover.farnsworth.org>
References: <15973.18737.651334.824024@argo.ozlabs.ibm.com> <20030305010318.6A4D3C6E0C@atlas.denx.de> <15973.24544.124365.553602@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15973.24544.124365.553602@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 05, 2003 at 02:24:32AM +0000, Paul Mackerras wrote:
> Wolfgang Denk writes:
>
> > BTW: _all_ this writing to kernel text is a Bad  Thing  (TM),  as  it
> > makes XIP (for example running from ROM) really difficult.
>
> Well, there is no reason why the secondary hold code shouldn't just
> reference an ordinary variable in the kernel data section.  It would
> take a couple more instructions, but that shouldn't be a problem.  The
> starting address for the secondary hold code needs to be well-known
> (at least to the prep boot wrapper) but the variable that it spins on
> doesn't.
>
> Paul.

Well, that does add the requirement that kernel data be mapped at its
linked-at address before __secondary_hold references said variable.

By the way, the recent addition of the call to smp_call_init_cpu,
places the same requirement on __secondary_start, unfortunately.

-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
