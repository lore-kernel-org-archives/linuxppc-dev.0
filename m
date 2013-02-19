Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77CB32C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 05:31:38 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 19 Feb 2013 23:59:36 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 34128E0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 00:02:21 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1JIVLwR31719448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 00:01:21 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1JIVLmm012840
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 05:31:23 +1100
Message-ID: <5123C482.5070704@linux.vnet.ibm.com>
Date: Tue, 19 Feb 2013 23:59:22 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [PATCH v5 29/45] x86/xen: Use get/put_online_cpus_atomic() to
 prevent CPU offline
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074046.13822.61950.stgit@srivatsabhat.in.ibm.com>
 <20130219181038.GB18244@phenom.dumpdata.com>
In-Reply-To: <20130219181038.GB18244@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
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

On 02/19/2013 11:40 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 22, 2013 at 01:10:51PM +0530, Srivatsa S. Bhat wrote:
>> Once stop_machine() is gone from the CPU offline path, we won't be able to
>> depend on preempt_disable() or local_irq_disable() to prevent CPUs from
>> going offline from under us.
>>
>> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
>> while invoking from atomic context.
>>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Weird. I see this in the patch but I don't see it in the header?

Meaning, you didn't get this email at all?

> Did you
> explicitly suppress the CC part?
> 

No.. I sent the entire patchset to a set of email ids and in addition to
that I CC'ed individual patches to the respective maintainers/lists (the
CC: list in the changelog). I used the --auto knob from stgit to do that.

> 
> Anyhow, the patch looks sane enough, thought I need to to run it through
> a test framework just to be on a sure side.
>

Sure, thank you. But you might want to test the v6 that I sent out
yesterday instead of v5. Oh, wait a min, you didn't get the v6 mail also?

Here it is, for your reference:
http://marc.info/?l=linux-kernel&m=136119260122255&w=2

Regards,
Srivatsa S. Bhat

>> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: xen-devel@lists.xensource.com
>> Cc: virtualization@lists.linux-foundation.org
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
