Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w91g311RhzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 15:41:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <shuahkh@osg.samsung.com>, shuah@kernel.org,
 bamvor.zhangjian@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
 dvhart@infradead.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, viro@zeniv.linux.org.uk,
 emilio.lopez@collabora.co.uk, mingo@kernel.org, luto@kernel.org,
 dave.hansen@linux.intel.com, dsafonov@virtuozzo.com, rkrcmar@redhat.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/8] selftests: sync: override clean in lib.mk to fix
 warnings
In-Reply-To: <dc66a97137df1b6a913463775466a96e0f3c13db.1492815938.git.shuahkh@osg.samsung.com>
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <dc66a97137df1b6a913463775466a96e0f3c13db.1492815938.git.shuahkh@osg.samsung.com>
Date: Sat, 22 Apr 2017 15:41:02 +1000
Message-ID: <87r30lyp75.fsf@concordia.ellerman.id.au>
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
> Makefile:24: warning: overriding recipe for target 'clean'
> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  tools/testing/selftests/sync/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/sync/Makefile b/tools/testing/selftests/sync/Makefile
> index 87ac400..f7d250d 100644
> --- a/tools/testing/selftests/sync/Makefile
> +++ b/tools/testing/selftests/sync/Makefile
> @@ -20,5 +20,6 @@ TESTS += sync_stress_merge.o
>  
>  sync_test: $(OBJS) $(TESTS)
>  
> -clean:
> +override define CLEAN
>  	$(RM) sync_test $(OBJS) $(TESTS)
> +endef

EXTRA_CLEAN := sync_test $(OBJS) $(TESTS)

cheers
