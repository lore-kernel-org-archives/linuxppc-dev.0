Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTNFj5DcDzDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 09:33:29 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u86NRoKP141737
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 19:33:27 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25a3m5rpga-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 19:33:26 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 20:33:25 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 5010F1DC0020
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 19:33:23 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u86NXNSY5189826
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 20:33:23 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u86NXMaQ018584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 20:33:23 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Dave Young <dyoung@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
Subject: Re: Kexec regression in next-20160906
Date: Tue, 06 Sep 2016 20:33:20 -0300
In-Reply-To: <20160906220936.4txqzodkgknhjiyh@atomide.com>
References: <20160906220936.4txqzodkgknhjiyh@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2229914.bQjEFCIRgO@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Tony,

Am Dienstag, 06 September 2016, 15:09:37 schrieb Tony Lindgren:
> Looks like commit 5c01cdd2d4bc ("kexec_file: allow skipping checksum
> calculation for some segments") makes next-20160916 stop working for
> me at least on ARM.
> 
> I now get "kexec_load failed: Invalid argument error" on loading the
> new kernel to memory with kexec -l.
> 
> Reverting the following two commits makes things work for me again:
> 
> d2bf993afdf1 ("kexec_file: add mechanism to update kexec segments")
> 5c01cdd2d4bc ("kexec_file: allow skipping checksum calculation for
> some segments")

Thanks for reporting the problem and finding the commit that caused it.
The only thing in commit 5c01cdd2d4bc which can affect kexec_load is the 
fact that struct kexec_segment has a new member.

This is probably breaking the ABI on ARM, then. I verified that kexec_load 
kept working on ppc64le with a kexec binary compiled with the original 
struct kexec_segment definition, but apparently I got lucky.

I'll prepare a new version of the kexec buffer hand-over series which 
doesn't touch struct kexec_segment.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
