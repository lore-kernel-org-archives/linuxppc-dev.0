Return-Path: <timur.tabi@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id BAADEB7D18
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 04:29:42 +1000 (EST)
Received: by pxi18 with SMTP id 18so293951pxi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 11:29:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100430190051.3a5ba058@wker>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
	<20100430121947.1d265ca6@wker>
	<x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
	<20100430190051.3a5ba058@wker>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Fri, 30 Apr 2010 13:29:11 -0500
Message-ID: <z2ted82fe3e1004301129n32547099ndf536010d18ee4ec@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	John Rigby <jrigby@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 30, 2010 at 12:00 PM, Anatolij Gustschin <agust@denx.de> wrote:

> Thanks. Sorry for my wrong answer above, now I remember the logic
> behind this and will try to explain. Actually the reason I do not
> use kmalloc() here is that I do not want to _copy_ bitmap data to
> newly allocated frame buffer area (It will negatively affect boot
> time). Instead I reserve the already configured frame buffer area
> so that it won't be destroyed. The starting address of the area
> to reserve and also the lenght is passed to reserve_bootmem().
> This is the real reason for using reserve_bootmem() here.
> I could alloc new bitmap area using allocators, but then I have
> to copy the bitmap data (splash image) to newly allocated area
> and have to re-configure the descriptors to display from new
> bitmap buffer.

Ok, I understand.  Please add this comment to the code, so that no one
else will wonder what you're doing.

-- 
Timur Tabi
Linux kernel developer at Freescale
