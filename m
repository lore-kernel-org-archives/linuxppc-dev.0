Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C29F1B6F86
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 01:00:51 +1100 (EST)
In-Reply-To: <A1820550-38CB-445E-B7EB-7D0077673686@digitaldans.com>
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <39B024CE-70A2-4D32-A29C-5702C7D2D6CF@digitaldans.com>
 <OFAF68F93F.57D058F1-ONC1257925.005B7C6F-C1257925.005C10D7@transmode.se>
 <9CE82FAD-2451-4253-B304-CF8BE5AC8CAC@digitaldans.com>
 <OF5A487DD5.BE515A85-ONC1257926.0029F008-C1257926.002A6323@LocalDomain>
 <OF76F1F5B7.8750C8C4-ONC1257927.00767D9A-C1257927.0076B5BE@transmode.se>
 <A1820550-38CB-445E-B7EB-7D0077673686@digitaldans.com>
Subject: Re: [PATCH 0/3] 8xx: Large page(8MB) support for 2.4
To: Dan Malek <ppc6dev@digitaldans.com>
Message-ID: <OFF1B869AD.14EDDF6F-ONC1257928.004AA88D-C1257928.004CF976@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 13 Oct 2011 16:00:45 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Malek <ppc6dev@digitaldans.com> wrote on 2011/10/13 03:08:12:
>
>
> Hi Joakim.
>
> On Oct 12, 2011, at 2:36 PM, Joakim Tjernlund wrote:
>
> > Dan, where did you go? I figured you would throw yourself at this as
> > this is
> > something you been meaning to do yourself for years :)
>
> Too many things to do :-)  I did have the wired page version that I've
> been using now and then.

ehhm, do the fun stuff first? :)

>
> I had the bad thought yesterday that we need to check the
> implementation for coherent memory.  It appears we set the
> pages non-cached, which could cause some trouble.  We
> have to ensure we never access the same physical page
> with different attributes from the 8M mapping and the single
> page "coherent" mapping.
>
> I'll try to get some testing done.

In 2.4 this seems fine:
#ifdef CONFIG_PIN_TLB
#define VMALLOC_OFFSET (0x2000000) /* 32M */
#else
#define VMALLOC_OFFSET (0x1000000) /* 16M */
#endif
...
	/* adjust vmalloc_start */
	vmalloc_start = (vmalloc_start + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1);

Earlier you have
MMU_init(void)
{
....
	vmalloc_start = KERNELBASE + total_lowmem;

You could add 8MB to that just to be sure. In my system there is no consistent_alloc so
early though.

 Jocke

BTW, I noted that you can remove the
	ori	r11, r11, 1	/* Set valid bit in physical L2 page */
insns in the TLB routines in 3.0, the valid bit is now set be the mm system.

 Jocke
