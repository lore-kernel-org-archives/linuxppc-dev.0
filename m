Date: Thu, 24 Jan 2002 17:54:29 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: OpenPIC_NumInitSenses
Message-Id: <20020124175429.32e84f7c.adrian@humboldt.co.uk>
In-Reply-To: <15439.64102.68217.293733@argo.ozlabs.ibm.com>
References: <15439.64102.68217.293733@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Jan 2002 23:13:26 +1100 (EST)
Paul Mackerras <paulus@samba.org> wrote:

> Who was it that wanted this horrible hack in open_pic.c?

I've been using it to deal with the DMA interrupts on the MPC107.

> 	/* Needed because of the way we overload EPIC on a standard
> 	 * Open PIC structure.
> 	 */
> 	if (OpenPIC_NumInitSenses > NumSources)
> 		NumSources = OpenPIC_NumInitSenses;
> [...]

> 	openpic_set_sources(0, 16, NULL);
> 	openpic_set_sources(16, 16, ioremap(isr_base, 16 * 32));
>
> (Actually maybe I should let openpic_set_sources do the ioremap.)
>
> Comments?

Looks like a lot less of a hack than the current system. I'll have to
renumber the DMA interrupts, but that's trivial work. I'm happy with
doing the ioremap in my own platform code, and it provides flexibility
for boards which have already mapped their openpic registers with
io_block_mapping().

--
Adrian Cox
http://www.humboldt.co.uk/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
