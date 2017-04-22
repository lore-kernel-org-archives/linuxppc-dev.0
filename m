Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w91fT6CrRzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 15:40:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <shuahkh@osg.samsung.com>, shuah@kernel.org,
 bamvor.zhangjian@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
 dvhart@infradead.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, viro@zeniv.linux.org.uk,
 emilio.lopez@collabora.co.uk, mingo@kernel.org, luto@kernel.org,
 dave.hansen@linux.intel.com, dsafonov@virtuozzo.com, rkrcmar@redhat.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/8] selftests: splice: override clean in lib.mk to fix
 warnings
In-Reply-To: <18f3784fe7bf463595f7261fb4e8e9fd6548b0d5.1492815938.git.shuahkh@osg.samsung.com>
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <18f3784fe7bf463595f7261fb4e8e9fd6548b0d5.1492815938.git.shuahkh@osg.samsung.com>
Date: Sat, 22 Apr 2017 15:40:32 +1000
Message-ID: <87tw5hyp7z.fsf@concordia.ellerman.id.au>
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

Shuah Khan <shuahkh@osg.samsung.com> writes:

> Add override for lib.mk clean to fix the following warnings from clean
> target run.
>
> Makefile:8: warning: overriding recipe for target 'clean'
> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  tools/testing/selftests/splice/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/splice/Makefile b/tools/testing/selftests/splice/Makefile
> index 559512c..3f967ba 100644
> --- a/tools/testing/selftests/splice/Makefile
> +++ b/tools/testing/selftests/splice/Makefile
> @@ -4,5 +4,6 @@ all: $(TEST_PROGS) $(EXTRA)
>  
>  include ../lib.mk
>  
> -clean:
> +override define CLEAN
>  	rm -fr $(EXTRA)
> +endef

Could just be:

EXTRA_CLEAN := $(EXTRA)

cheers
