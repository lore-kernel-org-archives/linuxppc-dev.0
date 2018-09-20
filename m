Return-Path: <dave.hansen@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GPlQ39r2zF3N1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 04:05:00 +1000 (AEST)
Subject: Re: [PATCH v8 0/3] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <133c7bca-5720-81de-7956-b93870a1bab8@intel.com>
Date: Thu, 20 Sep 2018 11:04:54 -0700
MIME-Version: 1.0
In-Reply-To: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/20/2018 10:22 AM, Gautham R. Shenoy wrote:
>  	   -------------------------
> 	   |  	    L1 Cache       |
>        ----------------------------------
>        |L2|     |     |     |      |
>        |  |  0  |  2  |  4  |  6   |Small Core0
>        |C |     |     |     |      |
> Big    |a --------------------------
> Core   |c |     |     |     |      |
>        |h |  1  |  3  |  5  |  7   | Small Core1
>        |e |     |     |     |      |
>        -----------------------------
> 	  |  	    L1 Cache       |
> 	  --------------------------

The scheduler already knows about shared caches.  Could you elaborate on
how this is different from the situation today where we have multiple
cores sharing an L2/L3?

Adding the new sysfs stuff seems like overkill if that's all that you
are trying to do.
