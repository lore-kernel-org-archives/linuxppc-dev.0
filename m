Return-Path: <penberg@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 980EEDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 22:53:53 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id l26so1348732fgb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 03:53:51 -0800 (PST)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <49914EE7.7030205@in.ibm.com>
References: <20090210194121.80256b72.sfr@canb.auug.org.au>
	<49914790.6050008@in.ibm.com> <49914EE7.7030205@in.ibm.com>
Date: Tue, 10 Feb 2009 13:53:51 +0200
Message-ID: <84144f020902100353x4074f342ne4d61483074a06b7@mail.gmail.com>
Subject: Re: next Feb 10: mm/slqb build break
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: npiggin@suse.de, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2009 at 11:54 AM, Sachin P. Sant <sachinp@in.ibm.com> wrote=
:
> Sachin P. Sant wrote:
>>
>> Hi Stephen,
>>
>> Todays next randconfig build on powerpc fails with
>>
>> =A0CC =A0 =A0 =A0mm/slqb.o
>> mm/slqb.c: In function __slab_free:
>> mm/slqb.c:1648: error: implicit declaration of function
>> slab_free_to_remote
>> mm/slqb.c: In function kmem_cache_open:
>> mm/slqb.c:2174: error: implicit declaration of function
>> kmem_cache_dyn_array_free
>> mm/slqb.c:2175: warning: label error_cpu_array defined but not used
>> mm/slqb.c: In function kmem_cache_destroy:
>> mm/slqb.c:2294: error: implicit declaration of function
>> claim_remote_free_list
>> mm/slqb.c: In function kmem_cache_reap_percpu:
>> mm/slqb.c:2547: error: implicit declaration of function
>> flush_remote_free_cache
>> mm/slqb.c: In function kmem_cache_init:
>> mm/slqb.c:2783: error: per_cpu__kmem_cpu_nodes undeclared (first use in
>> this function)
>> mm/slqb.c:2783: error: (Each undeclared identifier is reported only once
>> mm/slqb.c:2783: error: for each function it appears in.)
>> mm/slqb.c:2784: error: kmem_cpu_cache undeclared (first use in this
>> function)
>> make[1]: *** [mm/slqb.o] Error 1
>> make: *** [mm] Error 2
>
> CONFIG_SMP is not set hence the failure.

Actually, that's not the root cause here. You seem to have CONFIG_SMP
disabled but CONFIG_NUMA enabled. That's not possible on x86 which
makes me think it's a ppc kconfig bug. Hmm?

                                                     Pekka
