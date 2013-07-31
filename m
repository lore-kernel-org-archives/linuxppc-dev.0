Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A50582C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 14:02:24 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 13:55:14 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2CC5D2BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 14:01:58 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V3kQvU33357984
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 13:46:26 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6V41u2G025838
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 14:01:57 +1000
Message-ID: <51F88BA7.7090404@linux.vnet.ibm.com>
Date: Wed, 31 Jul 2013 09:29:35 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH V2 4/6] cpuidle/pseries: Move the pseries_idle backend
 driver to sysdev.
References: <20130731025840.19448.24468.stgit@deepthi>
 <20130731025924.19448.46538.stgit@deepthi>
 <ABB05CD9C9F68C46A5CEDC7F15439259FF2953@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FF2953@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "rjw@sisk.pl" <rjw@sisk.pl>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "srivatsa.bhat@linux.vnet.ibm.com" <srivatsa.bhat@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dongsheng,

On 07/31/2013 08:52 AM, Wang Dongsheng-B40534 wrote:
> 
> 
>> -----Original Message-----
>> From: Deepthi Dharwar [mailto:deepthi@linux.vnet.ibm.com]
>> Sent: Wednesday, July 31, 2013 10:59 AM
>> To: benh@kernel.crashing.org; daniel.lezcano@linaro.org; linux-
>> kernel@vger.kernel.org; michael@ellerman.id.au;
>> srivatsa.bhat@linux.vnet.ibm.com; preeti@linux.vnet.ibm.com;
>> svaidy@linux.vnet.ibm.com; linuxppc-dev@lists.ozlabs.org
>> Cc: rjw@sisk.pl; Wang Dongsheng-B40534; linux-pm@vger.kernel.org
>> Subject: [PATCH V2 4/6] cpuidle/pseries: Move the pseries_idle backend
>> driver to sysdev.
>>
>> Move pseries_idle backend driver code to arch/powerpc/sysdev
>> so that the code can be used for a common driver for powernv
>> and pseries. This removes a lot of code duplicacy.
>>
> Why not drivers/cpuidle/?
> 
> I think it should be move to drivers/cpuidle.

Please take a look at what the cpuidle under drivers has to provide.
cpuidle has two parts to it. The front end and the back end. The front
end constitutes the cpuidle governors, registering of arch specific
cpuidle drivers, disabling and enabling of cpuidle feature. It is this
front end code which is present under drivers/cpuidle.

The arch specific cpuidle drivers which decide what needs to be done to
enter a specific idle state chosen by the cpuidle governor is what
constitutes the back end of cpuidle. This will not be in drivers/cpuidle
but in an arch/ specific code.

The cpuidle under drivers/cpuidle drives the idle power management, but
the low level handling of the entry into idle states should be taken
care of by the architecture.

Your recent patch :
cpuidle: add freescale e500 family porcessors idle support IMO should
hook onto the backend cpuidle driver that this patchset provides.

Regards
Preeti U Murthy
