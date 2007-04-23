Return-Path: <halr@voltaire.com>
Received: from mailgw.voltaire.com (mailgw.voltaire.com [193.47.165.252])
	by ozlabs.org (Postfix) with ESMTP id 6E9EDDDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 03:21:07 +1000 (EST)
Subject: Re: [ofa-general] [PATCH] eHCA: Add "Modify Port" verb
From: Hal Rosenstock <halr@voltaire.com>
To: Joachim Fenkes <fenkes@de.ibm.com>
In-Reply-To: <200704231823.48723.fenkes@de.ibm.com>
References: <200704231823.48723.fenkes@de.ibm.com>
Content-Type: text/plain
Message-Id: <1177347358.28021.24294.camel@hal.voltaire.com>
Mime-Version: 1.0
Date: 23 Apr 2007 12:55:59 -0400
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Joachim,

On Mon, 2007-04-23 at 12:23, Joachim Fenkes wrote:
> Add "Modify Port" verb support to eHCA driver.
> ib_cm needs this to initialize properly.
> 
> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> ---
> 
>  ehca_hca.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  hcp_if.c   |   24 ++++++++++++++++++++++++
>  hcp_if.h   |    4 ++++
>  3 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff -urp a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
> --- a/drivers/infiniband/hw/ehca/ehca_hca.c	2007-02-04 19:44:54.000000000 +0100
> +++ b/drivers/infiniband/hw/ehca/ehca_hca.c	2007-04-23 18:09:38.000000000 +0200
> @@ -147,6 +147,7 @@ int ehca_query_port(struct ib_device *ib
>  		break;
>  	}
>  
> +	props->port_cap_flags  = rblock->capability_mask;
>  	props->gid_tbl_len     = rblock->gid_tbl_len;
>  	props->max_msg_sz      = rblock->max_msg_sz;
>  	props->bad_pkey_cntr   = rblock->bad_pkey_cntr;
> @@ -233,10 +234,53 @@ query_gid1:
>  	return ret;
>  }
>  
> +const u32 allowed_port_caps = (
> +	IB_PORT_SM | IB_PORT_LED_INFO_SUP | IB_PORT_CM_SUP |
> +	IB_PORT_SNMP_TUNNEL_SUP | IB_PORT_DEVICE_MGMT_SUP |
> +	IB_PORT_VENDOR_CLASS_SUP);

I didn't think IB_PORT_SM was allowed (as QP0 is not exposed) or does
this just fail later when it is attempted to be actually set ?

-- Hal

> +
>  int ehca_modify_port(struct ib_device *ibdev,
>  		     u8 port, int port_modify_mask,
>  		     struct ib_port_modify *props)
>  {
> -	/* Not implemented yet */
> -	return -EFAULT;
> +	int ret = 0;
> +	struct ehca_shca *shca = container_of(ibdev, struct ehca_shca, ib_device);
> +	struct hipz_query_port *rblock;
> +	u32 cap;
> +	u64 hret;
> +
> +	if ((props->set_port_cap_mask | props->clr_port_cap_mask)
> +	    & ~allowed_port_caps) {
> +		ehca_err(&shca->ib_device, "Non-changeable bits set in masks  "
> +			 "set=%x  clr=%x  allowed=%x", props->set_port_cap_mask,
> +			 props->clr_port_cap_mask, allowed_port_caps);
> +		return -EINVAL;
> +	}
> +
> +	rblock = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
> +	if (!rblock) {
> +		ehca_err(&shca->ib_device,  "Can't allocate rblock memory.");
> +		return -ENOMEM;
> +	}
> +
> +	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_SUCCESS) {
> +		ehca_err(&shca->ib_device, "Can't query port properties");
> +		ret = -EINVAL;
> +		goto modify_port1;
> +	}
> +
> +	cap = (rblock->capability_mask | props->set_port_cap_mask)
> +		& ~props->clr_port_cap_mask;
> +
> +	hret = hipz_h_modify_port(shca->ipz_hca_handle, port,
> +				  cap, props->init_type, port_modify_mask);
> +	if (hret != H_SUCCESS) {
> +		ehca_err(&shca->ib_device, "Modify port failed  hret=%lx", hret);
> +		ret = -EINVAL;
> +	}
> +
> +modify_port1:
> +	ehca_free_fw_ctrlblock(rblock);
> +
> +	return ret;
>  }
> diff -urp a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
> --- a/drivers/infiniband/hw/ehca/hcp_if.c	2007-02-04 19:44:54.000000000 +0100
> +++ b/drivers/infiniband/hw/ehca/hcp_if.c	2007-04-23 18:06:09.000000000 +0200
> @@ -70,6 +70,10 @@
>  #define H_ALL_RES_QP_SQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(0, 31)
>  #define H_ALL_RES_QP_RQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(32, 63)
>  
> +#define H_MP_INIT_TYPE                  EHCA_BMASK_IBM(44, 47)
> +#define H_MP_SHUTDOWN                   EHCA_BMASK_IBM(48, 48)
> +#define H_MP_RESET_QKEY_CTR             EHCA_BMASK_IBM(49, 49)
> +
>  /* direct access qp controls */
>  #define DAQP_CTRL_ENABLE    0x01
>  #define DAQP_CTRL_SEND_COMP 0x20
> @@ -364,6 +368,26 @@ u64 hipz_h_query_port(const struct ipz_a
>  	return ret;
>  }
>  
> +u64 hipz_h_modify_port(const struct ipz_adapter_handle adapter_handle,
> +		       const u8 port_id, const u32 port_cap,
> +		       const u8 init_type, const int modify_mask)
> +{
> +	u64 port_attributes = port_cap;
> +
> +	if (modify_mask & IB_PORT_SHUTDOWN)
> +		port_attributes |= EHCA_BMASK_SET(H_MP_SHUTDOWN, 1);
> +	if (modify_mask & IB_PORT_INIT_TYPE)
> +		port_attributes |= EHCA_BMASK_SET(H_MP_INIT_TYPE, init_type);
> +	if (modify_mask & IB_PORT_RESET_QKEY_CNTR)
> +		port_attributes |= EHCA_BMASK_SET(H_MP_RESET_QKEY_CTR, 1);
> +
> +	return ehca_plpar_hcall_norets(H_MODIFY_PORT,
> +				       adapter_handle.handle, /* r4 */
> +				       port_id,               /* r5 */
> +				       port_attributes,       /* r6 */
> +				       0, 0, 0, 0);
> +}
> +
>  u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
>  		     struct hipz_query_hca *query_hca_rblock)
>  {
> diff -urp a/drivers/infiniband/hw/ehca/hcp_if.h b/drivers/infiniband/hw/ehca/hcp_if.h
> --- a/drivers/infiniband/hw/ehca/hcp_if.h	2007-02-04 19:44:54.000000000 +0100
> +++ b/drivers/infiniband/hw/ehca/hcp_if.h	2007-04-23 18:06:09.000000000 +0200
> @@ -85,6 +85,10 @@ u64 hipz_h_query_port(const struct ipz_a
>  		      const u8 port_id,
>  		      struct hipz_query_port *query_port_response_block);
>  
> +u64 hipz_h_modify_port(const struct ipz_adapter_handle adapter_handle,
> +		       const u8 port_id, const u32 port_cap,
> +		       const u8 init_type, const int modify_mask);
> +
>  u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
>  		     struct hipz_query_hca *query_hca_rblock);
>  
> 
> _______________________________________________
> general mailing list
> general@lists.openfabrics.org
> http://lists.openfabrics.org/cgi-bin/mailman/listinfo/general
> 
> To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general
