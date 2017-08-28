Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh3mf0L97zDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 06:49:52 +1000 (AEST)
Message-ID: <1503953376.4850.9.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] cxl: Enable global TLBIs for cxl contexts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Date: Tue, 29 Aug 2017 06:49:36 +1000
In-Reply-To: <03f1e0fc-77ca-c75b-319d-b76332ff4403@linux.vnet.ibm.com>
References: <20170828084731.14773-1-fbarrat@linux.vnet.ibm.com>
 <20170828084731.14773-2-fbarrat@linux.vnet.ibm.com>
 <1503921783.4850.5.camel@kernel.crashing.org>
 <03f1e0fc-77ca-c75b-319d-b76332ff4403@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-28 at 19:37 +0200, Frederic Barrat wrote:
> Good point, I had missed the change. It looks like I now need to call 
> radix__flush_all_mm(), which I would have to export outside of 
> tlb-radix.c first.
> 
> Any problem with having a flush_all_mm() to complement a flush_tlb_mm()? 
> It's tainted with radix, and the 2 would be equivalent on hash, but it 
> would make things easy.

Yup something like that.

Cheers,
Ben.
