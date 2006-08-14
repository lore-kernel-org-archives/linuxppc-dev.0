Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D503C67BE1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 02:22:20 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7EGMG4a083470
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 16:22:16 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7EGO7jR129630
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 17:24:07 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7EGMG6g008632
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 17:22:16 +0100
Message-ID: <44E09A19.9050205@de.ibm.com>
Date: Mon, 14 Aug 2006 17:43:21 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
References: <44D99EFC.3000105@de.ibm.com> <20060811205624.GE479@krispykreme>
	<20060814112656.GC10164@wohnheim.fh-wedel.de>
	<20060814143842.GM479@krispykreme>
In-Reply-To: <20060814143842.GM479@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>,
	=?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Anton Blanchard wrote:
>> Is a conditional cheaper than a divide?  In case of a misprediction I
>> would assume it to be significantly slower and I don't know the ratio
>> of mispredictions for this branch.
> 
> A quick scan of the web shows 40 cycles for athlon64 idiv, and its
> similarly slow on many other cpus. Even assuming you mispredict every
> branch its going to be a win.
> 
> Anton

as our queue size is always a power of 2, we simply use:
i++;
i &= (ringbufferlength - 1)

So we can get along without the if.

Jan-Bernd
