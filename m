Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7000DE055
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 05:08:58 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3IJ8rrY028999
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 15:08:53 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3IJ8rpD252868
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 15:08:53 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3IJ8rkE019703
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 15:08:53 -0400
Message-ID: <4808F1C3.3030703@austin.ibm.com>
Date: Fri, 18 Apr 2008 14:08:51 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linasvepstas@gmail.com
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
References: <47FAB221.7050406@austin.ibm.com>
	<3ae3aa420804161322i10e5efe2v2f74e1f9d6698e90@mail.gmail.com>
In-Reply-To: <3ae3aa420804161322i10e5efe2v2f74e1f9d6698e90@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yeah, that makes sense, I will shortly send a documentation patch for all the boot vars
that I have added.

Thanks for reminding.

-Manish




Linas Vepstas wrote:
> On 07/04/2008, Manish Ahuja <ahuja@austin.ibm.com> wrote:
>> A small proposed change in the amount of reserve space we allocate during boot.
>>  Currently we reserve 256MB only.
>>  The proposed change does one of the 3 things.
>>
>>  A. It checks to see if there is cmdline variable set and if found sets the
>>    value to it. OR
>>  B. It computes 5% of total ram and rounds it down to multiples of 256MB. AND
>>  C. Compares the rounded down value and returns larger of two values, the new
>>    computed value or 256MB.
>>
>>  Again this is for large systems who have excess memory.
>>
> [...]
>>   early_param("phyp_dump", early_phyp_dump_enabled);
> 
> I'm pretty sure you will want to document this boot param in the documentation,
> as well as add a few words about why it might be interesting to users (i.e.
> that its for large systems...)
> 
> --linas
