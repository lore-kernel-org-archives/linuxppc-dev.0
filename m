Date: Fri, 21 Jun 2002 10:52:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Trivial cleanup in ocp_uart.c
Message-ID: <20020621005216.GH20689@zax>
References: <20020620073440.GC20689@zax> <20020620155026.GE16052@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020620155026.GE16052@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 20, 2002 at 08:50:26AM -0700, Tom Rini wrote:
>
> On Thu, Jun 20, 2002 at 05:34:40PM +1000, David Gibson wrote:
>
> > ocp_uart.c allocates private space with ocp_alloc_dev, but never uses
> > it.
>
> Er...  So you pass 0 to ocp_alloc_dev() ?  Which will allocate
> (sizeof(*ocp_dev) + 0 + 31), so we don't actually break out of this
> loop which I take it was your intent.

No that wasn't my intent.  It's just that we never use the private
space, so there's no point allocating it.  Passing zero is the best we
can do for now (and it's what every other ocp driver except i2c does
now).  Actually I'd like drivers to include struct ocp_dev as part of
their own internal private structures rather than the other way around
(i.e. I think the ocpdev field should go away entirely).
I2C needs some rearranging to do this though (rearranging which will
also let the vaddr field be removed).

> And I think it can be used, once it gets registered to the ocp_list (and
> something later accesses it).

*Nothing* scans the ocp_list (well, except ocp_register() and
ocp_unregister()).  This is why I think ocp_register() is a pointless
interface.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
