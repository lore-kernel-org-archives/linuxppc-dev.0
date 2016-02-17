Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x236.google.com (mail-wm0-x236.google.com
 [IPv6:2a00:1450:400c:c09::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCCCD1A0331
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 20:45:17 +1100 (AEDT)
Received: by mail-wm0-x236.google.com with SMTP id b205so147386530wmb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 01:45:17 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 17 Feb 2016 10:45:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Long <dave.long@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>,
 Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>,
 David Hildenbrand <dahi@linux.vnet.ibm.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Rashmica Gupta <rashmicy@gmail.com>, Rich Felker <dalias@libc.org>,
 Richard Kuo <rkuo@codeaurora.org>, Roland McGrath <roland@hack.frob.com>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] Consolidate redundant register/stack access code
Message-ID: <20160217094510.GA27144@gmail.com>
References: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
 <1455010600.13384.3.camel@ellerman.id.au>
 <20160209094526.GB25268@gmail.com> <56BA5226.3090105@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56BA5226.3090105@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* David Long <dave.long@linaro.org> wrote:

> On 02/09/2016 04:45 AM, Ingo Molnar wrote:
> >
> >* Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> >>On Tue, 2016-02-09 at 00:38 -0500, David Long wrote:
> >>
> >>>From: "David A. Long" <dave.long@linaro.org>
> >>>
> >>>Move duplicate and functionally equivalent code for accessing registers
> >>>and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
> >>>common kernel files.
> >>>
> >>>I'm sending this out again (with updated distribution list) because v2
> >>>just never got pulled in, even though I don't think there were any
> >>>outstanding issues.
> >>
> >>A big cross arch patch like this would often get taken by Andrew Morton, but
> >>AFAICS you didn't CC him - so I just added him, perhaps he'll pick it up for
> >>us :D
> >
> >The other problem is that the second patch is commingling changes to 6 separate
> >architectures:
> >
> >  16 files changed, 106 insertions(+), 343 deletions(-)
> >
> >that should probably be 6 separate patches. Easier to review, easier to bisect to,
> >easier to revert, etc.
> >
> >Thanks,
> >
> >	Ingo
> >
> 
> I see your point but I'm not sure it could have been broken into separate 
> successive patches that would each build for all architectures.

Why? AFAICS all the functionality appears to be conditional on 
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API, so it ought to build standalone as well, on 
a per arch basis, as long as the core kernel patch is applied first.

Thanks,

	Ingo
