Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZm5B3PRPzDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 07:46:06 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vACKju9V116329
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 15:46:03 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e6nynybe6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 15:46:00 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 12 Nov 2017 13:45:23 -0700
Date: Sun, 12 Nov 2017 12:45:10 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org,
 ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org,
 dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <45ca9196-1d7d-d530-45df-4ee41773cace@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <45ca9196-1d7d-d530-45df-4ee41773cace@c-s.fr>
Message-Id: <20171112204510.GE5546@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 10, 2017 at 07:10:31PM +0100, Christophe LEROY wrote:
> Hi
> 
> Le 06/11/2017 à 09:56, Ram Pai a écrit :
> >Memory protection keys enable applications to protect its
> >address space from inadvertent access from or corruption
> >by itself.
> >
> >These patches along with the pte-bit freeing patch series
> >enables the protection key feature on powerpc; 4k and 64k
> >hashpage kernels. It also changes the generic and x86
> >code to expose memkey features through sysfs. Finally
> >testcases and Documentation is updated.
> >
> >All patches can be found at --
> >https://github.com/rampai/memorykeys.git memkey.v9
> 
> As far as I can see you are focussing the implementation on 64 bits
> powerpc. This could also be implemented on 32 bits powerpc, for
> instance the 8xx has MMU Access Protection Registers which can be
> used to define 16 domains and could I think be used for implementing
> protection keys.

I was assuming non-existence of any 32bit powerpc
systems supporting memory keys. Sounds like it was a wrong assumption.

However, I think, the framework as it stands today should work. All
the functionality is captured in pkeys.c and pkeys.h which are generic
ppc files.  Its just a matter of providing the 32-bit implementation
for whichever sub-arch that support it.  Can you point me to problem
areas? I will fix them.

Thanks for you interest. Togather we should be able to make it
happen.


> Of course the challenge after that would be to find 4 spare PTE
> bits, I'm sure we can find them on the 8xx, at least when using 16k
> pages we have 2 bits already available, then by merging PAGE_SHARED
> and PAGE_USER and by reducing PAGE_RO to only one bit we can get the
> 4 spare bits.

yes. This needs to happen parallely.
RP

> 
> Therefore I think it would be great if you could implement a
> framework common to both PPC32 and PPC64.
