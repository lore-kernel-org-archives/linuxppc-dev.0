Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E52C1A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 17:51:14 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 30 Mar 2015 07:51:10 +0100
Message-ID: <5518F258.4060308@fr.ibm.com>
Date: Mon, 30 Mar 2015 08:51:04 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 3/3] powerpc/powernv: remove opal_sensor_mutex
References: <20150327095936.50A921400A0@ozlabs.org>
 <1427474362-3903-3-git-send-email-clg@fr.ibm.com>
 <1427681398.4218.7.camel@ellerman.id.au>
In-Reply-To: <1427681398.4218.7.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/30/2015 04:09 AM, Michael Ellerman wrote:
> On Fri, 2015-03-27 at 17:39 +0100, Cédric Le Goater wrote:
>> The opal sensor mutex protects the opal_sensor_read call which
>> can return a OPAL_BUSY code on IBM Power systems if a previous 
>> request is in progress.
>>
>> This can be handled at user level with a retry.
> 
> It can, but how does it actually look in practice?
> 
> It looks like the only use of opal_get_sensor_data() is show_sensor() in
> drivers/hwmon/ibmpowernv.c.
> 
> Because that's a sysfs attribute folks will be generally just dumping 
> that with cat, or reading it in a shell script, neither of which will 
> cope nicely with EBUSY I think?

It won't, I agree but it should only happen when running concurrent cat 
commands on the hwmon sysfs files. The event should be rare enough.

Anyhow, this is not a big issue. We can drop that patch. The real "issue"
is the time it takes to get some values back from the FSP. This is what
user space has been most surprised about.

Thanks,

C.
