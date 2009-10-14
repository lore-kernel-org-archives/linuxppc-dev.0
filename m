Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2653EB7063
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 07:05:18 +1100 (EST)
In-Reply-To: <4AD62516.6090301@freescale.com>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091014172003.GD21215@loki.buserror.net>
	<OF64D89B73.6073827F-ONC125764F.00687BC4-C125764F.0068D4DC@transmode.se>
	<4AD62516.6090301@freescale.com>
Subject: Re: [PATCH 4/8] 8xx: Fixup DAR from buggy dcbX instructions.
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF22DCA2B2.1ADC3BC0-ONC125764F.006DE50F-C125764F.006E305A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 14 Oct 2009 22:03:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 14/10/2009 21:23:02:
> Joakim Tjernlund wrote:
> > BTW, you could add a test and printk in do_page_fault on address 0x000000f0.
> > if that ever hits there is a problem with dcbX fixup.
>
> It doesn't get any 0xf0 faults.
>
> FWIW, I'm not seeing the segfault any more, but I still get the lockup.

Have you reverted
 8xx: start using dcbX instructions in various copy routines ?

After that you could stick a
 b DataAccess

 directly in the DTLB error handler to skip and dcbX fixups.
