Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CE252C00FA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 19:32:40 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Sat, 27 Apr 2013 19:23:06 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5C0172BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 19:32:37 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3R9InLa19333158
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 19:18:49 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3R9WZm5011085
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2013 19:32:36 +1000
Message-ID: <517B9B2B.30007@linux.vnet.ibm.com>
Date: Sat, 27 Apr 2013 17:32:27 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang F T <chen.gang.flying.transformer@gmail.com>
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
 <5179EFB6.3090602@linux.vnet.ibm.com> <5179F39C.5020408@asianux.com>
 <5179F7B8.5010701@asianux.com> <5179FA8E.9090501@linux.vnet.ibm.com>
 <517B9A4D.1020502@gmail.com>
In-Reply-To: <517B9A4D.1020502@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 Chen Gang <gang.chen@asianux.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
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

于 2013/4/27 17:28, Chen Gang F T 写道:
> On 2013年04月26日 11:54, Mike Qiu wrote:
>> 于 2013/4/26 11:42, Chen Gang 写道:
>>> On 2013年04月26日 11:25, Chen Gang wrote:
>>>> On 2013年04月26日 11:08, Mike Qiu wrote:
>>>>> 于 2013/4/26 10:06, Chen Gang 写道:
>>>>>> On 2013年04月26日 10:03, Mike Qiu wrote:
>>>>>>> �� 2013/4/26 9:36, Chen Gang д��:
>>>>>>>>> On 2013��04��26�� 09:18, Chen Gang wrote:
>>>>>>>>>>> On 2013��04��26�� 09:06, Chen Gang wrote:
>>>>>>>>>>>>>>> CFAR is the Come From Register.  It saves the location of the
>>>>>>>>>>>>>>> last
>>>>>>>>>>>>>>>>> branch and is hence overwritten by any branch.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>> Do we process it just like others done (e.g. 0x300, 0xe00,
>>>>>>>>>>>>> 0xe20 ...) ?
>>>>>>>>>>>>>       . = 0x900
>>>>>>>>>>>>>       .globl decrementer_pSeries
>>>>>>>>>>>>> decrementer_pSeries:
>>>>>>>>>>>>>         HMT_MEDIUM_PPR_DISCARD
>>>>>>>>>>>>>       SET_SCRATCH0(r13)
>>>>>>>>>>>>>       b decrementer_pSeries_0
>>>>>>>>>>>>>
>>>>>>>>>>>>>       ...
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>> Oh, it seems EXCEPTION_PROLOG_1 will save the regesters which
>>>>>>>>> related
>>>>>>>>> with CFAR, so I think need move EXCEPTION_PROLOG_1 to near 0x900.
>>>>>>> I will try your diff V2, to see if the machine can boot up
>>>>>> OK, thanks. (hope it can work)
>>>>> It seems that the machine can be bootup in powernv mode, but I'm not
>>>>> sure if my machine call that module.
>>>>>
>>>>> At lease my machine can boot up
>>> Please reference commit number: 1707dd161349e6c54170c88d94fed012e3d224e3
>>> (1707dd1 powerpc: Save CFAR before branching in interrupt entry paths)
>>>
>>> What our diff v2 has done is just the fix for our patch v2 (just like
>>> the commit 1707dd1 has done).
>>>
>>> Please check, thanks.
>>>
>>> :-)
>> I will check this evening or tomorrow, I have something else to do this
>> afteroon.
> I think the diff v2 is correct, but is not the best one for this issue.
>
> I prefer the Paul's patch for this issue which has better performance
>
> :-)
yes, I use your patch and it can work, also Paul's patch can work too.
>
> Thanks.
>
