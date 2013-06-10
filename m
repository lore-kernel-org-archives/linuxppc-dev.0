Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 69BE72C02A4
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 14:19:03 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 10 Jun 2013 14:10:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D85832CE804D
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 14:19:00 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5A44K4w58917090
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 14:04:20 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5A4IwfP014628
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 14:18:59 +1000
Message-ID: <51B55389.1080306@linux.vnet.ibm.com>
Date: Mon, 10 Jun 2013 09:48:17 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Partial revert of "Context switch more PMU
 related SPRs"
References: <1370491416-1807-1-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1370491416-1807-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2013 09:33 AM, Michael Ellerman wrote:
> In commit 59affcd I added context switching of more PMU SPRs, because
> they are potentially exposed to userspace on Power8. However despite me
> being a smart arse in the commit message it's actually not correct. In
> particular it interacts badly with a global perf record.

Could you please explain how it would interact badly with a global perf record.
If any user space try to mess around with the MMCR* registers itself, it would
definitely interfere with the kernel's own PMU config going on during perf record.
But thats how it works. So when we are actually dealing with MMCR* registers
directly, we should not invoke "perf record" session which can potential run on
the same PMU.

Regards
Anshuman
