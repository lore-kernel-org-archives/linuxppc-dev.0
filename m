Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycjQl3GQHzDqpX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 11:53:02 +1100 (AEDT)
Message-ID: <1510783048.2397.68.camel@kernel.crashing.org>
Subject: Re: [PATCH] ibmveth: Kernel crash LSO offload flag toggle
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, Daniel Axtens
 <dja@axtens.net>, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, Sivakumar
 Krishnasamy <ksiva@linux.vnet.ibm.com>, stable@vger.kernel.org
Date: Thu, 16 Nov 2017 08:57:28 +1100
In-Reply-To: <94eb928a-5d8d-6bf8-9efd-5a9cd602050f@linux.vnet.ibm.com>
References: <20171114153420.3911-1-bryantly@linux.vnet.ibm.com>
 <87inec2r83.fsf@linkitivity.dja.id.au>
 <94eb928a-5d8d-6bf8-9efd-5a9cd602050f@linux.vnet.ibm.com>
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

On Wed, 2017-11-15 at 10:45 -0600, Bryant G. Ly wrote:
> This patch just closes the window, bad things can still happen. I wanted to leave it
> up to the people who actively develop in ibmveth to close the window, since introducing
> a lock can be expensive in tx. 

You don't need to instroduce a lock. The network stack already have a
per-queue lock, you just use the existing one.

Look at what I did in sungem or ftgmac100 with the reset task, those
are fairly simple drivers and should illustrate the technique.

Cheers,
Ben.
