Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67F4B67B96
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 23:03:56 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7LD3pCd118716
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 13:03:51 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7LD5kt7131986
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:05:46 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7LD3o2G010308
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:03:51 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Date: Mon, 21 Aug 2006 14:23:53 +0200
References: <200608181329.02042.ossthema@de.ibm.com>
	<20060818144429.GF5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818144429.GF5201@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608211423.54250.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

On Friday 18 August 2006 16:44, Alexey Dobriyan wrote:
> > +static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
> > +			      struct port_res_cfg *pr_cfg, int queue_token)
> > +{
> > +	int ret = -EINVAL;
> > +	int max_rq_entries = 0;
> > +	enum ehea_eq_type eq_type = EHEA_EQ;
> > +	struct ehea_qp_init_attr *init_attr = NULL;
> > +	struct ehea_adapter *adapter = port->adapter;
> > +
> > +	memset(pr, 0, sizeof(struct ehea_port_res));
> > +
> > +	pr->skb_arr_rq3 = NULL;
> > +	pr->skb_arr_rq2 = NULL;
> > +	pr->skb_arr_rq1 = NULL;
> > +	pr->skb_arr_sq = NULL;
> > +	pr->qp = NULL;
> > +	pr->send_cq = NULL;
> > +	pr->recv_cq = NULL;
> > +	pr->send_eq = NULL;
> > +	pr->recv_eq = NULL;
> 
> After memset unneeded. ;-)
> 

Is it valid (common in the kernel environment) to treat NULL as 0 after a memset
and thus to forget about initialization?

Thanks,
Jan-Bernd
