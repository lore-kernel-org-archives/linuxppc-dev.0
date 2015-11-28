Return-Path: <yalin.wang2010@gmail.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC77A1A0075
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 03:40:14 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so189695844pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 08:40:12 -0800 (PST)
In-Reply-To: <1448622572-16900-6-git-send-email-pmladek@suse.com>
Subject: Re: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Date: Sat, 28 Nov 2015 22:26:34 +0800
Message-Id: <4DB68845-14E0-4B30-AF68-6B95A3E1823D@gmail.com>
To: Petr Mladek <pmladek@suse.com>
From: yalin wang <yalin.wang2010@gmail.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
Content-Type: text/html; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><head></head><body class=3D"ApplePlainTextBody" dir=3D"auto" =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;"><br><blockquote type=3D"cite">On =
Nov 27, 2015, at 19:09, Petr Mladek &lt;pmladek@suse.com&gt; =
wrote:<br><br>Testing has shown that the backtrace sometimes does not =
fit<br>into the 4kB temporary buffer that is used in NMI =
context.<br><br>The warnings are gone when I double the temporary buffer =
size.<br><br>Note that this problem existed even in the =
x86-specific<br>implementation that was added by the commit =
a9edc8809328<br>("x86/nmi: Perform a safe NMI stack trace on all =
CPUs").<br>Nobody noticed it because it did not print any =
warnings.<br><br>Signed-off-by: Petr Mladek =
&lt;pmladek@suse.com&gt;<br>---<br>kernel/printk/nmi.c | 2 +-<br>1 file =
changed, 1 insertion(+), 1 deletion(-)<br><br>diff --git =
a/kernel/printk/nmi.c b/kernel/printk/nmi.c<br>index =
8af1e4016719..6111644d5f01 100644<br>--- a/kernel/printk/nmi.c<br>+++ =
b/kernel/printk/nmi.c<br>@@ -42,7 +42,7 @@ atomic_t =
nmi_message_lost;<br>struct nmi_seq_buf {<br><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>atomic_t<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>len;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>/* length of written data */<br><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>struct irq_work<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>work;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>/* IRQ work that flushes the buffer */<br>-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>unsigned =
char<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>buffer[PAGE_SIZE - sizeof(atomic_t) -<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>unsigned =
char<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>buffer[2 * PAGE_SIZE - sizeof(atomic_t) -<br><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sizeof(struct =
irq_work)];<br>};<br><br></blockquote><br>why not define like =
this:<br><br>union {<br>struct {atomic_t<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>len;<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><br><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>struct irq_work<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>work;<br>}<br>unsigned char<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>buffer[PAGE_SIZE * 2] =
;<br>}<br><br>we can make sure the union is 2 PAGE_SIZE =
.<br><br>Thanks<br><br></body></html>=
