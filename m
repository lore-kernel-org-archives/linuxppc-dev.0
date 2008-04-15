Return-Path: <ahuja@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A059ADE471
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:56:24 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3FMuGcS022912
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 18:56:16 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3FMuGmS387716
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 18:56:16 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3FMuGsX021037
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 18:56:16 -0400
Message-ID: <4805328E.2050709@austin.ibm.com>
Date: Tue, 15 Apr 2008 17:56:14 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
References: <47FAB221.7050406@austin.ibm.com>	<47FFF4E8.9010705@austin.ibm.com>
	<18436.18955.450131.623072@cargo.ozlabs.ibm.com>
In-Reply-To: <18436.18955.450131.623072@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

The aim is to have more flex space for the kernel on machines with more resources. Although the dump will be collected pretty fast and the memory released really early on allowing the machine to have the full memory available, this alleviates any issues that can be caused by having way too little memory on very very large systems during those few minutes.

-Manish



Paul Mackerras wrote:
> Manish Ahuja writes:
> 
>> B. It computers 5% of total ram and rounds it down to multiples of 256MB.
>> C. Compares the rounded down value and returns larger of 256MB or the new
>>    computed value.
> 
> So if we have 10GB of memory or more we'll use reserve more than
> 256MB.  What is the advantage of reserving more than 256MB of memory?
> 
> Paul.
