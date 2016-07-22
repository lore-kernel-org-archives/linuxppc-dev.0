Return-Path: <jeremy.kerr@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwXGF3n8YzDrF8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 10:53:57 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6M0rq9h107319
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 20:53:54 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24ay1uc90y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 20:53:54 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jeremy.kerr@au1.ibm.com>;
 Fri, 22 Jul 2016 10:53:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9820F2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 10:53:45 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6M0rj6H13959168
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 10:53:45 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6M0riXT017028
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 10:53:45 +1000
Subject: Re: [RFC 0/3] extend kexec_file_load system call
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <3489461.zQnV5C1bXR@wuerfel> <1808359.GMbkTHC4O6@hactar>
 <4197460.etrDupniY8@hactar>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Vivek Goyal <vgoyal@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>
From: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Date: Fri, 22 Jul 2016 08:53:41 +0800
MIME-Version: 1.0
In-Reply-To: <4197460.etrDupniY8@hactar>
Content-Type: text/plain; charset=windows-1252
Message-Id: <7619c6f9-689e-f062-08d4-0d11a2df66ad@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thiago,

> So even if not ideal, the solution above is desirable for powerpc. We would 
> like to preserve the ability of allowing userspace to pass parameters to the 
> OS via the DTB, even if secure boot is enabled.
> 
> I would like to turn the above into a proposal:
> 
> Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
> accepting a complete DTB from userspace, the syscall accepts a DTB 
> containing only a /chosen node. If the DTB contains any other node, the 
> syscall fails with EINVAL. If the DTB contains any subnode in /chosen, or if 
> there's a compatible or device_type property in /chosen, the syscall fails 
> with EINVAL as well.

This works for me. We could even have it as just a DTB fragment that is
merged *at* the /chosen/ node of the kernel-device tree - so would not
contain a /chosen node itself, and it would be impossible to provide
nodes outside of /chosen. Either is fine.

Thanks!


Jeremy
