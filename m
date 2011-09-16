Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C308B6F8B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Sep 2011 04:36:56 +1000 (EST)
Message-ID: <4E739741.3050202@freescale.com>
Date: Fri, 16 Sep 2011 13:36:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/e5500: Set r5 to point to cpu spec
	in	setup_cpu_e5500()
References: <1316187462-21074-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1316187462-21074-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2011 10:37 AM, Kumar Gala wrote:
> From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> 
> e500mc and e5500 share some eary setup code that need r5 to point to the
> cpu spec structure.  setup_cpu_e500mc() sets it but setup_cpu_e5500()
> didn't.
> 
> This caused a crash on 32 bit e5500 running under hypervisor, when
> __setup_e500mc_ivors() tried to access the cpu features field.
> 
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Unless I missed something going in recently, there's nothing in the
mainline kernel that uses r5 in __setup_e500mc_ivors().  This is a fix
for code that is currently just in our SDK, and should be combined with
that code when it is posted.  The interprocedural register allocation
could stand to be done more simply as well (why not just pick a
different register for lr, and leave r4 where it is?), and should be
documented.

-Scott
