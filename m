Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVPHK4NR0zDrgZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 01:23:25 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u88FMSoX053093
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 11:23:22 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25axg9vk0g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Sep 2016 11:23:22 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 8 Sep 2016 12:23:19 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 325A81DC0070
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 11:23:16 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u88FNGdB4755620
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 12:23:16 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u88FNFXo032515
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Sep 2016 12:23:15 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 Dave Young <dyoung@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org
Subject: Re: Kexec regression in next-20160906
Date: Thu, 08 Sep 2016 12:23:13 -0300
In-Reply-To: <20160907080807.GD5783@n2100.arm.linux.org.uk>
References: <20160906220936.4txqzodkgknhjiyh@atomide.com>
 <2229914.bQjEFCIRgO@hactar> <20160907080807.GD5783@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <8729269.3rIvqbaU1r@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 07 September 2016, 09:08:07 schrieb Russell King - ARM Linux:
> Any change to a UAPI header needs to be carefully considered and
> questioned as it is always a potential userspace breakage - and in
> the kernel, we're supposed to be doing our up-most to avoid
> breaking userspace.
> 
> It's not like it was in the old days when we didn't have the UAPI
> seperate - today, we can find these things by looking at the patch
> diffstat and seeing whether any file in "uapi" is touched.  That
> should be the trigger for a really in-depth review of the change.

No UAPI header is touched by this patch series. That is because there are 
two definitions of struct kexec_segment, one in include/linux/kexec.h and 
the other one in include/uapi/linux/kexec.h. My patch changed the former.
I was unaware of the second definition in the latter.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
