Return-Path: <ahuja@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D916DDFA9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 05:54:20 +1100 (EST)
Received: from e5.ny.us.ibm.com ([192.168.1.105])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1CGoU3l031796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:50:30 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1CGf18C026529
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:41:01 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1CGf1tC243360
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:41:01 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1CGf0KE017883
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:41:01 -0500
Message-ID: <47B1CC1B.80905@austin.ibm.com>
Date: Tue, 12 Feb 2008 10:40:59 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
References: <4782B985.2090508@austin.ibm.com>	<47B13D2E.1070001@austin.ibm.com>	<47B146BE.5010807@austin.ibm.com>
	<20080212210818.7b9099a4.sfr@canb.auug.org.au>
In-Reply-To: <20080212210818.7b9099a4.sfr@canb.auug.org.au>
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

As noted, its fixed in patch 4. 

If its okay for this time, I will prefer to leave it there.

-Manish


Stephen Rothwell wrote:
> Hi Manish,
> 
> Just a small comment.
> 
> On Tue, 12 Feb 2008 01:11:58 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrote:
>> +	/* Is there dump data waiting for us? */
>> +	rtas = of_find_node_by_path("/rtas");
>> +	dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);
> 
> You need an of_node_put(rtas) here.
> 
>> +	if (dump_header == NULL) {
>> +		release_all();
>> +		return 0;
>> +	}
> 
