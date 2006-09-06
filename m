Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0236C67B77
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 23:36:09 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.7/8.13.7) with ESMTP id k86Da2xf054248
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 13:36:02 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k86DeRiY2908224
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 15:40:27 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k86Da1gf002695
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2006 15:36:02 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Date: Wed, 6 Sep 2006 14:53:38 +0200
References: <200609041237.46528.ossthema@de.ibm.com>
	<44FD931A.3080107@de.ibm.com>
	<20060905185832.GA15311@electric-eye.fr.zoreil.com>
In-Reply-To: <20060905185832.GA15311@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609061453.38619.ossthema@de.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
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

Hi,

ok, I admit this solution looks a bit nicer. We changed it in a similar way.

Jan-Bernd

On Tuesday 05 September 2006 20:58, Francois Romieu wrote:
> Thomas Klein <osstklei@de.ibm.com> :
> [...]
> > Somehow I don't get your point concerning the usage of 'k'. We need another
> > iterator as the for loops using 'k' use 'i' as their terminating condition.
> 
> Something like the code below perhaps (with more local variables maybe):
> 
> static int ehea_reg_interrupts(struct net_device *dev)
> {
> 	struct ehea_port *port = netdev_priv(dev);
> 	struct ehea_port_res *pr;
> 	int i, ret;
> 
> 	for (i = 0; i < port->num_def_qps; i++) {
> 		pr = &port->port_res[i];
> 		snprintf(pr->int_recv_name, EHEA_IRQ_NAME_SIZE - 1
> 			 , "%s-recv%d", dev->name, i);
> 		ret = ibmebus_request_irq(NULL, pr->recv_eq->attr.ist1,
> 					  ehea_recv_irq_handler, SA_INTERRUPT,
> 					  pr->int_recv_name, pr);
> 		if (ret) {
> 			ehea_error("failed registering irq for ehea_recv_int:"
> 				   "port_res_nr:%d, ist=%X", i,
> 				   pr->recv_eq->attr.ist1);
> 			goto err_free_irq_recv_eq_0;
> 		}
> 		if (netif_msg_ifup(port))
> 			ehea_info("irq_handle 0x%X for funct ehea_recv_int %d "
> 				  "registered", pr->recv_eq->attr.ist1, i);
> 	}
> 
> 	snprintf(port->int_aff_name, EHEA_IRQ_NAME_SIZE - 1,
> 		 "%s-aff", dev->name);
> 	ret = ibmebus_request_irq(NULL, port->qp_eq->attr.ist1,
> 				  ehea_qp_aff_irq_handler,
> 				  SA_INTERRUPT, port->int_aff_name, port);
> 	if (ret) {
> 		ehea_error("failed registering irq for qp_aff_irq_handler:"
> 			   " ist=%X", port->qp_eq->attr.ist1);
> 		goto err_free_irq_recv_eq_0;
> 	}
> 	if (netif_msg_ifup(port))
> 		ehea_info("irq_handle 0x%X for function qp_aff_irq_handler "
> 			  "registered", port->qp_eq->attr.ist1);
> 
> 	for (i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++) {
> 		pr = &port->port_res[i];
> 		snprintf(pr->int_send_name, EHEA_IRQ_NAME_SIZE - 1,
> 			 "%s-send%d", dev->name, i);
> 		ret = ibmebus_request_irq(NULL, pr->send_eq->attr.ist1,
> 					  ehea_send_irq_handler, SA_INTERRUPT,
> 					  pr->int_send_name, pr);
> 		if (ret) {
> 			ehea_error("failed registering irq for ehea_send"
> 				   " port_res_nr:%d, ist=%X", i,
> 				   pr->send_eq->attr.ist1);
> 			goto err_free_irq_send_eq_1;
> 		}
> 		if (netif_msg_ifup(port))
> 			ehea_info("irq_handle 0x%X for function ehea_send_int "
> 				  "%d registered", pr->send_eq->attr.ist1, i);
> 	}
> out:
> 	return ret;
> 
> err_free_irq_send_eq_1:
> 	// Post-dec works with unsigned int too.
> 	while (i-- > 0) {
> 		u32 ist = port->port_res[i].send_eq->attr.ist1;
> 		ibmebus_free_irq(NULL, ist, &port->port_res[i]);
> 	}
> 	ibmebus_free_irq(NULL, port->qp_eq->attr.ist1, port);
> 	i = port->num_def_qps;
> err_free_irq_recv_eq_0:
> 	while (i-- > 0) {
> 		u32 ist = port->port_res[i].recv_eq->attr.ist1;
> 		ibmebus_free_irq(NULL, ist, &port->port_res[k]);
> 	}
> 	goto out;
> }
> 
