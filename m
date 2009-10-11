Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AC20B7B80
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 09:22:38 +1100 (EST)
In-Reply-To: <1255296330.2192.42.camel@pasglop>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-7-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255296330.2192.42.camel@pasglop>
Subject: Re: [PATCH 6/8] 8xx: Add missing Guarded setting in DTLB Error.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF67239BF2.43007548-ONC125764C.007A17D3-C125764C.007A9BE3@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 12 Oct 2009 00:19:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 11/10/2009 23:25:30:
>
> On Sun, 2009-10-11 at 18:35 +0200, Joakim Tjernlund wrote:
> > only DTLB Miss did set this bit, DTLB Error needs too otherwise
> > the setting is lost when the page becomes dirty.
>
> Easier fix: Stop doing thing in DTLB Error
>
> Ben.

I hear you, I can remove DTLB error with an add on patch later if that is OK?
I cannot remove the DARFix though, when I move that to do_page_fault(), I get
duplicate TLB hits on the same insn. It is like when transfer_to_handler()
executes rfi, the cpu restarts the the faulting insn instead of jumping
to the page fault handler, not always but often.

 Jocke
