Date: Thu, 13 Jun 2002 17:51:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614005156.GE13541@opus.bloom.county>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <20020614002419.GM4228@zax> <20020614003807.GD13541@opus.bloom.county> <20020614004539.GB26146@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614004539.GB26146@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 10:45:39AM +1000, David Gibson wrote:
> On Thu, Jun 13, 2002 at 05:38:07PM -0700, Tom Rini wrote:
[snip]
> > Er, the problem of setting dma_handle twice?
>
> Well, it fixes that and as a bonus gets rid of the ifdefs in
> pci_{alloc,free}_consistent() and means that if we ever port a driver
> using consistent_{alloc,free}() to a processor that *is* cache
> coherent it will Just Work.

In theory at that point OCP would either have its API fully flushed out
or be applied nicely on top of the generic driver work in 2.5 and it
would just work anyhow :)

> > My only concern is that are things still consistent on non consistent
> > procs?
>
> Absolutely - no change to the code path at all on non cache coherent
> processors.

So kmalloc/kfree are equivilent to __get_free_pages/free_pages ?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
