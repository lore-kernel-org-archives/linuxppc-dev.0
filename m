Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 606F9DDF07
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 14:58:48 +1000 (EST)
Date: Tue, 28 Apr 2009 21:50:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 5/5] proc: export more page flags in /proc/kpageflags
Message-Id: <20090428215050.67b7b4db.akpm@linux-foundation.org>
In-Reply-To: <m38wlkxe9b.fsf@pobox.com>
References: <20090428010907.912554629@intel.com>
	<20090428014920.769723618@intel.com>
	<20090428143244.4e424d36.akpm@linux-foundation.org>
	<20090429023842.GA10266@localhost> <m38wlkxe9b.fsf@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Helge,
	Seetharaman <sekharan@us.ibm.com>,
	Deller <deller@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"andi@firstfloor.org" <andi@firstfloor.org>, Chandra,
	"kosaki.motohiro@jp.fujitsu.com" <kosaki.motohiro@jp.fujitsu.com>,
	"mpm@selenic.com" <mpm@selenic.com>, Olof Johansson <olof@lixom.net>,
	Wu Fengguang <fengguang.wu@intel.com>,
	"adobriyan@gmail.com" <adobriyan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Apr 2009 23:41:52 -0500 Nathan Lynch <ntl@pobox.com> wrote:

> > CONFIG_DEBUG_KERNEL being enabled in distro kernels effectively means 
> >
> >         #ifdef CONFIG_DEBUG_KERNEL == #if 1
> >
> > as the following patch demos. Now it becomes obviously silly.
> 
> Sure, #if 1 is usually silly.  But if the point is that DEBUG_KERNEL is
> not supposed to directly affect code generation, then I see two options
> for powerpc:
> 
> - remove the #ifdef CONFIG_DEBUG_KERNEL guards from
>   arch/powerpc/kernel/sysfs.c, unconditionally enabling the hid/ima
>   sysfs attributes, or
> 
> - define a new config symbol which governs whether those attributes are
>   enabled, and make it depend on DEBUG_KERNEL

yup.
