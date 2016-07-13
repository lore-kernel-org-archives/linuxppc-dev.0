Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqBgX1yV1zDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 18:23:52 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D8JQgM117575
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 04:23:49 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24567buc3g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 04:23:49 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 04:23:49 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: Mark Rutland <mark.rutland@arm.com>, bhe@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 bauerman@linux.vnet.ibm.com, Dave Young <dyoung@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <5352106.oQ0Ff9gWJA@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712145010.GA8447@leverpostej>
 <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
 <5352106.oQ0Ff9gWJA@wuerfel>
Date: Wed, 13 Jul 2016 18:23:34 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k2gqndyx.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> writes:
> On Wednesday, July 13, 2016 10:36:14 AM CEST Dave Young wrote:
>> On 07/12/16 at 03:50pm, Mark Rutland wrote:
>> > On Tue, Jul 12, 2016 at 04:24:10PM +0200, Arnd Bergmann wrote:
>> > > On Tuesday, July 12, 2016 10:18:11 AM CEST Vivek Goyal wrote:
>> > 
>> > /proc/devicetree (aka /sys/firmware/devicetree) is a filesystem derived
>> > from the raw DTB (which is exposed at /sys/firmware/fdt).
>> > 
>> > The blob that was handed to the kernel at boot time is exposed at
>> > /sys/firmware/fdt.
>> 
>> I believe the blob can be read and passed to kexec kernel in kernel code without
>> the extra fd.
>> 
>> But consider we can kexec to a different kernel and a different initrd so there
>> will be use cases to pass a total different dtb as well. From my understanding
>> it is reasonable but yes I think we should think carefully about the design.
>
> Ok, I can see four interesting use cases here:
>
> - Using the dtb that the kernel has saved at boot time. Ideally this should not
>   require an additional step of signing it, since the running kernel already
>   trusts it.

- using current view of the hardware, flattened into a new dtb.
  This should already be trusted, as it's what we're running now (boot +
  runtime changes)

-- 
Stewart Smith
OPAL Architect, IBM.
