Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXx8J0p2HzDqK8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 11:26:40 +1100 (AEDT)
Date: Wed, 1 Mar 2017 11:26:35 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 ruscur@russell.cc, sam.bobroff@au1.ibm.com, mikey@neuling.org
Subject: Re: [PATCH V3 2/2] powerpc: Update to new option-vector-5 format for
 CAS
Message-ID: <20170301002634.GA30626@fergus.ozlabs.ibm.com>
References: <1488261828-19696-1-git-send-email-sjitindarsingh@gmail.com>
 <1488261828-19696-2-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488261828-19696-2-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 28, 2017 at 05:03:48PM +1100, Suraj Jitindar Singh wrote:
> On POWER9 the ibm,client-architecture-support (CAS) negotiation process
> has been updated to change how the host to guest negotiation is done for
> the new hash/radix mmu as well as the nest mmu, process tables and guest
> translation shootdown (GTSE).
> 
> The host tells the guest which options it supports in
> ibm,arch-vec-5-platform-support. The guest then chooses a subset of these
> to request in the CAS call and these are agreed to in the
> ibm,architecture-vec-5 property of the chosen node.
> 
> Thus we read ibm,arch-vec-5-platform-support and make our selection before
> calling CAS. We then parse the ibm,architecture-vec-5 property of the
> chosen node to check whether we should run as hash or radix.
> 
> ibm,arch-vec-5-platform-support format:
> 
> index value pairs: <index, val> ... <index, val>
> 
> index: Option vector 5 byte number
> val:   Some representation of supported values
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

It would be good if the description mentioned the PAPR architecture
change request "CAS option vector additions for P9".

Apart from that,

Acked-by: Paul Mackerras <paulus@ozlabs.org>
