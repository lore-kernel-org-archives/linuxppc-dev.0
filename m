Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYrBs2vDCzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 10:45:57 +1100 (AEDT)
Message-ID: <1459208757.8173.3.camel@ellerman.id.au>
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 Mar 2016 10:45:57 +1100
In-Reply-To: <2042788.6sAC9lOLzB@hactar>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <2042788.6sAC9lOLzB@hactar>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-03-28 at 17:29 -0300, Thiago Jung Bauermann wrote:

> Am Montag, 28 März 2016, 17:06:32 schrieb Thiago Jung Bauermann:

> > /home/bauermann/src/linux/tools/testing/selftests/ftrace/test.d/kprobe/kp
> > robe_ftrace.tc: line 9: echo: write error: Invalid argument
> >
> >     But even without my patch that testcase fails in the same way, so this
> > is not a problem introduced by the patch.
>
> That failure is on this line of kprobe_ftrace.tc:
>
> echo _do_fork > set_ftrace_filter
>
> This fails because on powerpc the function symbol has a dot prepended to its
> name:

Only on big endian powerpc. (Or actually ABI < ELFv2, but in practice that
means BE)

> # cat available_filter_functions | grep _do_fork
> ._do_fork
>
> If I do s/_do_fork/._do_fork/ in kprobe_ftrace.tc then all ftrace kprobe
> tests pass:
>
> $ sudo ./ftracetest test.d/kprobe/
> === Ftrace unit tests ===
> [1] Kprobe dynamic event - adding and removing  [PASS]
> [2] Kprobe dynamic event - busy event check     [PASS]
> [3] Kprobe dynamic event with arguments [PASS]
> [4] Kprobe dynamic event with function tracer   [PASS]
> [5] Kretprobe dynamic event with arguments      [PASS]

OK. We fixed that in 'perf probe', but not if you're using the sysfs file
directly.

Do you want to write a patch for ftracetest to try and handle it? I guess you'd
try "_do_fork" and if that fails then try "._do_fork", and maybe only if uname -m
says you're running on ppc64?

cheers
