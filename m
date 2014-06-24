Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56B671A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 07:46:27 +1000 (EST)
Message-ID: <1403646374.4587.178.camel@pasglop>
Subject: Re: [PATCH] vfio: Fix endianness handling for emulated BARs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Wed, 25 Jun 2014 07:46:14 +1000
In-Reply-To: <53A955F5.6050801@suse.de>
References: <1403091391-31780-1-git-send-email-aik@ozlabs.ru>
 <1403116512.3707.175.camel@ul30vt.home> <53A233E9.6030006@ozlabs.ru>
 <53A241F6.9010307@ozlabs.ru> <53A25D74.5000804@ozlabs.ru>
 <1403234514.3707.278.camel@ul30vt.home> <1403305961.4587.66.camel@pasglop>
 <53A94EBD.101@ozlabs.ru> <53A955F5.6050801@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-24 at 12:41 +0200, Alexander Graf wrote:
> Is there actually any difference in generated code with this patch 
> applied and without? I would hope that iowrite..() is inlined and 
> cancels out the cpu_to_le..() calls that are also inlined?

No, the former uses byteswapping asm, the compiler can't "cancel" it
out, but the overhead of the additional byteswap might not be
measurable.

Cheers,
Ben.
