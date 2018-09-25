Return-Path: <dave.hansen@intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kb5G4zxszF3Fg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 08:16:32 +1000 (AEST)
Subject: Re: [PATCH v8 0/3] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
To: ego@linux.vnet.ibm.com
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
 <133c7bca-5720-81de-7956-b93870a1bab8@intel.com>
 <20180922110340.GA1402@in.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f2ac8eb0-b28e-a930-0160-09720f73a297@intel.com>
Date: Tue, 25 Sep 2018 15:16:30 -0700
MIME-Version: 1.0
In-Reply-To: <20180922110340.GA1402@in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/22/2018 04:03 AM, Gautham R Shenoy wrote:
> Without this patchset, the SMT domain would be defined as the group of
> threads that share L2 cache.

Could you try to make a more clear, concise statement about the current
state of the art vs. what you want it to be?  Right now, the sched
domains do something like this in terms of ordering:

1. SMT siblings
2. Caches
3. NUMA

It sounds like you don't want SMT siblings to be the things that we use,
right?  Because some siblings share caches and some do not.  Right?  You
want something like this:

1. SMT siblings (sharing L1)
2. SMT siblings (sharing L2)
3. Other caches
4. NUMA
