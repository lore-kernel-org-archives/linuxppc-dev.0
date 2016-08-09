Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7wwq681HzDrKs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 00:03:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79DsVbO040426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 10:03:21 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nc23tekx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 10:03:21 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 19:33:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 023EA3940066
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 19:33:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79E34rE23593370
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 19:33:04 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79E3CbQ029355
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 19:33:15 +0530
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Thiago Jung Bauermann'" <bauerman@linux.vnet.ibm.com>, Dave Young
 <dyoung@redhat.com>, "kexec@lists.infradead.org"
 <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-ima-devel@lists.sourceforge.net"
 <linux-ima-devel@lists.sourceforge.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 09 Aug 2016 10:02:57 -0400
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F50D431@AcuExch.aculab.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
 <063D6719AE5E284EB5DD2968C1650D6D5F50D431@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1470751377.2881.137.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-09 at 13:35 +0000, David Laight wrote:

> Also why '__packed' - guarantees sub-optimal code generation.
> Much better to include explicit padding to align everything.

This patch set does not define a new format, but piggy backs on top of
the existing <securityfs>/ima/binary_runtime_measurements list.  The
prefixed buffer header includes a version, so that if in the future we
need to modify the format, we would be able to.

In terms of the prefixed header, how would you define the fields:
version, buffer size, number of measurements? 

Mimi
