Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPjxs6H5JzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 05:36:33 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 15 Mar 2016 18:36:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id CB7351B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 18:36:55 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2FIaQVp53477592
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 18:36:27 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2FIaQWd008007
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 12:36:26 -0600
Subject: Re: [PATCH next] cxl: Allow PSL timebase to not sync
To: Michael Neuling <mikey@neuling.org>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
References: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1458001649.12098.59.camel@neuling.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56E8562A.6010502@linux.vnet.ibm.com>
Date: Tue, 15 Mar 2016 19:36:26 +0100
MIME-Version: 1.0
In-Reply-To: <1458001649.12098.59.camel@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey,

Le 15/03/2016 01:27, Michael Neuling a écrit :
> I'm not happy with doing this unless we add something which advertises
> that it's synced or not to userspace.
>
> If we do that, I'm happy to just fail without the need of the parameter
> but advertise it to userspace.

OK, so I'm guessing that by advertising, you mean more than logging 
something in dmesg, since that's already the case.
Are you suggesting to make the sync status available programmatically 
(like through a status on /sys)? Seems like it would be pushing some 
work on applications which want to use the psl timebase in the future, 
just because there's currently a problem with some card models.
So I doubt I'm understanding you correctly here.

My vote was to keep it simple: it's all or nothing. If the driver claims 
to support psl timebase sync, it should work on all the cards. This is 
not the case today, so let's not make it a requirement until we are 
confident it's working as expected. cxlflash is not using it, so there 
should be no harm done. We'd keep the psl sync code in mostly to get 
exposure on multiple setups.


> The parameter is a bit of a PITA too, as it's a driver level config not
> card level.  You really want to turn it on/off based on the card, not
> the whole system.

I don't really care about the module parameter. It was mostly a feeble 
attempt to be developer-friendly and activate the feature easily on some 
setup.

   Fred
