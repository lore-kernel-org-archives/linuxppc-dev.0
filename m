Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED82BDDF4E
	for <linuxppc-dev@ozlabs.org>; Sun,  3 May 2009 05:42:55 +1000 (EST)
In-Reply-To: <20090502001421.GA9342@oksana.dev.rtsoft.ru>
References: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
	<20090502001421.GA9342@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <68B2EF73-0FD2-41F9-966B-9A54965AFBA6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc,
	Makefile: Make it possible to safely select CONFIG_FRAME_POINTER
Date: Sat, 2 May 2009 21:48:08 +0200
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch introduces HAVE_NORMAL_FRAME_POINTER Kconfig symbol. When
> defined, the top level Makefile won't add -fno-omit-frame-pointer
> cflag (the flag is useless for PowerPC kernels, and also makes gcc
> generate wrong code).

> +++ b/arch/powerpc/Kconfig

> +	select HAVE_NORMAL_FRAME_POINTER

> +config HAVE_NORMAL_FRAME_POINTER
> +	bool
> +	help
> +	  Architectures should select this symbol if their ABI implies
> +	  having a frame pointer.

I am totally confused what you call a frame pointer here.
None of the relevant PowerPC ABIs have a frame pointer
separate from the stack pointer; the compiler can create
one, of course.  A better config symbol name and help text
would help understand this patch :-)


Segher
