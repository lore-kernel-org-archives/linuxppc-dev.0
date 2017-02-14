Return-Path: <bamvor.zhangjian@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMnQp69NgzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:07:30 +1100 (AEDT)
Received: from mail-it0-x229.google.com (mail-it0-x229.google.com
 [IPv6:2607:f8b0:4001:c0b::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vMnQp20L7z9s7C
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2017 14:07:30 +1100 (AEDT)
Received: by mail-it0-x229.google.com with SMTP id x75so15597288itb.0
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2017 19:07:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486630590-9410-3-git-send-email-mpe@ellerman.id.au>
References: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
 <1486630590-9410-3-git-send-email-mpe@ellerman.id.au>
From: Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>
Date: Tue, 14 Feb 2017 11:07:28 +0800
Message-ID: <CAFy1USS8b=eYyrp7k8f0_nUc8Rf4bCuCRTeYLG7CUcNOyQzeiw@mail.gmail.com>
Subject: Re: [PATCH 3/5] selftests: Fix the .S and .S -> .o rules
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
 "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>,
 lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-api <linux-api@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>

On 9 February 2017 at 16:56, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Both these rules incorrectly use $< (first prerequisite) rather than
> $^ (all prerequisites), meaning they don't work if we're using more than
> one .S file as input. Switch them to using $^.
>
> They also don't include $(CPPFLAGS) and other variables used in the
> default rules, which breaks targets that require those. Fix that by
> using the builtin $(COMPILE.S) and $(LINK.S) rules.
>
> Fixes: a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/lib.mk | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 98841c54763a..ce96d80ad64f 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -54,9 +54,9 @@ $(OUTPUT)/%:%.c
>         $(LINK.c) $^ $(LDLIBS) -o $@
>
>  $(OUTPUT)/%.o:%.S
> -       $(CC) $(ASFLAGS) -c $< -o $@
> +       $(COMPILE.S) $^ -o $@
>
>  $(OUTPUT)/%:%.S
> -       $(CC) $(ASFLAGS) $< -o $@
> +       $(LINK.S) $^ $(LDLIBS) -o $@
>
>  .PHONY: run_tests all clean install emit_tests
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
