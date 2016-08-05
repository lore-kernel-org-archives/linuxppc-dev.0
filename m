Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5f4G6dMSzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 06:46:54 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u75KiiSt042027
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 16:46:52 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkakf2y6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 16:46:52 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 17:46:49 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E501F1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:46:37 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u75Kkk3w31457580
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 17:46:46 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u75KkjkI009455
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 17:46:46 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Michael Ellerman <michael@ellerman.id.au>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Mark Rutland <mark.rutland@arm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] kexec: extend kexec_file_load system call
Date: Fri, 05 Aug 2016 17:46:43 -0300
In-Reply-To: <1469579069-28472-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <1469579069-28472-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1988385.QMVjiCbb5e@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Am Dienstag, 26 Juli 2016, 21:24:29 schrieb Thiago Jung Bauermann:
> Notes:
>     This is a new version of the last patch in this series which adds
>     a function where each architecture can verify if the DTB is safe
>     to load:
> 
>     int __weak arch_kexec_verify_buffer(enum kexec_file_type type,
>                                         const void *buf,
>                                         unsigned long size)
>     {
>             return -EINVAL;
>     }
> 
>     I will then provide an implementation in my powerpc patch series
>     which checks that the DTB only contains nodes and properties from a
>     whitelist. arch_kexec_kernel_image_load will copy these properties
>     to the device tree blob the kernel was booted with (and perform
>     other changes such as setting /chosen/bootargs, of course).

Is this approach ok? If so, I'll post a patch next week adding an 
arch_kexec_verify_buffer hook for powerpc to enforce the whitelist, and also 
a new version of the patches implementing kexec_file_load for powerpc on top 
of this series.

Eric, does this address your concerns?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
