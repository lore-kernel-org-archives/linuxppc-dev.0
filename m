Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 785D32C0094
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:36:21 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 05:30:58 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EB7D23578023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:36:17 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJO9gW5898538
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:24:09 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AJaFv8013872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:36:17 +1100
Message-ID: <5117F638.9070700@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 01:04:16 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 07/45] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073446.13822.39253.stgit@srivatsabhat.in.ibm.com>
 <87mwvsuw68.fsf@sejong.aot.lge.com>
In-Reply-To: <87mwvsuw68.fsf@sejong.aot.lge.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Namhyung,

On 01/29/2013 03:51 PM, Namhyung Kim wrote:
> Hi Srivatsa,
> 
> On Tue, 22 Jan 2013 13:04:54 +0530, Srivatsa S. Bhat wrote:
>> @@ -246,15 +291,21 @@ struct take_cpu_down_param {
>>  static int __ref take_cpu_down(void *_param)
>>  {
>>  	struct take_cpu_down_param *param = _param;
>> -	int err;
>> +	unsigned long flags;
>> +	int err = 0;
> 
> It seems no need to set 'err' to 0.
>

Sorry for the late reply. This mail got buried in my inbox and
I hadn't noticed it until now.. :-(

I'll remove the unnecessary initialization. Thank you!

Regards,
Srivatsa S. Bhat
