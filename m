Return-Path: <linuxppc-dev+bounces-27317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12092C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:34:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkdgb3nN7z2y8m;
	Tue, 15 Sep 2026 20:34:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789447995;
	cv=none; b=KgZCphBVkMtBWCKr4szUvzMT1t4hA8EiwaJm2zp6+K3CsD1i922hI1GricX2rSPrQwj5eQGm5yibznUTLgBd15sBYWAnuw9gK0oPBRMjyq6HREHEfloygOGSq1XnLOBPgP6nJYz4m0UEnblb5Mc5kEEKm2Rydb7MYjHBc5i2p7Iido0XErFk6e96H17M8gR642LCBQDD+Ww9JCt4rZeS61B56WamT+jIX/bD/lcj5x5xgN3JDb7EY0EICmuCF9j0tJzXjmAzQuWY1q9QTzdgJ6R8+B1if6D25N2SXsRHVPdORT08WJT8uiw0y89JnLgxG26z1WOiVvd9e6c0pAWWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789447995; c=relaxed/relaxed;
	bh=ru4Ea1MD4/XyVDmXcP+1ObXpaU2Tn0Ejgynjuli47y4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=YLjdb7rD7Yno1G03D5hrfDWPHdz6qcJiZ9pJu3QlPD/osX/oHw/jTLmYd0dVe3N0SLF3o/zEtSLHtV2Kx56mJunvpgblMJL8s0oO3fDDkE9yabjiFAnLBsnXrIGueu1VmZv6fPYOlPZof97/iqM/EcAkki7aytte+41mHO+A+IUA45MWdG5544PRC9VQcYUh0M7spKuRHLR90NNet0G2gcZpt12hkS1v7b5gMlyL2dSs90oGfVcYKn5qP+2pQKcd4BAhW3xZN/CFID/TjX8pKRxvO1vYFCfQ0wmlCCBpKabZ+PCf1dMWyRdnUPHCuAJgRSbD1rwiFnZO7oih575M8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bKR4atzw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bKR4atzw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkV5P1PWxz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 14:53:11 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso2869976a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 21:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789447988; x=1790052788; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ru4Ea1MD4/XyVDmXcP+1ObXpaU2Tn0Ejgynjuli47y4=;
        b=bKR4atzwC0JW3v13knqa2E5gTfQ7ICHYjV+vMAszzlq/G7oLPywwV9QAeMvLzhQuQ6
         Q47+7pr3d+xfyyvZ+yBLcP6/j7nuAw6td9C89VWLyFSZYET3VXaIlkW/80XtEBqcgZ6n
         9ctFJtzfYxNvUXgsfj4q74HHcpDD71MGU8ud8Nz7eBWDgxfZPoDMdYpUbQBN6nE2cs4h
         owUSfH1aMm7DDiQvOwH0G98ecaZMvNnjTm3ocSb0cv3waPOvHn5SB7lxcPPI8tkpEnIp
         tAJfOYKwdFQCgWiFP/R2SaXEKtn0yUlonTXphtm94A7o9IkdTsWj/Hi6eGPPqXFN1SL/
         EZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447988; x=1790052788;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ru4Ea1MD4/XyVDmXcP+1ObXpaU2Tn0Ejgynjuli47y4=;
        b=BpnmLXmSKsTtN2xgZdC1JUhlDrEBqJ4GIH/pT6UPEoll4KjXsnswJsrpZA4LYG82C+
         3xw+KxfU+ttOlm1XdB9U2GgdIBer3sTbO05LwShZWMWddFiWV0BsP1dCX9mbTFgm6lWu
         LGl9KklSqL+4gll0bGreiRy79pOnGy1BF2N/fA2srmbkZg9CrxxLhfS0yCvSdpU2WNh9
         ECd+uv/N8kXDFSv2/MKaZblkMnpuCxVK8fkqdzyckJiROWmDB5Zfkqmt9VMXsEt4VGnU
         xF9MZnmGC5qNcGW5Zd0HJGvMiDL0FHFFMzMvteq/I7l82A6VphqUKVk9xVGXxNO+XMBY
         kpoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxct55kTmPyOw2DSpuxaYyuRzgzNsq/3wZbsskg0ynZK/v4VOldnDVSSWLiu8nFVZpYkZMXx5honIdx2gE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mgBraLTSdRmBGyl+0zXQoqeR2FPru+ZIjx55yPkTzIQ9QSFZN2
	C0ldTQlrmrLqV9x44u0BanlJQ26O2pFE+wol7ItkReBtYaeqUUyh0dgY
X-Gm-Gg: AYBFou2OUTco50kN91ZiACte4cJ+CKOkIugJeftUlPzb1eNGc454CBqN88o95gtXZsv
	53l/kW+4kD2pcOSY/eE7s7FvIyjgE9F9tE5uwaNpPoMuO/1/8mQ5UOguHWvJG9nPDD0GhIiu/6Z
	qed2B32OJaGWVwPvw/hamJ1z6DBQ9YzYwxLcFcRZs8oqdRDG1PcrLsqcmrttyCUMcTtMYDbCt09
	Oy33lOIZr3Ri1r1/ZcDsOIO364inGQk8oQDrW9lzlU8KT/tGOp7cAg4FSyF7N2LbjoZ2JjvU3hU
	+rORkY2o6tzFodbc3yhGQccd2DggHDENXf9ix9vVRhjQxhpJuJjdoWiBBV1xFW1GluSBW0wKyI9
	FDdH6oFUt8VjnZ/0BLYy8LHP9i43rG0Wa70/pPuD6QofRO5A+tZIITEmKWnHAE7sxvLa3iU7sYS
	B5ayI+2JCeNnbO2YsRgkDZgGwjzuSFPg3WKpsHeVwjTqecFg5vJtZ0M1L3zMp/U0wedqYsuXEva
	3xhRwk44j44Tld/N5rJF+9f/Zg5Ir6VERO3MZ3cOS5aF7SmtynXsH8=
X-Received: by 2002:a05:6a20:c88b:b0:3d1:c0e2:936b with SMTP id adf61e73a8af0-3db404269e1mr14358079637.7.1789447987855;
        Mon, 14 Sep 2026 21:53:07 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33beb8b2872sm849937eec.15.2026.09.14.21.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:53:06 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Chris Chiu <chris.chiu@canonical.com>, maddy@linux.ibm.com, shuah@kernel.org
Cc: sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Chiu <chris.chiu@canonical.com>
Subject: Re: [PATCH] selftests/powerpc: Fix exec_prot test failure on Hash MMU
In-Reply-To: <20260909050919.3344699-1-chris.chiu@canonical.com>
Date: Tue, 15 Sep 2026 10:07:13 +0530
Message-ID: <wlsnyvt2.ritesh.list@gmail.com>
References: <20260909050919.3344699-1-chris.chiu@canonical.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Chris Chiu <chris.chiu@canonical.com> writes:

> Hash MMU maps execute-only pages as readable at the PTE level, so reading
> from a PROT_EXEC-only mapping does not fault there. The exec_prot test
> currently treats that as a failure, while the rest of the permission
> checks are still valid.
>
> Use the existing using_hash_mmu() helper and skip only the read-on-
> execute-only subtest on Hash MMU. Keep the rest of the test unchanged so
> the fix stays local to the unsupported execute-only-read expectation.
>

Hi Chris,

Thanks for the patch. However the patch is not entirely correct.
Do you mind me asking - how did you find this problem? Did you run this
on an actual Power Hardware? Can you share the details of that please?

Also - from your .config can you share the following?

cat .config |grep -iE "_PPC_"


So what you described in the commit msg is correct but only when PKEY
support is disabled with Hash mmu. However when pkey is enabled, and
when the process does mprotect(PROT_EXEC), kernel assigns a execute only
pkey for that mapping. With that - we can still get a fault when we try
to load from that PROT_EXEC mapping and the test should work fine.

So, I think what we need here is:

diff --git a/tools/testing/selftests/powerpc/mm/exec_prot.c b/tools/testing/selftests/powerpc/mm/exec_prot.c
index db75b2225de1..51ac2f9c14a6 100644
--- a/tools/testing/selftests/powerpc/mm/exec_prot.c
+++ b/tools/testing/selftests/powerpc/mm/exec_prot.c
@@ -167,13 +167,17 @@ static int test(void)
         * Read an instruction word from the address when the page
         * is execute only. This should generate an access fault.
         */
-       fault_code = -1;
-       remaining_faults = 1;
-       printf("Testing read on --x, should fault...");
-       FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) != 0);
-       i = *fault_addr;
-       FAIL_IF(remaining_faults != 0 || !is_fault_expected(fault_code));
-       printf("ok!\n");
+       if (pkeys_supported) {
+               fault_code = -1;
+               remaining_faults = 1;
+               printf("Testing read on --x, should fault...");
+               FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) != 0);
+               i = *fault_addr;
+               FAIL_IF(remaining_faults != 0 || !is_fault_expected(fault_code));
+               printf("ok!\n");
+       } else {
+               printf("Testing read on --x, skipped on Hash MMU without pkeys\n");
+       }


w/o the above diff when PKEYS are disabled on Hash
(# CONFIG_PPC_MEM_KEYS is not set) we get the following error:

test: exec_prot
tags: git_version:v7.3-rc3-9-g704340f1cd0d
[SKIP] Test skipped on line 100
[FAIL] Test FAILED on line 175
Testing read on --x, should fault...failure: exec_prot

But with the above diff:

test: exec_prot
tags: git_version:v7.3-rc3-9-g704340f1cd0d-dirty
[SKIP] Test skipped on line 100
Testing read on --x, skipped on Hash MMU without pkeys
Testing write on --x, should fault...ok!
Testing exec on ---, should fault...ok!
Testing exec on r--, should fault...ok!
Testing exec on -w-, should fault...ok!
Testing exec on rw-, should fault...ok!
Testing exec on --x, should succeed...ok!
Testing exec on r-x, should succeed...ok!
Testing exec on -wx, should succeed...ok!
Testing exec on rwx, should succeed...ok!
success: exec_prot


Care to verify this from your end on your hardware and submit a v2 with
this change?

-ritesh


> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  .../testing/selftests/powerpc/mm/exec_prot.c  | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/mm/exec_prot.c b/tools/testing/selftests/powerpc/mm/exec_prot.c
> index db75b2225de1..bd44f49d8449 100644
> --- a/tools/testing/selftests/powerpc/mm/exec_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/exec_prot.c
> @@ -108,11 +108,14 @@ static int check_exec_fault(int rights)
>  static int test(void)
>  {
>  	struct sigaction segv_act, trap_act;
> +	bool hash_mmu;
>  	int i;
>  
>  	/* Skip the test if the CPU doesn't support Radix */
>  	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
>  
> +	FAIL_IF(using_hash_mmu(&hash_mmu));
> +
>  	/* Check if pkeys are supported */
>  	pkeys_supported = pkeys_unsupported() == 0;
>  
> @@ -167,13 +170,17 @@ static int test(void)
>  	 * Read an instruction word from the address when the page
>  	 * is execute only. This should generate an access fault.
>  	 */
> -	fault_code = -1;
> -	remaining_faults = 1;
> -	printf("Testing read on --x, should fault...");
> -	FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) != 0);
> -	i = *fault_addr;
> -	FAIL_IF(remaining_faults != 0 || !is_fault_expected(fault_code));
> -	printf("ok!\n");
> +	if (!hash_mmu) {
> +		fault_code = -1;
> +		remaining_faults = 1;
> +		printf("Testing read on --x, should fault...");
> +		FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) != 0);
> +		i = *fault_addr;
> +		FAIL_IF(remaining_faults != 0 || !is_fault_expected(fault_code));
> +		printf("ok!\n");
> +	} else {
> +		printf("Testing read on --x, skipped on Hash MMU\n");
> +	}
>  
>  	/*
>  	 * Write an instruction word to the address when the page
> -- 
> 2.43.0

