Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B7142C00A1
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Jun 2013 19:06:30 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 4 Jun 2013 18:58:08 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 920342BB0052
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Jun 2013 19:06:24 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r548ppta27656400
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Jun 2013 18:51:51 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5496MTD023100
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Jun 2013 19:06:24 +1000
Message-ID: <51ADADEB.1040109@linux.vnet.ibm.com>
Date: Tue, 04 Jun 2013 14:35:47 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/perf: Fix deadlock caused by calling printk()
 in PMU exception
References: <1370319657-26753-1-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1370319657-26753-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +	seq_printf(p, "%*s: ", prec, "PMS");

Lets make this PMIS or PMI_S instead of PMS.


> +	for_each_online_cpu(j)
> +		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);

This would be pmu_spurious_irqs instead of pmu_irqs.
