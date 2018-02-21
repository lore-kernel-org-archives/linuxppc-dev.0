Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmlTq3YpmzDrLB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 04:53:50 +1100 (AEDT)
Subject: Re: [PATCH 5/6] powerpc: Implement DISCONTIGMEM and allow selection
 on PPC32
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kbuild-all@01.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Joel Stanley <joel@jms.id.au>
References: <20180220161424.5421-6-j.neuschaefer@gmx.net>
 <201802210756.OZokd64C%fengguang.wu@intel.com>
 <20180221160815.dxhpsejt74zeqqjd@latitude>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <a0c7806e-e06e-eb6c-416b-022bdc36d757@c-s.fr>
Date: Wed, 21 Feb 2018 18:53:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180221160815.dxhpsejt74zeqqjd@latitude>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 21/02/2018 à 17:08, Jonathan Neuschäfer a écrit :
> On Wed, Feb 21, 2018 at 07:46:28AM +0800, kbuild test robot wrote:
> [...]
>>>> include/linux/mmzone.h:1239:19: error: conflicting types for 'pfn_valid'
>>      static inline int pfn_valid(unsigned long pfn)
>>                        ^~~~~~~~~
>>     In file included from include/linux/mmzone.h:912:0,
>>                      from include/linux/gfp.h:6,
>>                      from include/linux/mm.h:10,
>>                      from include/linux/mman.h:5,
>>                      from arch/powerpc/kernel/asm-offsets.c:22:
>>     arch/powerpc/include/asm/mmzone.h:40:19: note: previous definition of 'pfn_valid' was here
>>      static inline int pfn_valid(int pfn)
>>                        ^~~~~~~~~
>>     make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
>>     make[2]: Target '__build' not remade because of errors.
>>     make[1]: *** [prepare0] Error 2
>>     make[1]: Target 'prepare' not remade because of errors.
>>     make: *** [sub-make] Error 2
> 
> Oops, I'll fix this in the next version (and compile-test on ppc64...).
> 
> Weirdly enough, x86-32 and parisc define pfn_valid with an int
> parameter, too (both of them since the Beginning Of Time, aka.
> v2.6.12-rc2).
> 

Behind the fact that the pfn type is different, my understanding is that 
you have to define CONFIG_HAVE_ARCH_PFN_VALID in the Kconfig in order to 
avoid it being included in include/linux/mmzone.h

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
