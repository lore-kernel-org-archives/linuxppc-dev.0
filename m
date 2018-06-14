Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4162dK1BQnzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 22:15:32 +1000 (AEST)
Subject: Re: [PATCH v2 0/6] powerpc/pkeys: fixes to pkeys
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, Ulrich.Weigand@de.ibm.com,
 luto@kernel.org, msuchanek@suse.de
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <8812c879-5761-ef62-dd15-3ceef46d9653@redhat.com>
Date: Thu, 14 Jun 2018 14:15:26 +0200
MIME-Version: 1.0
In-Reply-To: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2018 02:28 AM, Ram Pai wrote:
> Assortment of fixes to pkey.
> 
> Patch 1  makes pkey consumable in multithreaded applications.
> 
> Patch 2  fixes fork behavior to inherit the key attributes.
> 
> Patch 3  A off-by-one bug made one key unusable. Fixes it.
> 
> Patch 4  Execute-only key is preallocated.
> 
> Patch 5  Makes pkey-0 less special.
> 
> Patch 6  Deny by default permissions on all unallocated keys.
> 
> Passes all selftests on powerpc. Also behavior verified to be correct
> by Florian.
> 
> Changelog:
> 
> 	v2: . fixed merge conflict with upstream code.
> 	    . Add patch 6. Makes the behavior consistent
> 	      with that on x86.

(Except signal handling, but I agree with Ram that the POWER behavior is 
the correct one.)

> Ram Pai (6):
>    powerpc/pkeys: Enable all user-allocatable pkeys at init.
>    powerpc/pkeys: Save the pkey registers before fork
>    powerpc/pkeys: fix calculation of total pkeys.
>    powerpc/pkeys: Preallocate execute-only key
>    powerpc/pkeys: make protection key 0 less special
>    powerpc/pkeys: Deny read/write/execute by default

I tested the whole series with the new selftests, with the printamr.c 
program I posted earlier, and the glibc test for pkey_alloc &c.  The 
latter required some test fixes, but now passes as well.  As far as I 
can tell, everything looks good now.

Tested-By: Florian Weimer <fweimer@redhat.com>

Thanks,
Florian
