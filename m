Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A784E1007D1
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2011 18:16:24 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 29 Nov 2011 12:46:18 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAT7G1tc4915336
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2011 12:46:01 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAT7G1MB013310
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2011 18:16:01 +1100
Message-ID: <4ED486AF.5020707@linux.vnet.ibm.com>
Date: Tue, 29 Nov 2011 12:45:59 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/4] cpuidle: (powerpc) Add cpu_idle_wait() to
 allow switching of idle routines
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>	<20111117112830.9191.1951.stgit@localhost6.localdomain6>	<1322434096.23348.6.camel@pasglop>	<4ED36A37.3030409@linux.vnet.ibm.com>	<1322512522.23348.43.camel@pasglop>	<4ED47EC2.2090802@linux.vnet.ibm.com>
 <1322550115.23348.72.camel@pasglop>
In-Reply-To: <1322550115.23348.72.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/29/2011 12:31 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2011-11-29 at 12:12 +0530, Deepthi Dharwar wrote:
>>
>> Yes, this could be problematic as there is small window for the
>> race condition to occur . Otherwise we need to manually schedule
>> it by running a kernel thread but this would definitely have a
>> overhead and would be an overkill. 
> 
> Depends what this "window" is. IE. What are you trying to protect
> yourself against ? What's the risk ?
> 
> If it's just module unload, then stop_machine is probably your
> friend :-)
> 
> Cheers,
> Ben.
> 
> 


Yup, it is the module unload that I am worried about. Otherwise
manually doing it using kernel thread would be an overkill -:(

Regards,
Deepthi
