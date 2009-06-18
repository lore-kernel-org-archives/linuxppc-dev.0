Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by bilbo.ozlabs.org (Postfix) with ESMTP id B27D5B72A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 00:23:00 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
Date: Thu, 18 Jun 2009 16:22:18 +0200
References: <adf502e7c85161d77fdcaca24f55ba6b418c7f04.1244616523.git.michael@ellerman.id.au>
	<1245052241.7705.78.camel@concordia>
	<ed82fe3e0906150754w125c6283q2468213b59c7f114@mail.gmail.com>
In-Reply-To: <ed82fe3e0906150754w125c6283q2468213b59c7f114@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906181622.18349.arnd@arndb.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 15 June 2009, Timur Tabi wrote:
> On Mon, Jun 15, 2009 at 2:50 AM, Michael Ellerman<michael@ellerman.id.au> wrote:
> > arch/powerpc/platforms/chrp/setup.c:378: error: the frame size of 1040 bytes is larger than 1024 bytes
> 
> What's so bad about a frame size larger than 1024?
> 

It's not necessarily a bug, but all frame sizes in the call chain
combined must never exceed the kernel stack size. 1024 is an
arbitrary limit that we warn about for a single function, because
it's likely that things will break if you have more than one of these.

	Arnd <><
