Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57E7567B8E
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 20:53:34 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7LArU1V022690
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 10:53:30 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7LAtPPX125414
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 11:55:25 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7LArRZO022251
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 11:53:29 +0100
Message-ID: <44E990A6.90806@de.ibm.com>
Date: Mon, 21 Aug 2006 12:53:26 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
References: <200608181333.23031.ossthema@de.ibm.com>
	<20060818140506.GC5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818140506.GC5201@martell.zuzino.mipt.ru>
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
 > On Fri, Aug 18, 2006 at 01:33:22PM +0200, Jan-Bernd Themann wrote:
 >> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c
 >> +++ kernel/drivers/net/ehea/ehea_ethtool.c
 >> +{
 >> +    strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
 >> +    strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
 >
 > Use strlcpy() to not forget -1 accidently.

Done.

 >
 >> +static u32 netdev_get_msglevel(struct net_device *dev)
 >                        ^^^^^^^^
 >> +{
 >> +    struct ehea_port *port = netdev_priv(dev);
 >> +    return port->msg_enable;
 >                        ^^^^^^
 >
 > Something is mis-named here.

The kernel requires a structure member of that name.

 >> +struct ethtool_ops ehea_ethtool_ops = {
 >> +    .get_settings = netdev_get_settings,
 >> +    .get_drvinfo = netdev_get_drvinfo,
 >> +    .get_msglevel = netdev_get_msglevel,
 >> +    .set_msglevel = netdev_set_msglevel,
 >> +        .get_link = ethtool_op_get_link,
 >> +        .get_tx_csum = ethtool_op_get_tx_csum,
 >
 > Whitespace breakage.

Fixed.

 >> +    .set_settings = NULL,
 >> +    .nway_reset = NULL,
 >> +    .get_pauseparam = NULL,
 >> +    .set_pauseparam = NULL,
 >> +    .get_rx_csum = NULL,
 >> +    .set_rx_csum = NULL,
 >> +    .phys_id = NULL,
 >> +    .self_test = NULL,
 >> +    .self_test_count = NULL
 >
 > If you don't use them, don't mention them at all. Compiler will DTRT.

Agreed. Assignments removed.

Thanks again :-)
Thomas
