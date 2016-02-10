Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 198D51A039F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:50:39 +1100 (AEDT)
Message-ID: <1455069038.7576.6.camel@ellerman.id.au>
Subject: Re: [PATCH v7 06/10] ppc64 ftrace: disable profiling for some
 functions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Petr
 Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Wed, 10 Feb 2016 12:50:38 +1100
In-Reply-To: <20160204162107.65ECE692DF@newverein.lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162107.65ECE692DF@newverein.lst.de>
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

On Mon, 2016-01-25 at 16:31 +0100, Torsten Duwe wrote:

> At least POWER7/8 have MMUs that don't completely autoload;
> a normal, recoverable memory fault might pass through these functions.
> If a dynamic tracer function causes such a fault, any of these functions
> being traced with -mprofile-kernel may cause an endless recursion.

I'm not really happy with this one, still :)

At the moment I can trace these without any problems, with either ftrace or
kprobes, but obviously it was causing you some trouble. So I'd like to
understand why you were having issues when regular tracing doesn't.

If it's the case that tracing can work for these functions, but live patching
doesn't (for some reason), then maybe these should be blocked by the live
patching infrastructure rather than at the ftrace/kprobes level.

cheers
