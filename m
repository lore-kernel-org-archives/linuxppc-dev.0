Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.221])
	by ozlabs.org (Postfix) with ESMTP id B077FB7CED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Feb 2010 07:17:26 +1100 (EST)
Message-ID: <4B85894A.6040406@neli.hopto.org>
Date: Wed, 24 Feb 2010 21:17:14 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexb@tundra.com>
Subject: Re: [PATCH 3/7] RapidIO: Add Port-Write handling for EM
References: <20100224152401.GC13661@kaneng01.tundra.com>
In-Reply-To: <20100224152401.GC13661@kaneng01.tundra.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	thomas.moll.ext@nsn.com, thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
>  /**
> + * rio_em_set_ops- Sets Error Managment operations for a particular vendor switch
> + * @rdev: RIO device
> + *
> + * Searches the RIO EM ops table for known switch types. If the vid
> + * and did match a switch table entry, then set the em_init() and
> + * em_handle() ops to the table entry values.

Shouldn't any RIO device be able to support error management, not just 
switches?

> +/**
> + * rio_pw_enable - Enables/disables port-write handling by a master port
> + * @port: Master port associated with port-write handling
> + * @enable:  1=enable,  0=disable
> + */
> +static void rio_pw_enable(struct rio_mport *port, int enable)
> +{
> +	if (port->ops->pwenable)
> +		port->ops->pwenable(port, enable);
> +}
> +

Maybe this can be done by switch->init function?

> +/**
> + * rio_inb_pwrite_handler - process inbound port-write message
> + * @pw_msg: pointer to inbound port-write message
> + *
> + * Processes an inbound port-write message. Returns 0 if the request
> + * has been satisfied.
> + */
> +int rio_inb_pwrite_handler(u32 *pw_msg)
> +{

Perhaps map this pw_msg to a struct? Or read it into named variables?

> +	/* Clear Port Errors */
> +	rio_mport_write_config_32(mport, destid, hopcount,
> +			rdev->phys_efptr + RIO_PORT_N_ERR_STS_CSR(portnum),
> +			err_status & 0x07120204);

Hardcoded value!

> +
> +	if (rdev->rswitch->port_ok & (1 << portnum)) {
> +		if (err_status & RIO_PORT_N_ERR_STS_PORT_UNINIT) {
> +			rdev->rswitch->port_ok &= ~(1 << portnum);
> +			rio_mport_read_config_32(mport, destid, hopcount,
> +				rdev->phys_efptr + RIO_PORT_N_CTL_CSR(portnum),
> +				&regval);
> +			rio_mport_write_config_32(mport, destid, hopcount,
> +				rdev->phys_efptr + RIO_PORT_N_CTL_CSR(portnum),
> +				regval | RIO_PORT_N_CTL_LOCKOUT);

You have a function for this?

> +			rio_mport_write_config_32(mport, destid, hopcount,
> +				rdev->phys_efptr +
> +					RIO_PORT_N_ACK_STS_CSR(portnum),
> +				RIO_PORT_N_ACK_CLEAR);

This doesn't work for the 568; but the 568 has no special handling?

> +	/* Clear Port-Write Pending bit */
> +	rio_mport_write_config_32(mport, destid, hopcount,
> +			rdev->phys_efptr + RIO_PORT_N_ERR_STS_CSR(portnum),
> +			RIO_PORT_N_ERR_STS_PW_PEND);
> +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI572, tsi57x_em_init, tsi57x_em_handler);
> +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI574, tsi57x_em_init, tsi57x_em_handler);
> +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI577, tsi57x_em_init, tsi57x_em_handler);
> +DECLARE_RIO_EM_OPS(RIO_VID_TUNDRA, RIO_DID_TSI578, tsi57x_em_init, tsi57x_em_handler);

Why not declare these along with the other ops?

Micha
