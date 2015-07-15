Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABA6D1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 01:16:12 +1000 (AEST)
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 25B621402AE
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 01:16:12 +1000 (AEST)
Received: by igbpg9 with SMTP id pg9so38672306igb.0
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2015 08:16:10 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1436945834-26660-11-git-send-email-mpe@ellerman.id.au>
References: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
 <1436945834-26660-11-git-send-email-mpe@ellerman.id.au>
Date: Wed, 15 Jul 2015 08:16:10 -0700
Message-ID: <CAGXu5j+CNxPSzA83UJDEdr_0G14qqX4yNdhr5+2YrisE8O6eeg@mail.gmail.com>
Subject: Re: [RFC PATCH 11/12] selftests/seccomp: Make seccomp tests work on
 big endian
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 strosake@linux.vnet.ibm.com, bogdan.purcareata@freescale.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 15, 2015 at 12:37 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> The seccomp_bpf test uses BPF_LD|BPF_W|BPF_ABS to load 32-bit values
> from seccomp_data->args. On big endian machines this will load the high
> word of the argument, which is not what the test wants.
>
> Borrow a hack from samples/seccomp/bpf-helper.h which changes the offset
> on big endian to account for this.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index b2374c131340..51adb9afb511 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -82,7 +82,13 @@ struct seccomp_data {
>  };
>  #endif
>
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
>  #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
> +#elif __BYTE_ORDER == __BIG_ENDIAN
> +#define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]) + sizeof(__u32))
> +#else
> +#error "wut?"
> +#endif

Ah-ha! Yes, thanks. Could you change the #error to something that
describes the particular (impossible) failure condition? "wut? Unknown
__BYTE_ORDER?!". Not a huge deal, but I always like verbose errors. :)
Especially for "impossible" situations. :)

-Kees

>
>  #define SIBLING_EXIT_UNKILLED  0xbadbeef
>  #define SIBLING_EXIT_FAILURE   0xbadface
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
