Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 295ED1A1D43
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:57:03 +1000 (AEST)
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com
 [IPv6:2607:f8b0:4001:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93B9B1402BA
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 04:57:02 +1000 (AEST)
Received: by igbij6 with SMTP id ij6so84889738igb.1
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 11:57:01 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1437646871-3195-10-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-10-git-send-email-mpe@ellerman.id.au>
Date: Mon, 27 Jul 2015 11:57:00 -0700
Message-ID: <CAGXu5jJMOGXS4wpAwxWFEH7zgLgMaW9=gxEBncV46CgqBXEMBg@mail.gmail.com>
Subject: Re: [PATCH 10/11] selftests/seccomp: Make seccomp tests work on big
 endian
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

On Thu, Jul 23, 2015 at 3:21 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> The seccomp_bpf test uses BPF_LD|BPF_W|BPF_ABS to load 32-bit values
> from seccomp_data->args. On big endian machines this will load the high
> word of the argument, which is not what the test wants.
>
> Borrow a hack from samples/seccomp/bpf-helper.h which changes the offset
> on big endian to account for this.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Kees Cook <keescook@chromium.org>

Thanks for fixing the error message! :)

-Kees

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index c5abe7fd7590..2303a8dff9a2 100644
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
> +#error "wut? Unknown __BYTE_ORDER?!"
> +#endif
>
>  #define SIBLING_EXIT_UNKILLED  0xbadbeef
>  #define SIBLING_EXIT_FAILURE   0xbadface
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
