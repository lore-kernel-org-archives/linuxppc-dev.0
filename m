Return-Path: <jwboyer@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id 176E2DE052
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 08:04:24 +1100 (EST)
Received: by ewy13 with SMTP id 13so11060348ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 13:04:22 -0800 (PST)
Date: Thu, 8 Jan 2009 16:03:23 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: "dibacco@libero.it" <dibacco@libero.it>
Subject: Re: __pa giving strange phys address on PPC
Message-ID: <20090108210322.GC2337@yoda.jdub.homelinux.org>
References: <KD4CZC$63E26AC2C9F30D8D9F146E56F7574045@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <KD4CZC$63E26AC2C9F30D8D9F146E56F7574045@libero.it>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 09:59:36PM +0100, dibacco@libero.it wrote:
>Hi all,
>
>I'm using a linux 2.6.19 (from Denx ELDK) on a PPC MPC880. In a driver (that uses TDM channels) I have some calls to __pa to get the physical address corresponding to a virtual address. The physical address returned by __pa is higher than the maximum physical memory I have on the board. This result make my driver hang. The driver I'm trying to use was written for a 2.4 kernel and I'm wondering if I have to replace the calls to __pa with some other API/MACRO.
>
>Thank you in advance.

If you're calling it on an ioremapped address, that won't work.
Those come out of vmalloc space.

Just store the physical address somewhere if you really need it.

josh
