Date: Wed, 8 May 2002 10:51:57 -0700
From: Matt Porter <mporter@mvista.com>
To: Armin <akuster@pacbell.net>
Cc: ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 4xx change to core files
Message-ID: <20020508105157.A28846@home.com>
References: <3CD9560E.9000909@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CD9560E.9000909@pacbell.net>; from akuster@pacbell.net on Wed, May 08, 2002 at 09:45:02AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 08, 2002 at 09:45:02AM -0700, Armin wrote:
> The core_ocp[] is don ein the following:
>
> new struct in asm-ppc/ocp.h
>
> struct ocp_def {
> 	enum ocp_type type;
> 	int paddr;
> 	int irq;
> };
 };

<snip>

> new ocp APIs:
>
> unsigned long get_ocp_paddr(int type, int dev_num);
>   returns the physical address for a given ocp type for the nth one.
>   this is used when the mmu is not completely up such as during pci
> bring up.

It would be helpful for 36-bit 4xx core implementations (440gp/440gx)
if the paddr used the phys_addr_t typedef so we could store a
native 64-bit address.

It would appear to me that one would expect to be able to do
the following:

	ioremap(get_ocp_paddr(<type>, <num>), <size>);

Is that the intention?

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
