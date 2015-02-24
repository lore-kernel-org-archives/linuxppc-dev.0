Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 812DC1A0FB0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 03:37:55 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 51CBB140119
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 03:37:54 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Tue, 24 Feb 2015 09:37:52 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8A7863E4005E
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2015 09:37:49 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1OGbnNe35324006
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2015 09:37:49 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1OGbnjK005891
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2015 09:37:49 -0700
Message-ID: <54ECA8DB.9000707@linux.vnet.ibm.com>
Date: Tue, 24 Feb 2015 10:37:47 -0600
From: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Export __spin_yield
References: <1424477465-9199-2-git-send-email-warrier@linux.vnet.ibm.com>
 <54EBC165.3020708@linux.vnet.ibm.com>
 <1424749119.12891.20.camel@kernel.crashing.org>
In-Reply-To: <1424749119.12891.20.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/23/2015 09:38 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2015-02-23 at 18:10 -0600, Suresh E. Warrier wrote:
>> Export __spin_yield so that the arch_spin_unlock() function
>> can be invoked from a module.
> 
> Make it EXPORT_SYMBOL_GPL. Also explain why a module might need it
> 

Sure, I will change that to EXPORT_SYMBOL_GPL. Just curious, though, 
there is another symbol arch_spin_unlock_wait that is exported from
the file without the _GPL prefix. Any idea why?

I have mentioned that this needs to be exported to call the 
arch_spin_unlock() function from a module. What additional information
do you think will be useful here ? Are you looking at something
that explains why a module might need to call arch_spin_unlock()?

Thanks.
-suresh
