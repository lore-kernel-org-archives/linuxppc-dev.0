Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 642DF67B5C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 21:40:42 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7BBeb9p082186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 11:40:38 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7BBgRLS129572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 12:42:27 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7BBeaA0026186
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 12:40:37 +0100
Message-ID: <44DC63B4.9070405@de.ibm.com>
Date: Fri, 11 Aug 2006 13:02:12 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: Christian Borntraeger <borntrae@de.ibm.com>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
References: <44D99EFC.3000105@de.ibm.com>
	<200608091108.51774.borntrae@de.ibm.com>
In-Reply-To: <200608091108.51774.borntrae@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Christian,

thanks for your comments, we'll send an updated patch set soon.

Jan-Bernd

Christian Borntraeger wrote:
> Hi Jan-Bernd,
> 
> I had some minutes, here are some finding after a quick look.
> 
> On Wednesday 09 August 2006 10:38, you wrote:
>> +static struct net_device_stats *ehea_get_stats(struct net_device *dev)
>> +{
>> +	int i;
>> +	u64 hret = H_HARDWARE;
>> +	u64 rx_packets = 0;
>> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
> 
> dev->priv is a void pointer, this cast is unnecessary. When we are at it, have 
> you considered the netdev_priv macro? This will require some prep in 
> alloc_netdev and might not always pe possible. 

good point, we'll use alloc_etherdev / netdev_priv

>> +
>> +	EDEB_DMP(7, (u8*)cb2,
>> +		 sizeof(struct hcp_query_ehea_port_cb_2), "After HCALL");
>> +
>> +	for (i = 0; i < port->num_def_qps; i++) {
>> +		rx_packets += port->port_res[i].rx_packets;
>> +	}
>> +
>> +	stats->tx_packets = cb2->txucp + cb2->txmcp + cb2->txbcp;
>> +	stats->multicast = cb2->rxmcp;
>> +	stats->rx_errors = cb2->rxuerr;
>> +	stats->rx_bytes = cb2->rxo;
>> +	stats->tx_bytes = cb2->txo;
>> +	stats->rx_packets = rx_packets;
>> +
>> +get_stat_exit:
>> +	EDEB_EX(7, "");
>> +	return stats;
>> +}
> 
> again, cb2 is not freed.
> [...]

yep, done

> 
>> +static inline u64 get_swqe_addr(u64 tmp_addr, int addr_seg)
>> +{
>> +	u64 addr;
>> +	addr = tmp_addr;
>> +	return addr;
>> +}
> 
> This is suppsed to change in the future? If not you can get rid of it. 
> 
>> +
>> +static inline u64 get_rwqe_addr(u64 tmp_addr)
>> +{
>> +	return tmp_addr;
>> +}
> 
> same here. 

removed


>> + ehea_poll()
> 
> The poll function seems too long and therefore hard to review. Please consider 
> splitting it. 
> 
> 

done
