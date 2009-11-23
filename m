Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 8B876B7B93
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 09:13:58 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 10/19] powerpc: gamecube/wii: early debugging using
	usbgecko
Date: Mon, 23 Nov 2009 22:13:44 +0000
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<200911222327.37949.arnd@arndb.de> <4B0ADE3F.1070604@yahoo.es>
In-Reply-To: <4B0ADE3F.1070604@yahoo.es>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911232213.45068.arnd@arndb.de>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 23 November 2009 19:10:55 Albert Herranz wrote:
> 
> Arnd Bergmann wrote:
> > On Sunday 22 November 2009, Albert Herranz wrote:
> >> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
> >> +setup_usbgecko_bat:
> >> +    /* prepare a BAT for early io */
> >> +    lis     r8, 0x0c00
> >> +    ori     r8, r8, 0x002a  /* uncached, guarded ,rw */
> >> +    lis     r11, 0xcc00
> >> +    ori     r11, r11, 0x3   /* 128K */
> >> +#ifdef CONFIG_WII
> >> +    oris    r8, r8, 0x0100
> >> +    oris    r11, r11, 0x0100
> >> +#endif
> >> +    mtspr   SPRN_DBAT1L, r8
> >> +    mtspr   SPRN_DBAT1U, r11
> >> +    sync
> >> +    isync
> >> +    blr
> >> +#endif
> > 
> > This will probably break other platforms if CONFIG_PPC_EARLY_DEBUG_USBGECKO
> > is set. In general, we try hard to make it possible to build generic
> > kernels for multiple systems, so it would be better to also add a runtime
> > check here.
> > 
> 
> Ok, I see the point.
> But, what makes CONFIG_PPC_EARLY_DEBUG_USBGECKO case different from CONFIG_PPC_EARLY_DEBUG_CPM case here?
> 

I looked again, and the help text for PPC_EARLY_DEBUG makes it very clear that
are never usable on a production kernel. Just leave your code the way it is here,
but if there are other places that prevent portable kernels, those should be fixed.
I'm not aware of any of those right now.

	Arnd <><
