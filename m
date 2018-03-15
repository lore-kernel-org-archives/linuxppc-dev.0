Return-Path: <dave.hansen@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402Cxm1Nl9zF170
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 03:01:14 +1100 (AEDT)
Subject: Re: [PATCH v3] x86: treat pkey-0 special
To: Thomas Gleixner <tglx@linutronix.de>, Ram Pai <linuxram@us.ibm.com>
References: <1521061214-22385-1-git-send-email-linuxram@us.ibm.com>
 <alpine.DEB.2.21.1803151039430.1525@nanos.tec.linutronix.de>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com,
 Ulrich.Weigand@de.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f5ef79ef-122a-e0a3-9b8e-d49c33f4a417@intel.com>
Date: Thu, 15 Mar 2018 08:55:31 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803151039430.1525@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/15/2018 02:46 AM, Thomas Gleixner wrote:
>> +	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
> Why this extra check? mm_pkey_is_allocated(mm, 0) should not return true
> ever. If it does, then this wants to be fixed.

I was thinking that we _do_ actually want it to seem allocated.  It just
get "allocated" implicitly when an mm is created.  I think that will
simplify the code if we avoid treating it specially in as many places as
possible.
