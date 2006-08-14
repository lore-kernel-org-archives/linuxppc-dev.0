Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFF4667B32
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 23:32:58 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7EDWrLQ174974
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 13:32:53 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7EDYjNt094462
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 14:34:45 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7EDWqHQ029494
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 14:32:53 +0100
Message-ID: <44E07267.7070007@de.ibm.com>
Date: Mon, 14 Aug 2006 14:53:59 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 4/6] ehea: header files
References: <44D99F56.7010201@de.ibm.com>
	<1155190921.9801.43.camel@localhost.localdomain>
In-Reply-To: <1155190921.9801.43.camel@localhost.localdomain>
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

Michael Ellerman wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 16:00:00.000000000 -0800
>> +++ kernel/drivers/net/ehea/ehea.h	2006-08-08 23:59:39.927452928 -0700
>> +
>> +#define EHEA_PAGESHIFT  12
>> +#define EHEA_PAGESIZE   4096UL
>> +#define EHEA_CACHE_LINE 128
> 
> This looks like a very bad idea, what happens if you're running on a
> machine with 64K pages?
> 

The EHEA_PAGESIZE define is needed for queue management to hardware side.

>> +
>> +#define EHEA_ENABLE	1
>> +#define EHEA_DISABLE	0
> 
> Do you really need hash defines for 0 and 1 ? They're fairly well
> understood in C as meaning true and false.
> 

removed

>> +
>> +/*
>> + *  h_galpa:
>> + *  for pSeries this is a 64bit memory address where
>> + *  I/O memory is mapped into CPU address space
>> + */
>> +
>> +struct h_galpa {
>> +	u64 fw_handle;
>> +};
> 
> What is a h_galpa? And why does it need a struct if it's just a u64?
> 

The eHEA chip is not PCI attached but directly connected to a proprietary
bus. Currently, we can access it by a simple 64 bit address, but this is not
true in all cases. Having a struct here allows us to encapsulate the chip
register access and to respond to changes to system hardware.

We'll change the name to h_epa meaning "ehea physical address"

>> +
>> +struct h_galpas {
>> +	struct h_galpa kernel;	/* kernel space accessible resource,
>> +				   set to 0 if unused */
>> +	struct h_galpa user;	/* user space accessible resource
>> +				   set to 0 if unused */
>> +	u32 pid;		/* PID of userspace galpa checking */
>> +};
>> +

>> +struct port_res_cfg {
>> +	int max_entries_rcq;
>> +	int max_entries_scq;
>> +	int max_entries_sq;
>> +	int max_entries_rq1;
>> +	int max_entries_rq2;
>> +	int max_entries_rq3;
>> +};
> 
> Enormous structs with no comments.
> 

changed

Regards,
Jan-Bernd
