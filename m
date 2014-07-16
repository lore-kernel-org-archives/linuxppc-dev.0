Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4541C1A0910
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:27:08 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 17:57:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 65B9E3940063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 17:57:03 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6GCRKKV59703326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 17:57:20 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6GCR0XD031010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 17:57:01 +0530
Date: Wed, 16 Jul 2014 22:26:53 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 3/6] powerpc/eeh: Reduce lines of log dump
Message-ID: <20140716122653.GB5313@shangw>
References: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1405489819-26211-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D17274752@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17274752@AcuExch.aculab.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 'Gavin Shan' <gwshan@linux.vnet.ibm.com>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2014 at 08:30:55AM +0000, David Laight wrote:
>From: Gavin Shan
>> The patch prints 4 PCIE or AER config registers each line, which
>> is part of the EEH log so that it looks a bit more compact.
>...
>> -		for (i=0; i<=8; i++) {
>> +		for (i=0, j=0; i<=8; i++) {
>>  			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
>>  			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
>> -			pr_warn("EEH: PCI-E %02x: %08x\n", i, cfg);
>> +
>> +			if ((i % 4) == 0) {
>> +				memset(buffer, 0, sizeof(buffer));

>
>You don't need a memset().
>I would add:
>				if (i != 0)
>					pr_warn("%s\n", buffer);
>and move the other pr_warn() outside the loop.
>

Thanks, It looks better. I'll fix.

>> +				j = scnprintf(buffer, sizeof(buffer),
>> +					      "EEH: PCI-E %02x: %08x ",
>> +					      4*i, cfg);
>> +			} else {
>> +				j += scnprintf(buffer+j, sizeof(buffer)-j,
>> +					       "%08x ", cfg);
>> +			}
>> +
>> +			if ((i % 4) == 3 || i >= 8)
>> +				pr_warn("%s\n", buffer);
>>  		}
>>  	}
>
>	David
>

Thanks,
Gavin
