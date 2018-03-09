Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyPfm3yw7zF12P
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 22:05:00 +1100 (AEDT)
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com,
 akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
 arnd@arndb.de, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <ec90ed75-2810-bcc3-8439-8dc85a6b46ac@redhat.com>
Date: Fri, 9 Mar 2018 12:04:49 +0100
MIME-Version: 1.0
In-Reply-To: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2018 09:12 AM, Ram Pai wrote:
> Once an address range is associated with an allocated pkey, it cannot be
> reverted back to key-0. There is no valid reason for the above behavior.

mprotect without a key does not necessarily use key 0, e.g. if 
protection keys are used to emulate page protection flag combination 
which is not directly supported by the hardware.

Therefore, it seems to me that filtering out non-allocated keys is the 
right thing to do.

Thanks,
Florian
