Date: Thu, 17 Jun 2004 09:14:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC][PATCH 2/9] Support for old IBM PReP boxes
Message-ID: <20040617161401.GJ24479@smtp.west.cox.net>
References: <1822.80.7.99.14.1086886383.squirrel@www.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1822.80.7.99.14.1086886383.squirrel@www.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 10, 2004 at 05:53:03PM +0100, Leigh Brown wrote:

> 1. It works much earlier on due to setting up the BATs.  This is code
> I stole from pplus_setup.c.
[snip]
> +/*
> + * Set BAT 2 to access 0x80000000 so early progress messages will work
> + */
> +static __inline__ void
> +prep_set_bat(void)
> +{
> +	static int mapping_set = 0;
> +
> +	if (!mapping_set) {
> +		/* wait for all outstanding memory access to complete */
> +		mb();
> +
> +		/* setup DBATs */
> +		mtspr(DBAT2U, 0x80001ffe);
> +		mtspr(DBAT2L, 0x8000002a);
> +
> +		/* wait for updates */
> +		mb();
> +
> +		mapping_set = 1;
> +	}
> +}

This change will never die, will it?  This should be just (stolen from
current pplus.c):
/*
 * Set BAT 2 to access 0x8000000 so progress messages will work and set BAT 3
 * to 0xf0000000 to access Falcon/Raven or Hawk registers
 */
static __inline__ void pplus_set_bat(void)
{
        /* wait for all outstanding memory accesses to complete */
        mb();

        /* setup DBATs */
        mtspr(DBAT2U, 0x80001ffe);
        mtspr(DBAT2L, 0x8000002a);
        mtspr(DBAT3U, 0xf0001ffe);
        mtspr(DBAT3L, 0xf000002a);

        /* wait for updates */
        mb();
}

But aside from that, it's ok.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
