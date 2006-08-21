Return-Path: <osstklei@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 374F967B8E
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 20:21:25 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7LALKKf132378
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 10:21:20 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7LANGjB132618
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 11:23:16 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7LALG6M005048
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 11:21:17 +0100
Message-ID: <44E9890F.2080708@de.ibm.com>
Date: Mon, 21 Aug 2006 12:21:03 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [2.6.19 PATCH 2/7] ehea: pHYP interface
References: <200608181330.21507.ossthema@de.ibm.com>
	<20060818150600.GG5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818150600.GG5201@martell.zuzino.mipt.ru>
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
> On Fri, Aug 18, 2006 at 01:30:21PM +0200, Jan-Bernd Themann wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.c
>> +++ kernel/drivers/net/ehea/ehea_phyp.c
> 
>> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
>> +				     eq_handle, log_pageaddr, count);
>> +	return hret;
> 
> Just
> 	return ehea_h_register_rpage(...);
> 
>> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
>> +				     cq_handle, log_pageaddr, count);
>> +	return hret;
> 
> Ditto.
> 
>> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
>> +				     qp_handle, log_pageaddr, count);
>> +	return hret;
>> +}
> 
> Ditto.

Returncode handling was reworked throughout the whole driver. Those assignments
were modified according to your suggestion.

>> +static inline int hcp_epas_ctor(struct h_epas *epas, u64 paddr_kernel,
>> +				u64 paddr_user)
>> +{
>> +	epas->kernel.fw_handle = (u64) ioremap(paddr_kernel, PAGE_SIZE);
>> +	epas->user.fw_handle = paddr_user;
>> +	return 0;
>> +}
>> +
>> +static inline int hcp_epas_dtor(struct h_epas *epas)
>> +{
>> +
>> +	if (epas->kernel.fw_handle)
>> +		iounmap((void *)epas->kernel.fw_handle);
>> +	epas->user.fw_handle = epas->kernel.fw_handle = 0;
>> +	return 0;
>> +}
> 
> Always returns 0;

Correct. They're returning void now.

Thanks
Thomas
