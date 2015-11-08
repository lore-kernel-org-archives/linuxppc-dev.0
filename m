Return-Path: <luto@amacapital.net>
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com
 [IPv6:2607:f8b0:4003:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B0811A0C0B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2015 16:09:50 +1100 (AEDT)
Received: by oiad129 with SMTP id d129so85177165oia.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2015 21:09:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Nov 2015 21:09:27 -0800
Message-ID: <CALCETrWKK_REdX7TJO8X7jC=8k=YdgJH_txXpC4Pdzn-tukg5A@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Fix handling of compat_siginfo_t
To: "Amanieu d'Antras" <amanieu@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 sparclinux@vger.kernel.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, Kenton Varda <kenton@sandstorm.io>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 4, 2015 at 4:50 PM, Amanieu d'Antras <amanieu@gmail.com> wrote:
> One issue that isn't resolved in this series is sending signals between a 32-bit
> process and 64-bit process. Sending a si_int will work correctly, but a si_ptr
> value will likely get corrupted due to the different layouts of the 32-bit and
> 64-bit siginfo_t structures.

This is so screwed up it's not even funny.

A 64-bit big-endian compat calls rt_sigqueueinfo.  It passes in (among
other things) a sigval_t.  The kernel can choose to interpret it as a
pointer (call it p) or an integer (call it i).  Then (unsigned long)p
= (i<<32) | [something].  If the number was an integer to begin with
*and* user code zeroed out the mess first, then [something] will be 0.
Regardless, p != i unless they're both zero.

If the result gets delivered to a signalfd, then it's plausible that
everything could work.  If it gets delivered to a 64-bit siginfo, then
all is well because it's in exactly the same screwed up state it was
in when the signal gets sent.

If, however, it's delivered to a compat task, wtf is the kernel
supposed to do?  We're effectively supposed to convert a 64-bit
sigval_t to a 32-bit sigval_t.  On a little-endian architecture, we
can fudge it because it doesn't really matter whether we consider the
pointer or the int to be authoritative.  I think that, on big-endian,
we're screwed.

BTW, x86 has its own set of screwups here.  Somehow cr2 and error_code
ended up as part of ucontext instead of siginfo, which makes
absolutely no sense to me and bloats task_struct.

--Andy
