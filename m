Return-Path: <dwg@au1.ibm.com>
Date: Fri, 11 Dec 2009 11:53:44 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 02/03] powerpc: Add definitions for Debug Registers
	on BookE Platforms
Message-ID: <20091211005344.GB8852@yookeroo>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 10, 2009 at 01:57:21PM -0200, Dave Kleikamp wrote:
> powerpc: Add definitions for Debug Registers on BookE Platforms
> 
> From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
> 
> This patch adds additional definitions for BookE Debug Registers
> to the reg_booke.h header file.
> 
> Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

As with patch 1/3, none of the comments below is anything that
couldn't be fixed up after merging.  So,

Acked-by: David Gibson <dwg@au1.ibm.com>

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
> Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
> Cc: David Gibson <dwg@au1.ibm.com>
> Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
> ---
> 
>  arch/powerpc/include/asm/processor.h |   30 +++++-
>  arch/powerpc/include/asm/reg_booke.h |  176 +++++++++++++++++++++++++++++-----
>  2 files changed, 178 insertions(+), 28 deletions(-)

[snip]
> +	/*
> +	 * The following will contain addresses used by debug applications
> +	 * to help trace and trap on particular address locations.
> +	 * The bits in the Debug Control Registers above help define which
> +	 * of the following registers will contain valid data and/or addresses.
> +	 */
> +	unsigned long	iac1;
> +	unsigned long	iac2;
> +	unsigned long	iac3;
> +	unsigned long	iac4;
> +	unsigned long	dac1;
> +	unsigned long	dac2;
> +	unsigned long	dvc1;
> +	unsigned long	dvc2;

I think you'd make the logic in patch 3 substantially easier, if you
defined these as
	unsigned long iac[4];
	unsigned long dac[2];
	unsigned long dvc[2];
instead of as individual structure members.

[snip]
> +#define DBCR0_USER_DEBUG	(DBCR0_IDM | DBCR0_ICMP | DBCR0_IAC1 | \
> +				 DBCR0_IAC2 | DBCR0_IAC3 | DBCR0_IAC4)
> +#define DBCR0_BASE_REG_VALUE	0

These constants are left over from when the interface allowed
more-or-less direct access to the debug regs.  I don't think the
USER_DEBUG constant is used at all any more, and the BASE_REG_VALUE is
just used in the load_default function, and might as well be inline
there.

[snip]
> +
> +#define dbcr_iac_range(task)	((task)->thread.dbcr0)

Hrm, I think the way these macros work to do the 40x vs. BookE
abstration is kind of ugly.  But an unequivocally better way doesn't
immediately occur to me.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
