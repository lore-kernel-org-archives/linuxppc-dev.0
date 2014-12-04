Return-Path: <dborkman@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E7921A0BFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 04:03:10 +1100 (AEDT)
Message-ID: <548093C2.9070909@redhat.com>
Date: Thu, 04 Dec 2014 18:02:58 +0100
From: Daniel Borkmann <dborkman@redhat.com>
MIME-Version: 1.0
To: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: ppc64 and Documentation/mic/mpssd/mpssd.c issues
References: <54806490.6080303@redhat.com>
 <45C67EF7794AF747A87A45C9E1CC1B97926A6AFD@ORSMSX105.amr.corp.intel.com>
 <1417712272.88385.4.camel@localhost>
In-Reply-To: <1417712272.88385.4.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Yokoyama,
 Caz" <caz.yokoyama@intel.com>, Peter Foley <pefoley2@pefoley.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/04/2014 05:57 PM, Sudeep Dutt wrote:
> On Thu, 2014-12-04 at 08:48 -0800, Yokoyama, Caz wrote:
>> Thank you for the report.
>> Have you tried to compile on x86_64? Which rhel do you use? Rhel6.X?
>> MIC card is expected to work with x86_64 host, not with ppc64. We have never compiled on ppc host while our primary development platform was rhel6.X.

Yep, I was using RHEL6 on ppc64 by chance to build an upstream kernel.

You might want to fix the Kconfig entry then to limit this to x86_64 only. ;)

Thanks,
Daniel

> I am adding Peter Foley since he enabled the mpssd build by default
> recently with commit adb19fb. Peter, is there a way to enable the mpssd
> build only for x86_64?
>
> Thanks,
> Sudeep Dutt
>
>> Line 92 is the first use of htole16 and MIC_VRING_ENTRIES. Is there any change on them?
>>
>> Thank you.
>> -caz, Caz.Yokoyama@intel.com, yokoyama@member.fsf.org
>>
>>
>> -----Original Message-----
>> From: Daniel Borkmann [mailto:dborkman@redhat.com]
>> Sent: Thursday, December 04, 2014 5:42 AM
>> To: Yokoyama, Caz
>> Cc: benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
>> Subject: ppc64 and Documentation/mic/mpssd/mpssd.c issues
>>
>> Hi Caz,
>>
>> I think commit ...
>>
>> commit 8d49751580db804a02caf6a5b7cebe2ff26c0d7e
>> Author: Caz Yokoyama <Caz.Yokoyama@intel.com>
>> Date:   Thu Sep 5 16:42:39 2013 -0700
>>
>>       Sample Implementation of Intel MIC User Space Daemon.
>>
>> ... actually triggers a build error on my default config
>> ppc64 (I'm using net-next tree):
>>
>>     HOSTCC  Documentation/mic/mpssd/mpssd.o
>> Documentation/mic/mpssd/mpssd.c:93: error: braced-group within expression allowed only inside a function
>> Documentation/mic/mpssd/mpssd.c:96: error: braced-group within expression allowed only inside a function
>> Documentation/mic/mpssd/mpssd.c:113: error: braced-group within expression allowed only inside a function
>> Documentation/mic/mpssd/mpssd.c:116: error: braced-group within expression allowed only inside a function
>> Documentation/mic/mpssd/mpssd.c:119: error: braced-group within expression allowed only inside a function
>> Documentation/mic/mpssd/mpssd.c:146: error: braced-group within expression allowed only inside a function
>> Documentation/mic/mpssd/mpssd.c:149: error: braced-group within expression allowed only inside a function
>> Documentation/mic/mpssd/mpssd.c:151: error: braced-group within expression allowed only inside a function
>> Documentation/mic/mpssd/mpssd.c:152: error: braced-group within expression allowed only inside a function
>> make[3]: *** [Documentation/mic/mpssd/mpssd.o] Error 1
>> make[2]: *** [Documentation/mic/mpssd] Error 2
>> make[1]: *** [Documentation/mic] Error 2
>> make: *** [vmlinux] Error 2
>>
>> gcc --version
>> gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-11)
>>
>> Cheers,
>> Daniel
>
>
