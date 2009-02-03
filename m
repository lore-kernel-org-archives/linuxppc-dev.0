Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 5EE58DDF66
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 03:32:52 +1100 (EST)
Subject: Re: [PATCH v2] ftrace: On PowerPC we don't need frame pointers for
	CALLER_ADDRs
From: Steven Rostedt <srostedt@redhat.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090203161955.GA776@oksana.dev.rtsoft.ru>
References: <20090131190650.GA4284@oksana.dev.rtsoft.ru>
	<1233534919.18767.69.camel@pasglop>
	<1233583455.16878.3.camel@localhost.localdomain>
	<20090203145649.GA19955@oksana.dev.rtsoft.ru>
	<20090203160645.GA9020@elte.hu>
	<20090203161955.GA776@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 03 Feb 2009 11:32:18 -0500
Message-Id: <1233678738.16878.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2009-02-03 at 19:19 +0300, Anton Vorontsov wrote:
> On Tue, Feb 03, 2009 at 05:06:45PM +0100, Ingo Molnar wrote:

> [1] Btw, why exactly do we need the -fno-omit-frame-pointer for
> "FUNCTION_TRCER" tracer? Why just -pg isn't sufficient?..
> 

The problem is this that is in the toplevel Makefile:


ifdef CONFIG_FRAME_POINTER
KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
else
KBUILD_CFLAGS	+= -fomit-frame-pointer
endif


-pg is incompatible with -fomit-frame-pointer

-- Steve
