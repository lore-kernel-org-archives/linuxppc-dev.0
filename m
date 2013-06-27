Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3954E2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 19:39:55 +1000 (EST)
Message-ID: <1372325975.18612.41.camel@pasglop>
Subject: Re: [PATCH v3] powerpc: Rework iommu_table locks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 27 Jun 2013 19:39:35 +1000
In-Reply-To: <1372308796-27796-1-git-send-email-aik@ozlabs.ru>
References: <1372308796-27796-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-27 at 14:53 +1000, Alexey Kardashevskiy wrote:
> 
> 2. remove locks from functions being called by VFIO. The whole table
> is given to the user space so it is responsible now for races.

Sure but you still need to be careful that userspace cannot cause things
that crash the kernel. For example, look careful at what could happen if
two user space threads try to manipulate the same TCE entry at the same
time and whether that can cause a deadly kernel race... something tells
me it can.

Cheers,
Ben.
