Return-Path: <dave.hansen@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401fRW1n10zF0nX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 04:51:31 +1100 (AEDT)
Subject: Re: [PATCH 1/1 v2] x86: pkey-mprotect must allow pkey-0
To: Ram Pai <linuxram@us.ibm.com>
References: <1521013574-27041-1-git-send-email-linuxram@us.ibm.com>
 <18b155e3-07e9-5a4b-1f95-e1667078438c@intel.com>
 <20180314171448.GA1060@ram.oc3035372033.ibm.com>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5027ca9e-63c8-47ab-960d-a9c4466d7075@intel.com>
Date: Wed, 14 Mar 2018 10:51:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180314171448.GA1060@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2018 10:14 AM, Ram Pai wrote:
> I look at key-0 as 'the key'. It has special status. 
> (a) It always exist.

Do you mean "is always allocated"?

> (b) it cannot be freed.

This is the one I'm questioning.

> (c) it is assigned by default.

I agree on this totally. :)

> (d) its permissions cannot be modified.

Why not?  You could pretty easily get a thread going that had its stack
covered with another pkey and that was being very careful what it
accesses.  It could pretty easily set pkey-0's access or write-disable bits.

> (e) it bypasses key-permission checks when assigned.

I don't think this is necessary.  I think the only rule we *need* is:

	pkey-0 is allocated implicitly at execve() time.  You do not
	need to call pkey_alloc() to allocate it.

> An arch need not necessarily map 'the key-0' to its key-0.  It could
> internally map it to any of its internal key of its choice, transparent
> to the application.

I don't understand what you are saying here.
