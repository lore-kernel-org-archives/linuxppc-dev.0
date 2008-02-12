Return-Path: <ahuja@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50EA3DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 04:57:10 +1100 (EST)
Received: from e5.ny.us.ibm.com ([192.168.1.105])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1CGbDOb022058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:37:13 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1CGW9tE014369
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:32:09 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1CGW7Cq233098
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:32:07 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1CGW6Oc003788
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:32:06 -0500
Message-ID: <47B1C9FF.9020509@austin.ibm.com>
Date: Tue, 12 Feb 2008 10:31:59 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/8] pseries: phyp dump: register dump area.
References: <4782B985.2090508@austin.ibm.com>	<47B13D2E.1070001@austin.ibm.com>	<47B14760.2030001@austin.ibm.com>
	<20080212211154.f641abac.sfr@canb.auug.org.au>
In-Reply-To: <20080212211154.f641abac.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For now, if we can leave this patch as is, that will be great. That move requires me 
to work all remaining patches as they apply uncleanly after that.

I will bunch those two together functionally next time onwards.

Thanks,
Manish


Stephen Rothwell wrote:
> Hi Manish,
> 
>> -	/* Is there dump data waiting for us? */
>> +	/* Is there dump data waiting for us? If there isn't,
>> +	 * then register a new dump area, and release all of
>> +	 * the rest of the reserved ram.
>> +	 *
>> +	 * The /rtas/ibm,kernel-dump rtas node is present only
>> +	 * if there is dump data waiting for us.
>> +	 */
>>  	rtas = of_find_node_by_path("/rtas");
>>  	dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);
>> +	of_node_put(rtas);
> 
> Oh, here is the of_node_put() - you should move that to patch 3.
> 
