Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412CjT0TdpzF363
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 16:50:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: stable@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v3 PATCH 2/5] powerpc/pseries: Fix endainness while restoring of
 r3 in MCE handler.
In-Reply-To: <152839249913.25118.1191250274945665204.stgit@jupiter.in.ibm.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839249913.25118.1191250274945665204.stgit@jupiter.in.ibm.com>
Date: Fri, 08 Jun 2018 16:50:47 +1000
Message-ID: <87fu1xvkjc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> During Machine Check interrupt on pseries platform, register r3 points
> RTAS extended event log passed by hypervisor. Since hypervisor uses r3
> to pass pointer to rtas log, it stores the original r3 value at the
> start of the memory (first 8 bytes) pointed by r3. Since hypervisor
> stores this info and rtas log is in BE format, linux should make
> sure to restore r3 value in correct endian format.

Can we hit this under KVM? And if so what if the KVM/qemu is running
little endian, does it still write the value BE?

cheers
