Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xB3Gl53YlzDrDL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 22:57:19 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6HCud0Q098257
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 08:57:17 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2brq7jgg3a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 08:57:17 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Mon, 17 Jul 2017 09:57:14 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6HCvCYb9830694
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 09:57:12 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6H9vCnf024988
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 06:57:13 -0300
Received: from localhost.localdomain ([9.85.136.158])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v6H9vBjx024967
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 06:57:12 -0300
To: linuxppc-dev@lists.ozlabs.org
References: <20161128003505.61590f63@roar.ozlabs.ibm.com>
Subject: Re: Kernel build issues with upstream binutils
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Mon, 17 Jul 2017 09:57:09 -0300
MIME-Version: 1.0
In-Reply-To: <20161128003505.61590f63@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <596CB425.3000103@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On bissecting kernel on Debian (gcc version 6.3.0 20170516) I've got the same
error on linking kernels <= v4.9 as reported previously in this thread:

ld: arch/powerpc/boot/zImage.pseries: Not enough room for program headers, try linking with -N
ld: final link failed: Bad value
arch/powerpc/boot/Makefile:364: recipe for target 'arch/powerpc/boot/zImage.pseries' failed
make[1]: *** [arch/powerpc/boot/zImage.pseries] Error 1
arch/powerpc/Makefile:278: recipe for target 'zImage' failed
make: *** [zImage] Error 2

Applying the fix proposed by Nicholas resolved the issue.

However that patch is not present - afaics - in > v4.9 (where it builds fine).

Any clue on why that is happening on <= v4.9 but not on kernels above that?

Thank you.


Regards,
Gustavo
