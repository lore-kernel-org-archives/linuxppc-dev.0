Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E12DC2C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:47:04 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 01:15:24 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 488413940055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 01:16:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJktH137814522
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 01:16:55 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AJkvo7008667
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:46:58 +1100
Message-ID: <5117F8BF.8010009@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 01:15:03 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v5 44/45] CPU hotplug, stop_machine: Decouple CPU hotplug
 from stop_machine() in Kconfig
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074518.13822.86992.stgit@srivatsabhat.in.ibm.com>
 <20130209001554.GR2666@linux.vnet.ibm.com>
In-Reply-To: <20130209001554.GR2666@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
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

On 02/09/2013 05:45 AM, Paul E. McKenney wrote:
> On Tue, Jan 22, 2013 at 01:15:22PM +0530, Srivatsa S. Bhat wrote:
>> ... and also cleanup a comment that refers to CPU hotplug being dependent on
>> stop_machine().
>>
>> Cc: David Howells <dhowells@redhat.com>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> (Hey, I thought I owed myself an easy one!)
> 

Haha ;-)

Regards,
Srivatsa S. Bhat

>> ---
>>
>>  include/linux/stop_machine.h |    2 +-
>>  init/Kconfig                 |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
>> index 3b5e910..ce2d3c4 100644
>> --- a/include/linux/stop_machine.h
>> +++ b/include/linux/stop_machine.h
>> @@ -120,7 +120,7 @@ int stop_machine(int (*fn)(void *), void *data, const struct cpumask *cpus);
>>   * @cpus: the cpus to run the @fn() on (NULL = any online cpu)
>>   *
>>   * Description: This is a special version of the above, which assumes cpus
>> - * won't come or go while it's being called.  Used by hotplug cpu.
>> + * won't come or go while it's being called.
>>   */
>>  int __stop_machine(int (*fn)(void *), void *data, const struct cpumask *cpus);
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index be8b7f5..048a0c5 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1711,7 +1711,7 @@ config INIT_ALL_POSSIBLE
>>  config STOP_MACHINE
>>  	bool
>>  	default y
>> -	depends on (SMP && MODULE_UNLOAD) || HOTPLUG_CPU
>> +	depends on (SMP && MODULE_UNLOAD)
>>  	help
>>  	  Need stop_machine() primitive.
>>
>>
