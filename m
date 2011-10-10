Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 05B8BB70FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 04:18:05 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
 by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p9AHGP0I025147
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 04:16:25 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9AHI3vu2125926
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 04:18:03 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9AHI2YJ004644
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 04:18:03 +1100
Message-ID: <4E932897.2060907@in.ibm.com>
Date: Mon, 10 Oct 2011 22:47:11 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] [powerpc32] Process dynamic relocations for kernel
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095432.16589.32935.stgit@suzukikp.in.ibm.com>
 <4E930BFA.5030701@freescale.com>
In-Reply-To: <4E930BFA.5030701@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>,
 Paul Mackerras <paulus@samba.org>, Alan Modra <amodra@au1.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/10/11 20:45, Scott Wood wrote:
> On 10/10/2011 04:55 AM, Suzuki K. Poulose wrote:
>> The following patch implements the dynamic relocation processing for
>> PPC32 kernel. relocate() accepts the target virtual address and relocates
>>   the kernel image to the same.
>
> How much overhead is involved in a true relocatable kernel?  Is it worth
> preserving the old "relocatable" booke behavior under a different name?

There are '75782' on an ebony kernel with minimal config. So thats a pretty big
number for small embedded chips. I guess, preserving the 'old relocatable' (page
aligned approach) would be a good idea for the architectures which can afford it.
e.g, places where TLB size is 64M or less.

Thanks
Suzuki
