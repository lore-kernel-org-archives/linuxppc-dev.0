Subject: Re: [PATCH][RFC] OCP support for MPC107 and relatives
From: Adrian Cox <adrian@humboldt.co.uk>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <FF1E1EF0-BE0A-11D8-91C4-000393DBC2E8@freescale.com>
References: <1087207803.7360.83.camel@newt>
	 <FF1E1EF0-BE0A-11D8-91C4-000393DBC2E8@freescale.com>
Content-Type: text/plain
Message-Id: <1087224423.7360.323.camel@newt>
Mime-Version: 1.0
Date: Mon, 14 Jun 2004 15:47:04 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-14 at 14:59, Kumar Gala wrote:
> Is there a reason why we dont support the 106 as well for OCP?  Do you
> know if this will match for the 8241 and/or 824x?

According to my 106 user manual it's a pure northbridge, without I2C
unit, DMA, or interrupt controller. The code should work for the 824x
family, but I don't have any of them.

> > -	if (host_bridge != MPC10X_BRIDGE_106) {
> > +	if (host_bridge == MPC10X_BRIDGE_106) {
> > +		/* On-chip peripherals were introduced with the MPC107/MPC8240 */
> > +		core_ocp[0].vendor = OCP_VENDOR_INVALID;
> > +	} else {
> >  		early_read_config_byte(hose,
> >  				       0,
> >  				       PCI_DEVFN(0,0),
>
> My only other comments relate to consistency with how we are doing
> things for 85xx with regards to OCP.  For example, how the config
> options are handled (added a FSL_OCP) and how we update the paddr field
> based on eumbar.  Also, I believe we have an ocp interface to delete an
> OCP entry [which may or may not apply].

I've just done a bk pull which has fetched your 85xx ocp code. I can
copy your config approach and make MPC10X_BRIDGE set FSL_OCP.

As for the updates based on EUMBAR, we do them at the same time. I've
done them in syslib code rather than platform code, because I'm trying
to minimise the board specific code. My goal is for the platform
directory to contain the minimum amount of code necessary to describe
how the board vendor connected the chip. I have the added complication
that the board vendor may not have wired the MPC107 OpenPIC to the IRQ
line of the PowerPC. With the 824x and 85xx they don't have the ability
to make that mistake.

- Adrian Cox
Humboldt Solutions Ltd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
