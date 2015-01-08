Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-qa0-x233.google.com (mail-qa0-x233.google.com
 [IPv6:2607:f8b0:400d:c00::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D8571A1546
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 12:18:20 +1100 (AEDT)
Received: by mail-qa0-f51.google.com with SMTP id i13so5364422qae.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jan 2015 17:18:17 -0800 (PST)
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jan 2015 17:17:56 -0800
Message-ID: <CAADnVQK0oM6U6qNuBn7H-DZHTdxzYjGrP2M7dvaOrdHztRw1eQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] module: remove mod arg from module_free,
 rename module_memfree().
To: Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips <linux-mips@linux-mips.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com,
 "x86@kernel.org" <x86@kernel.org>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Alexei Starovoitov <ast@kernel.org>,
 Mikael Starvik <starvik@axis.com>, sparclinux@vger.kernel.org,
 Chris Metcalf <cmetcalf@ezchip.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, nios2-dev@lists.rocketboards.org,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Ley Foon Tan <lftan@altera.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2015 at 4:58 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
>  void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       module_free(NULL, hdr);
> +       module_memfree(hdr);
>  }
...
> -void __weak module_free(struct module *mod, void *module_region)
> +void __weak module_memfree(void *module_region)
>  {
>         vfree(module_region);
>  }

Looks obviously correct.
Acked-by: Alexei Starovoitov <ast@kernel.org>
