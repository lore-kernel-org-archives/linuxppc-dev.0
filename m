Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85666DE087
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 14:14:20 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc, Makefile: Make it possible to safely
	select CONFIG_FRAME_POINTER
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <srostedt@redhat.com>
In-Reply-To: <1241565080.11379.14.camel@localhost.localdomain>
References: <20090502001329.GA11549@oksana.dev.rtsoft.ru>
	<20090502001421.GA9342@oksana.dev.rtsoft.ru>
	<68B2EF73-0FD2-41F9-966B-9A54965AFBA6@kernel.crashing.org>
	<1241316249.4243.22.camel@localhost.localdomain>
	<6A6BE346-925C-4F73-ABFA-C6110070F071@kernel.crashing.org>
	<1241530382.11379.12.camel@localhost.localdomain>
	<299D7402-29D3-4602-8F42-58FDF034DEC5@kernel.crashing.org>
	<1241565080.11379.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 May 2009 14:14:04 +1000
Message-Id: <1242620044.18075.31.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
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

On Tue, 2009-05-05 at 19:11 -0400, Steven Rostedt wrote:

> OK, so what's the status with this patch series?
> 
> I don't want to pull it in unless I have an ack from Sam, and now
> there's issues with having -fno-omit-frame-pointer. Should we add a
> patch instead that simply removes that?
> 
> If we eliminate the -fno-omit-frame-pointer, would that solve the PPC
> problem? And would it cause any other issues with other archs?

Well, the patch looks fine to me to be honest I'm not sure what the
complaint is above... 

IE. On arch that define the new HAVE_NORMAL_FRAME_POINTER (let's just
call it HAVE_IMPLIED_FRAME_POINTER then :-)  we just don't do
-fno-omit-frame-pointer and avoid triggering the bug...

Segher, what are we missing here ?

Ben.
