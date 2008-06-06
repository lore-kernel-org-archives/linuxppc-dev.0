Return-Path: <dotanba@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id E6E3FDE4A7
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 05:15:47 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so687479ugf.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jun 2008 12:15:46 -0700 (PDT)
Message-ID: <48499C11.7030504@gmail.com>
Date: Fri, 06 Jun 2008 22:20:33 +0200
From: Dotan Barak <dotanba@gmail.com>
MIME-Version: 1.0
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [ofa-general] IB/ehca: Reject send WRs only for RESET, INIT and
	RTR state
References: <200806061835.43802.fenkes@de.ibm.com>
In-Reply-To: <200806061835.43802.fenkes@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

I checked the code in the ehca driver and noticed that
post RR to a QP is being accepted in any state (including the RESET state).

thanks
Dotan

Joachim Fenkes wrote:
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> ---
>  drivers/infiniband/hw/ehca/ehca_reqs.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
> index bbe0436..f093b00 100644
> --- a/drivers/infiniband/hw/ehca/ehca_reqs.c
> +++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
> @@ -421,8 +421,10 @@ int ehca_post_send(struct ib_qp *qp,
>  	int ret = 0;
>  	unsigned long flags;
>  
> -	if (unlikely(my_qp->state != IB_QPS_RTS)) {
> -		ehca_err(qp->device, "QP not in RTS state  qpn=%x", qp->qp_num);
> +	/* Reject WR if QP is in RESET, INIT or RTR state */
> +	if (unlikely(my_qp->state < IB_QPS_RTS)) {
> +		ehca_err(qp->device, "Invalid QP state  qp_state=%d qpn=%x",
> +			 my_qp->state, qp->qp_num);
>  		return -EINVAL;
>  	}
>  
>   
