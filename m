Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E51421A008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:39:55 +1000 (EST)
Message-ID: <1407242394.11569.2.camel@concordia>
Subject: Re: [PATCH] arch/powerpc/mm/numa.c: Fix break placement
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 05 Aug 2014 22:39:54 +1000
In-Reply-To: <1407230219.3073.5.camel@pasglop>
References: <1407183190-1397-1-git-send-email-andrey.krieger.utkin@gmail.com>
 <1407230219.3073.5.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, rcj@linux.vnet.ibm.com, alistair@popple.id.au,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrey Utkin <andrey.krieger.utkin@gmail.com>, paulus@samba.org,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, joe@perches.com,
 qiuxishi@huawei.com, akpm@linux-foundation.org, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-05 at 19:16 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2014-08-04 at 23:13 +0300, Andrey Utkin wrote:
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=81631
> > Reported-by: David Binderman <dcb314@hotmail.com>
> > Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>
> 
> Thanks, I wonder how that managed to remain unnoticed for so long !

1. No one tested it :)
2. The code stupidly initialises ret at the beginning of the function, so the
   compiler can't help us detect the unitialised usage.
3. NOTIFY_OK and NOTIFY_DONE appear to be equivalent in practice.

cheers
