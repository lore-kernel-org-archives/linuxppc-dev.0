Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xM6Kq0rXnzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 16:46:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>
Cc: linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de,
 linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
 linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org,
 mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [RFC v6 21/62] powerpc: introduce execute-only pkey
In-Reply-To: <87shhgdx5i.fsf@linux.vnet.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-22-git-send-email-linuxram@us.ibm.com>
 <87shhgdx5i.fsf@linux.vnet.ibm.com>
Date: Tue, 01 Aug 2017 16:46:22 +1000
Message-ID: <87d18fu6o1.fsf@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> Ram Pai <linuxram@us.ibm.com> writes:
...
>> +
>> +	/* We got one, store it and use it from here on out */
>> +	if (need_to_set_mm_pkey)
>> +		mm->context.execute_only_pkey = execute_only_pkey;
>> +	return execute_only_pkey;
>> +}
>
> If you follow the code flow in __execute_only_pkey, the AMR and UAMOR
> are read 3 times in total, and AMR is written twice. IAMR is read and
> written twice. Since they are SPRs and access to them is slow (or isn't
> it?),

SPRs read/writes are slow, but they're not *that* slow in comparison to
a system call (which I think is where this code is being called?).

So we should try to avoid too many SPR read/writes, but at the same time
we can accept more than the minimum if it makes the code much easier to
follow.

cheers
