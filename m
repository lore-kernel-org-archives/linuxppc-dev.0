Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmHS85KlmzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 00:48:55 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u68Ei5Ou038935
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 10:48:53 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xnymx2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 10:48:52 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 11:48:50 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 68B5F352005F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 10:48:30 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u68EmmLO3391712
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 11:48:48 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u68Eml6c009442
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 11:48:47 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
 will.deacon@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] arm64: kexec_file_load support
Date: Fri, 08 Jul 2016 11:48:44 -0300
In-Reply-To: <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
References: <20160701051111.GL20774@linaro.org>
 <20160705080355.GQ20774@linaro.org>
 <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <11139482.zLvCKVycQr@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 07 Juli 2016, 14:12:45 schrieb Dave Young:
> If so maybe change a bit from your precious mentioned 7 args proposal like
> below?
> 
> struct kexec_file_fd {
> 	enum kexec_file_type;
> 	int fd;
> }
> 
> struct kexec_fdset {
> 	int nr_fd;
> 	struct kexec_file_fd fd[0];
> }
> 
> int kexec_file_load(int kernel_fd, int initrd_fd,
> 		    unsigned long cmdline_len, const char *cmdline_ptr,
> 		    unsigned long flags, struct kexec_fdset *extra_fds);


Is there a way for the kernel to distinguish whether the process passed 5 or 
6 arguments? How can it know whether extra_fds is a valid argument or just 
garbage? I think we have to define a new flag KEXEC_FILE_EXTRA_FDS so that 
the process can signal that it is using the new interface.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
