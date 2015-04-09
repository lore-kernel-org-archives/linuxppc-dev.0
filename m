Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0113.hostedemail.com
 [216.40.44.113])
 by lists.ozlabs.org (Postfix) with ESMTP id 023BE1A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 00:01:01 +1000 (AEST)
Date: Thu, 9 Apr 2015 10:00:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] jump_label: Allow asm/jump_label.h to be included
 in assembly
Message-ID: <20150409100055.00c3834e@gandalf.local.home>
In-Reply-To: <1428551492-21977-1-git-send-email-anton@samba.org>
References: <1428551492-21977-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: peterz@infradead.org, heiko.carstens@de.ibm.com, paulus@samba.org,
 hpa@zytor.com, mingo@kernel.org, linux@arm.linux.org.uk, mingo@redhat.com,
 mgorman@suse.de, catalin.marinas@arm.com, liuj97@gmail.com,
 linux-kbuild@vger.kernel.org, will.deacon@arm.com, jbaron@akamai.com,
 tglx@linutronix.de, mmarek@suse.cz, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  9 Apr 2015 13:51:30 +1000
Anton Blanchard <anton@samba.org> wrote:

> Wrap asm/jump_label.h for all archs with #ifndef __ASSEMBLY__.
> Since these are kernel only headers, we don't need #ifdef __KERNEL__
> so can simplify things a bit.
> 
> If an architecture wants to use jump labels in assembly, it
> will still need to define a macro to create the __jump_table
> entries (see ARCH_STATIC_BRANCH in the powerpc asm/jump_label.h
> for an example).
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/arm/include/asm/jump_label.h   | 5 ++---
>  arch/arm64/include/asm/jump_label.h | 8 ++++----
>  arch/mips/include/asm/jump_label.h  | 7 +++----
>  arch/s390/include/asm/jump_label.h  | 3 +++
>  arch/sparc/include/asm/jump_label.h | 5 ++---
>  arch/x86/include/asm/jump_label.h   | 5 ++---
>  6 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
