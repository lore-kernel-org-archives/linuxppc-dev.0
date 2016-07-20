Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvhFV2my2zDqVH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 01:50:22 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6KFnLQo065180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 11:50:19 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 249qakan3g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 11:50:19 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 20 Jul 2016 12:50:17 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id B8A83352006C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 11:49:55 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6KFoETd4771962
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 12:50:14 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6KFoDj7015525
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 12:50:14 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Balbir Singh <bsingharora@gmail.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com,
 kexec@lists.infradead.org, dyoung@redhat.com,
 Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Wed, 20 Jul 2016 12:50:11 -0300
In-Reply-To: <34243612.Gid3QHG1hd@wuerfel>
References: <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160720083530.GK1041@n2100.armlinux.org.uk> <34243612.Gid3QHG1hd@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2545578.SWp0m9VQX8@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 20 Juli 2016, 13:12:20 schrieb Arnd Bergmann:
> On Wednesday, July 20, 2016 8:47:45 PM CEST Michael Ellerman wrote:
> > At least for stdout-path, I can't really see how that would
> > significantly help an attacker, but I'm all ears if anyone has ideas.
> 
> That's actually an easy one that came up before: If an attacker controls
> a tty device (e.g. network console) that can be used to enter a debugger
> (kdb, kgdb, xmon, ...), enabling that to be the console device
> gives you a direct attack vector. The same thing will happen if you
> have a piece of software that intentially gives extra rights to the
> owner of the console device by treating it as "physical presence".

I think people are talking past each other a bit in these arguments about 
what is relevant to security or not.

For the kexec maintainers, kexec_file_load has one very specific and narrow 
purpose: enable Secure Boot as defined by UEFI.

And from what I understand of their arguments so far, there is one and only 
one security concern: when in Secure Boot mode, a system must not allow 
execution of unsigned code with kernel privileges. So even if one can 
specify a different root filesystem and do a lot of nasty things to the 
system with a rogue userspace in that root filesystem, as long as the kernel 
won't load unsigned modules that's not a problem as far as they're 
concerned.

Also, AFAIK attacks requiring "physical presence" are out of scope for the 
UEFI Secure Boot security model. Thus an attack that involves control of a 
console of plugging an USB device is also not a concern.

One thing I don't know is whether an attack involving a networked IPMI 
console or a USB device that can be "plugged" virtually by a managing system 
(BMC) is considered a physical attack or a remote attack in the context of 
UEFI Secure Boot.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
