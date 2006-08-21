Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C1E467C46
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 00:52:44 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7LEqdYK036336
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:52:39 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7LEuc37122206
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 16:56:38 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7LEqcBA006103
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 16:52:39 +0200
Message-ID: <44E9C8B6.7030701@de.ibm.com>
Date: Mon, 21 Aug 2006 16:52:38 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
References: <200608181329.02042.ossthema@de.ibm.com>
	<20060818144429.GF5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818144429.GF5201@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexey Dobriyan wrote:
 > On Fri, Aug 18, 2006 at 01:29:01PM +0200, Jan-Bernd Themann wrote:
 >> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_main.c
 >> +++ kernel/drivers/net/ehea/ehea_main.c
 >
 >> +static inline int ehea_refill_rq3_def(struct ehea_port_res *pr, int nr_of_wqes)
 >
 > This one looks too big to be inlined as well as other similalry named
 > functions.

Agreed. Inlining avoided where possible.

 >> +static int ehea_clean_port_res(struct ehea_port *port, struct ehea_port_res *pr)
 >
 > Freeing/deallocating/cleaning functions usually return void. The fact
 > that you always return -EINVAL only reaffirmes my belief. ;-)
 >

Fixed.

 >> +static inline void write_swqe2_data(struct sk_buff *skb,
 >> +                                struct net_device *dev,
 >> +                                struct ehea_swqe *swqe,
 >> +                                u32 lkey)
 >
 > Way too big.

Function split.

 >> +static inline void ehea_xmit2(struct sk_buff *skb,
 >> +                          struct net_device *dev, struct ehea_swqe *swqe,
 >> +                          u32 lkey)
 >> +
 >> +static inline void ehea_xmit3(struct sk_buff *skb,
 >> +                          struct net_device *dev, struct ehea_swqe *swqe)
 >
 > Ditto.

These functions are on a performance-critical path and they are called
exactly once - so the object's size isn't affected and having them inline
seems appropriate to me.

 >> +    if (grp)
 >> +            memset(cb1->vlan_filter, 0, sizeof(cb1->vlan_filter));
 >> +    else
 >> +            memset(cb1->vlan_filter, 1, sizeof(cb1->vlan_filter));
 >
 > Just to be sure, this should be 1 not 0xff?
 >

Will be checked.

 >> +void ehea_clean_all_port_res(struct ehea_port *port)
 >> +{
 >> +    int ret;
 >> +    int i;
 >> +    for(i = 0; i < port->num_def_qps + port->num_tx_qps; i++)
 >> +            ehea_clean_port_res(port, &port->port_res[i]);
 >> +
 >> +    ret = ehea_destroy_eq(port->qp_eq);
 >> +}
 >
 > ret is entirely useless.

Correct. It's gone.

 >
 >> +int __init ehea_module_init(void)
 > static
 >
 >> +{
 >> +    int ret = -EINVAL;
 >> +
 >> +    printk("IBM eHEA Ethernet Device Driver (Release %s)\n", DRV_VERSION);
 >> +
 >> +    ret = ibmebus_register_driver(&ehea_driver);
 >> +    if (ret) {
 >> +            ehea_error("failed registering eHEA device driver on ebus");
 >> +            return -EINVAL;
 >> +    }
 >> +
 >> +    return 0;
 >> +}
 >
 > Pass ret to upper layer. Simplest way is:
 >
 >       static int __init ehea_module_init(void)
 >       {
 >               return ibmebus_register_driver(&ehea_driver);
 >       }

Agreed to pass ret to upper layer, but we want to keep the error message.
Code modified accordingly.


Regards
Thomas
