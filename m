Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbD8x5pmfzF0t9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 16:51:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, mingo@redhat.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
 arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Subject: Re: [PATCH v11 3/3] mm,
 x86: display pkey in smaps only if arch supports pkeys
In-Reply-To: <20180202072139.GD5411@ram.oc3035372033.ibm.com>
References: <1517341452-11924-4-git-send-email-linuxram@us.ibm.com>
 <201802021225.JPjLbdCs%fengguang.wu@intel.com>
 <20180202072139.GD5411@ram.oc3035372033.ibm.com>
Date: Tue, 06 Feb 2018 16:51:12 +1100
Message-ID: <878tc64qen.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> On Fri, Feb 02, 2018 at 12:27:27PM +0800, kbuild test robot wrote:
>> Hi Ram,
>>=20
>> Thank you for the patch! Yet something to improve:
>>=20
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.15 next-20180201]
>> [if your patch is applied to the wrong git tree, please drop us a note t=
o help improve the system]
>>=20
>> url:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.co=
m_0day-2Dci_linux_commits_Ram-2DPai_mm-2Dx86-2Dpowerpc-2DEnhancements-2Dto-=
2DMemory-2DProtection-2DKeys_20180202-2D120004&d=3DDwIBAg&c=3Djf_iaSHvJObTb=
x-siA1ZOg&r=3Dm-UrKChQVkZtnPpjbF6YY99NbT8FBByQ-E-ygV8luxw&m=3DFv3tEHet1bTUr=
DjOnzEhXvGM_4tGlkYhJHPBnWNWgVA&s=3DZ1W6CV2tfPmLYU8lVv1oDRl2cAyQA76KE2P064A2=
CQY&e=3D
>> config: x86_64-randconfig-x005-201804 (attached as .config)
>> compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=3Dx86_64=20
>>=20
>> All error/warnings (new ones prefixed by >>):
>>=20
>>    In file included from arch/x86/include/asm/mmu_context.h:8:0,
>>                     from arch/x86/events/core.c:36:
>> >> include/linux/pkeys.h:16:23: error: expected identifier or '(' before=
 numeric constant
>>     #define vma_pkey(vma) 0
>>                           ^
>> >> arch/x86/include/asm/mmu_context.h:298:19: note: in expansion of macr=
o 'vma_pkey'
>>     static inline int vma_pkey(struct vm_area_struct *vma)
>>                       ^~~~~~~~
>>=20
>> vim +16 include/linux/pkeys.h
>>=20
>>      7=09
>>      8	#ifdef CONFIG_ARCH_HAS_PKEYS
>>      9	#include <asm/pkeys.h>
>>     10	#else /* ! CONFIG_ARCH_HAS_PKEYS */
>>     11	#define arch_max_pkey() (1)
>>     12	#define execute_only_pkey(mm) (0)
>>     13	#define arch_override_mprotect_pkey(vma, prot, pkey) (0)
>>     14	#define PKEY_DEDICATED_EXECUTE_ONLY 0
>>     15	#define ARCH_VM_PKEY_FLAGS 0
>>   > 16	#define vma_pkey(vma) 0
>
> Oops. Thanks for catching the issue. The following fix will resolve the e=
rror.
>
> diff --git a/arch/x86/include/asm/mmu_context.h
> b/arch/x86/include/asm/mmu_context.h
> index 6d16d15..c1aeb19 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -238,11 +238,6 @@ static inline int vma_pkey(struct vm_area_struct
> 		*vma)
>=20=20
>         return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
> }
> -#else
> -static inline int vma_pkey(struct vm_area_struct *vma)
> -{
> -       return 0;
> -}
>  #endif

That's not working for me (i386_defconfig):

  In file included from ../include/linux/pkeys.h:6:0,
                   from ../arch/x86/kernel/fpu/xstate.c:9:
  ../arch/x86/include/asm/mmu_context.h: In function =E2=80=98arch_vma_acce=
ss_permitted=E2=80=99:
  ../arch/x86/include/asm/mmu_context.h:276:28: error: implicit declaration=
 of function =E2=80=98vma_pkey=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
    return __pkru_allows_pkey(vma_pkey(vma), write);
                              ^~~~~~~~
  In file included from ../include/linux/pkeys.h:6:0,
                   from ../fs/proc/task_mmu.c:21:
  ../arch/x86/include/asm/mmu_context.h: In function =E2=80=98arch_vma_acce=
ss_permitted=E2=80=99:
  ../arch/x86/include/asm/mmu_context.h:276:28: error: implicit declaration=
 of function =E2=80=98vma_pkey=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
    return __pkru_allows_pkey(vma_pkey(vma), write);
                              ^~~~~~~~
  In file included from ../include/linux/pkeys.h:6:0,
                   from ../mm/mmap.c:46:
  ../arch/x86/include/asm/mmu_context.h: In function =E2=80=98arch_vma_acce=
ss_permitted=E2=80=99:
  ../arch/x86/include/asm/mmu_context.h:276:28: error: implicit declaration=
 of function =E2=80=98vma_pkey=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
    return __pkru_allows_pkey(vma_pkey(vma), write);
                              ^~~~~~~~
  In file included from ../include/linux/pkeys.h:6:0,
                   from ../mm/mprotect.c:27:
  ../arch/x86/include/asm/mmu_context.h: In function =E2=80=98arch_vma_acce=
ss_permitted=E2=80=99:
  ../arch/x86/include/asm/mmu_context.h:276:28: error: implicit declaration=
 of function =E2=80=98vma_pkey=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
    return __pkru_allows_pkey(vma_pkey(vma), write);
                              ^~~~~~~~
  In file included from ../include/linux/pkeys.h:6:0,
                   from ../arch/x86/kernel/fpu/core.c:15:
  ../arch/x86/include/asm/mmu_context.h: In function =E2=80=98arch_vma_acce=
ss_permitted=E2=80=99:
  ../arch/x86/include/asm/mmu_context.h:276:28: error: implicit declaration=
 of function =E2=80=98vma_pkey=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
    return __pkru_allows_pkey(vma_pkey(vma), write);
                              ^~~~~~~~

cheers
