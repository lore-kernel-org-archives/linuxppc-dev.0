Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B6C62C0156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 13:08:53 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 13:02:53 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 062E32BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 13:08:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q2t9Vv10420248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 12:55:09 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q38iHN011371
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 13:08:45 +1000
Message-ID: <5179EFB6.3090602@linux.vnet.ibm.com>
Date: Fri, 26 Apr 2013 11:08:38 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] PowerPC: kernel: compiling issue, make additional
 room in exception vector area
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <20130425062539.GA421@iris.ozlabs.ibm.com> <517918AB.4020508@asianux.com>
 <30269.1366931768@ale.ozlabs.ibm.com> <5179D302.9060203@asianux.com>
 <5179D5D8.8080102@asianux.com> <5179DA23.8000407@asianux.com>
 <5179E056.2000709@linux.vnet.ibm.com> <5179E11F.8010007@asianux.com>
In-Reply-To: <5179E11F.8010007@asianux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
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

于 2013/4/26 10:06, Chen Gang 写道:
> On 2013年04月26日 10:03, Mike Qiu wrote:
>> �� 2013/4/26 9:36, Chen Gang д��:
>>>> On 2013��04��26�� 09:18, Chen Gang wrote:
>>>>>> On 2013��04��26�� 09:06, Chen Gang wrote:
>>>>>>>>>> CFAR is the Come From Register.  It saves the location of the last
>>>>>>>>>>>> branch and is hence overwritten by any branch.
>>>>>>>>>>>>
>>>>>>>> Do we process it just like others done (e.g. 0x300, 0xe00, 0xe20 ...) ?
>>>>>>>> 	. = 0x900
>>>>>>>> 	.globl decrementer_pSeries
>>>>>>>> decrementer_pSeries:
>>>>>>>>   	HMT_MEDIUM_PPR_DISCARD
>>>>>>>> 	SET_SCRATCH0(r13)
>>>>>>>> 	b decrementer_pSeries_0
>>>>>>>>
>>>>>>>> 	...
>>>>>>>>
>>>>>>>>
>>>> Oh, it seems EXCEPTION_PROLOG_1 will save the regesters which related
>>>> with CFAR, so I think need move EXCEPTION_PROLOG_1 to near 0x900.
>> I will try your diff V2, to see if the machine can boot up
> OK, thanks. (hope it can work)
It seems that the machine can be bootup in powernv mode, but I'm not 
sure if my machine call that module.

At lease my machine can boot up

Thanks
Mike
>
> :-)
>
