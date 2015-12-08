Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96ABB1A0EE1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 17:31:18 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66BA7140291
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2015 17:31:18 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 8 Dec 2015 16:31:18 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 151362BB003F
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2015 17:31:16 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB86V7LS57082074
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2015 17:31:15 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB86UgaU020346
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2015 17:30:43 +1100
Subject: Re: [PATCH] cxl: sparse: add __iomem annotations in vphb.c
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1446541751.23081.1.camel@ellerman.id.au> <5639A307.7060503@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, imunsie@au1.ibm.com, dja@axtens.net
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <566678FA.5030400@au1.ibm.com>
Date: Tue, 8 Dec 2015 17:30:18 +1100
MIME-Version: 1.0
In-Reply-To: <5639A307.7060503@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Finally looking at this patch again for the first time in a couple of 
months...

On 04/11/15 17:17, Andrew Donnellan wrote:
> On 03/11/15 20:09, Michael Ellerman wrote:
>> Part of your problem is you're storing afu->crs_len which is not
>> __iomem in
>> cfg_data which is, and so that's leading to some of your casts.
>>
>> I don't really see why you're using cfg_data like that, you have the
>> afu in
>> phb->private_data. But maybe cfg_data needs to hold that value for
>> some other
>> code I'm not seeing.
>
> I can't see any obvious reason why we need to use cfg_data either.

Ian/Mikey - do you happen to know why we're using cfg_data? I've taken 
another look and I can't see anything obvious.

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
