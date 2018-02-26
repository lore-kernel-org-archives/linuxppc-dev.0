Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqYLL3xq0zF1St
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 18:27:05 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1Q7Q5V0139592
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 02:27:03 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gccu3t6kj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 02:27:02 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 26 Feb 2018 07:27:00 -0000
Date: Sun, 25 Feb 2018 23:26:45 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, mpe@ellerman.id.au,
 mingo@redhat.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Subject: Re: [PATCH v12 1/3] mm, powerpc, x86: define VM_PKEY_BITx bits if
 CONFIG_ARCH_HAS_PKEYS is enabled
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1519257138-23797-2-git-send-email-linuxram@us.ibm.com>
 <201802231528.snWZIspR%fengguang.wu@intel.com>
 <20180224010511.GK5559@ram.oc3035372033.ibm.com>
 <43082fe4-a6e4-2468-0069-4fbc53418c79@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43082fe4-a6e4-2468-0069-4fbc53418c79@linux.vnet.ibm.com>
Message-Id: <20180226072645.GA1060@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 25, 2018 at 05:27:11PM +0530, Aneesh Kumar K.V wrote:
> 
> 
> On 02/24/2018 06:35 AM, Ram Pai wrote:
> >On Fri, Feb 23, 2018 at 03:11:45PM +0800, kbuild test robot wrote:
> >>Hi Ram,
> >>
> >>Thank you for the patch! Yet something to improve:
> >>
> >>[auto build test ERROR on linus/master]
> >>[also build test ERROR on v4.16-rc2 next-20180222]
> >>[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >>
> >>         chmod +x ~/bin/make.cross
> >...snip..
> >>         # save the attached .config to linux build tree
> >>         make.cross ARCH=powerpc
> >>
> >>Note: the linux-review/Ram-Pai/mm-x86-powerpc-Enhancements-to-Memory-Protection-Keys/20180223-042743 HEAD c5692bca45543c242ffca15c811923e4c548ed19 builds fine.
> >>       It only hurts bisectibility.
> >
> >oops, it broke git-bisect on powerpc :-(
> >The following change will fix it. This should nail it down.
> >
> >diff --git a/arch/powerpc/include/asm/pkeys.h
> >b/arch/powerpc/include/asm/pkeys.h
> >index 0409c80..0b3b669 100644
> >--- a/arch/powerpc/include/asm/pkeys.h
> >+++ b/arch/powerpc/include/asm/pkeys.h
> >@@ -25,6 +25,7 @@
> >  # define VM_PKEY_BIT1  VM_HIGH_ARCH_1
> >  # define VM_PKEY_BIT2  VM_HIGH_ARCH_2
> >  # define VM_PKEY_BIT3  VM_HIGH_ARCH_3
> >  # define VM_PKEY_BIT4  VM_HIGH_ARCH_4
> >+#elif !defined(VM_PKEY_BIT4)
> >+# define VM_PKEY_BIT4  VM_HIGH_ARCH_4
> >#endif
> >
> 
> Why don't you remove this powerpc definition completely in this
> patch? 

That was my thought too, but refrained from sneaking in the changes into
the patch, to maintain the integrity of all the reviewed-by.

Was planning on sending a seperate patch to remove the
powerpc definition entirely.

RP
