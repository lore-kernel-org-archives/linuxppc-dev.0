Return-Path: <schwidefsky@de.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A79F1A0252
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 18:12:30 +1000 (AEST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Tue, 16 Jun 2015 09:12:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CD52C17D8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 09:13:28 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5G8COXd23461930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 08:12:24 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5G8CI49010146
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 02:12:23 -0600
Date: Tue, 16 Jun 2015 10:12:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: David Long <dave.long@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>,
 Anton Blanchard <anton@samba.org>, Behan Webster
 <behanw@converseincode.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke
 <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg
 Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo
 <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath
 <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon
 <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH 0/2] Consolidate redundant register/stack access code
Message-ID: <20150616101216.08a56f1a@mschwide>
In-Reply-To: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 15 Jun 2015 12:42:57 -0400
David Long <dave.long@linaro.org> wrote:

> From: "David A. Long" <dave.long@linaro.org>
> 
> Move duplicate and functionally equivalent code for accessing registers
> and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
> common kernel files.
> 
> Note: Help regression testing s390, hexagon, and sh would be appreciated.
>       Powerpc builds but I have not verified the functionality.
> 
> David A. Long (2):
>   Move the pt_regs_offset struct definition from arch to common include
>     file
>   Consolidate redundant register/stack access code

Compiles & boots on a s390 box. The code for regs_query_register_offset
and regs_query_register_name is a bit more complex for s390 compared
to the current state of things. Should be equivalent though.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
