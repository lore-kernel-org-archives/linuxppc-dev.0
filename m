Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBVzr5w4PzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 01:45:43 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Shuah Khan' <shuahkh@osg.samsung.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "bamvor.zhangjian@linaro.org"
 <bamvor.zhangjian@linaro.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "dvhart@infradead.org"
 <dvhart@infradead.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "dsafonov@virtuozzo.com"
 <dsafonov@virtuozzo.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "emilio.lopez@collabora.co.uk"
 <emilio.lopez@collabora.co.uk>, "linux-gpio@vger.kernel.org"
 <linux-gpio@vger.kernel.org>, "viro@zeniv.linux.org.uk"
 <viro@zeniv.linux.org.uk>, "luto@kernel.org" <luto@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mingo@kernel.org" <mingo@kernel.org>
Subject: RE: [PATCH 2/8] selftests: lib.mk: define CLEAN macro to allow
 Makefiles to override clean
Date: Mon, 24 Apr 2017 15:45:26 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFD98E2@AcuExch.aculab.com>
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <b39e21f8c47318d82be999aae310bdf6bcfc9bb9.1492815938.git.shuahkh@osg.samsung.com>
In-Reply-To: <b39e21f8c47318d82be999aae310bdf6bcfc9bb9.1492815938.git.shuahkh@osg.samsung.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shuah Khan
> Sent: 22 April 2017 00:15
> Define CLEAN macro to allow Makefiles to override common clean target
> in lib.mk. This will help fix the following failures:
>=20
> warning: overriding recipe for target 'clean'
> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>=20
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  tools/testing/selftests/lib.mk | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib=
.mk
> index 775c589..959273c 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -51,8 +51,12 @@ endef
>  emit_tests:
>  	$(EMIT_TESTS)
>=20
> -clean:
> +define CLEAN
>  	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)=
 $(EXTRA_CLEAN)
> +endef
> +
> +clean:
> +	$(CLEAN)

If might be easier to do something like:

ifneq($(NO_CLEAN),y)
clean:
	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(=
EXTRA_CLEAN)
endif

	David
