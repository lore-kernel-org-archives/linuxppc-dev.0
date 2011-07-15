Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68C97B6F18
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2011 04:42:47 +1000 (EST)
Date: Fri, 15 Jul 2011 13:42:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
Message-ID: <20110715134232.56373e03@schlenkerla.am.freescale.net>
In-Reply-To: <4E1FCFEF.7070702@windriver.com>
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
	<CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>
	<4E1FCFEF.7070702@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Jul 2011 13:28:15 +0800
tiejun.chen <tiejun.chen@windriver.com> wrote:

> Kumar Gala wrote:
> > I'm still very confused why we need a unique stack frame for kprobe/program exceptions on book-e devices.
> 
> Its a bug at least for Book-E.

But why only booke?  There's nothing booke-specific about the stwu
instruction.

> And if you'd like to check another topic thread,
> "[BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu' lead to system
> crash/freeze", you can know this story completely :)
> 
> This bug should not be reproduced on PPC64 with the exception prolog/endlog
> dedicated to PPC64.

What if the function you're stepping through is creating a stack frame that
is larger than the 288 bytes that get skipped?

> But I have no enough time to check other PPC32 & !BOOKE so
> I'm not sure if we should extend this modification.

Someone should.

-Scott
