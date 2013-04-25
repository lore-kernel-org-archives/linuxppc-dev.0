Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A189A2C010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 15:37:20 +1000 (EST)
Message-ID: <5178C0DE.9070503@asianux.com>
Date: Thu, 25 Apr 2013 13:36:30 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: "attempt to move .org backwards" still show up
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
In-Reply-To: <5178ABA2.4030109@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013年04月25日 12:05, Mike Qiu wrote:
>> I will try, and plan to get a result within this week (2013-04-28)
>>
>> Thanks.
> Hi
> This has block my work now
> So I hope you can take a look ASAP
> Thanks
> :)

The root cause is the room 0x500..0xc00 is not enough when
KVM_HANDLER_PR expresses the real codes. The relationship is
KVM_HANDLER_PR depend on CONFIG_KVM_BOOK3S_PR depend on
CONFIG_KVM_BOOK3S_64_PR.

If possible, we can by pass it: just use CONFIG_KVM_BOOK3S_64_HV instead
of CONFIG_KVM_BOOK3S_64_PR (enter menuconfig -> Virtualization -> "KVM
support for POWER7 and PPC970 using hypervisor mode in host").

For 'allmodconfig', it will use CONFIG_KVM_BOOK3S_64_HV instead of
CONFIG_KVM_BOOK3S_64_PR, so 'allmodconfig' will not have this issue.


Next, I will continue to analyse how to fix it.

Welcome other members (especially the related maintainers) to provide
suggestions and completions.

Thanks.

-- 
Chen Gang

Asianux Corporation
