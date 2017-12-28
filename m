Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z75Qx01lNzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 10:24:40 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id w127so39729231iow.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Dec 2017 15:24:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228104207.117ee0ff@gandalf.local.home>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-6-ard.biesheuvel@linaro.org>
 <20171228104207.117ee0ff@gandalf.local.home>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 28 Dec 2017 23:24:37 +0000
Message-ID: <CAKv+Gu-R6yf8C=ZgO8G5vmR+MZtFTijRg6+tH+qscT4ycy1PrQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] kernel: tracepoints: add support for relative
 references
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>,
 Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips <linux-mips@linux-mips.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 sparclinux@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28 December 2017 at 15:42, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 27 Dec 2017 08:50:30 +0000
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> To avoid the need for relocating absolute references to tracepoint
>> structures at boot time when running relocatable kernels (which may
>> take a disproportionate amount of space), add the option to emit
>> these tables as relative references instead.
>>
>
> I gave this patch a quick skim over. It appears to not modify anything
> when CONFIG_HAVE_PREL32_RELOCATIONS is not defined. I haven't
> thoroughly reviewed it or tested it. But if it doesn't break anything,
> I'm fine giving you an ack.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>

Thank you Steven.

I should mention though (as you don't appear to recall) that an
earlier version of this patch triggered an issue for you

https://marc.info/?l=linux-arch&m=150584374820168&w=2

but I have never managed to reproduce it, neither at the time nor
currently with this v6.


ard@bezzzef:~/linux-2.6$ sudo tools/testing/selftests/ftrace/ftracetest
=== Ftrace unit tests ===
[1] Basic trace file check [PASS]
[2] Basic test for tracers [PASS]
[3] Basic trace clock test [PASS]
[4] Basic event tracing check [PASS]
[5] event tracing - enable/disable with event level files [PASS]
[6] event tracing - restricts events based on pid [PASS]
[7] event tracing - enable/disable with subsystem level files [PASS]
[8] event tracing - enable/disable with top level files [PASS]
[9] ftrace - function graph filters with stack tracer [PASS]
[10] ftrace - function graph filters [PASS]
[11] ftrace - test for function event triggers [PASS]
[12] ftrace - function glob filters [PASS]
[13] ftrace - function pid filters [PASS]
[14] ftrace - function profiler with function tracing [PASS]
[15] ftrace - test reading of set_ftrace_filter [PASS]
[16] ftrace - test for function traceon/off triggers [PASS]
[17] Test creation and deletion of trace instances while setting an event [PASS]
[18] Test creation and deletion of trace instances [PASS]
[19] Kprobe dynamic event - adding and removing [PASS]
[20] Kprobe dynamic event - busy event check [PASS]
[21] Kprobe dynamic event with arguments [PASS]
[22] Kprobes event arguments with types [PASS]
[23] Kprobe event auto/manual naming [PASS]
[24] Kprobe dynamic event with function tracer [PASS]
[25] Kprobe dynamic event - probing module [PASS]
[26] Kretprobe dynamic event with arguments [PASS]
[27] Kretprobe dynamic event with maxactive [PASS]
[28] Register/unregister many kprobe events [PASS]
[29] event trigger - test event enable/disable trigger [PASS]
[30] event trigger - test trigger filter [PASS]
[31] event trigger - test histogram modifiers [PASS]
[32] event trigger - test histogram trigger [PASS]
[33] event trigger - test multiple histogram triggers [PASS]
[34] event trigger - test snapshot-trigger [PASS]
[35] event trigger - test stacktrace-trigger [PASS]
[36] event trigger - test traceon/off trigger [PASS]
[37] (instance)  Basic test for tracers [PASS]
[38] (instance)  Basic trace clock test [PASS]
[39] (instance)  event tracing - enable/disable with event level files [PASS]
[40] (instance)  event tracing - restricts events based on pid [PASS]
[41] (instance)  event tracing - enable/disable with subsystem level
files [PASS]
[42] (instance)  ftrace - test for function event triggers [PASS]
[43] (instance)  ftrace - test for function traceon/off triggers [PASS]
[44] (instance)  event trigger - test event enable/disable trigger [PASS]
[45] (instance)  event trigger - test trigger filter [PASS]
[46] (instance)  event trigger - test histogram modifiers [PASS]
[47] (instance)  event trigger - test histogram trigger [PASS]
[48] (instance)  event trigger - test multiple histogram triggers [PASS]

# of passed:  48
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0
