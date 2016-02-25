Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4218A1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 00:11:35 +1100 (AEDT)
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 13:11:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2160417D8066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 13:11:49 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1PDBQvI47710250
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 13:11:27 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1PDBQJm012837
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 08:11:26 -0500
Subject: Re: [PATCH v5 14/18] cxl: Support to flash a new image on the adapter
 from a guest
To: manoj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-15-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CE0C7E.7090001@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56CEFD7D.6010005@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2016 14:11:25 +0100
MIME-Version: 1.0
In-Reply-To: <56CE0C7E.7090001@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/02/2016 21:03, Manoj Kumar a écrit :

>> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
>>
>> +#define CXL_DEV_MINORS 13   /* 1 control + 4 AFUs * 3
>> (dedicated/master/shared) */
>
> Where does this limit of 4 AFUs come from?
> Is this related to CXL_MAX_SLICES?
> Should this be a computed value, in case the number of AFUs/slices
> is increased at a future date?

The architecture document (CAIA) limits the number of AFUs to 4, though 
I don't think anybody as tried with more than 1 so far.
So yes, we could have reused CXL_MAX_SLICES. Since we were just moving 
the definition from another file and this is not likely to vary until a 
major revision of the architecture, I don't intend to address it in this 
patchset, but I've added it to my list of ideas for future cleanup (you 
had already mentioned something about hard-coded constants in the 
previous series).


> memset(0) after kzalloc() is redundant.

yep! Will fix.

   Fred
