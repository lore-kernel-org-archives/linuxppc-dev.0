Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5ECAFDE2A3
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 01:54:21 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m3MFsHCn264232
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 15:54:17 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3MFsHT81880140
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 16:54:17 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3MFsGaX027851
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 15:54:17 GMT
Message-ID: <480E0A54.9010203@linux.vnet.ibm.com>
Date: Tue, 22 Apr 2008 17:55:00 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits resources on 32 bits archs
References: <20080422012723.BA9F2DE13F@ozlabs.org>
In-Reply-To: <20080422012723.BA9F2DE13F@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Hollis Blanchard <hollisb@us.ibm.com>, adaplas@gmail.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> This fixes radeonfb to not truncate 64 bits resources on 32 bits
> platforms. Unfortunately, there are still issues with addresses
> returned to userspace via struct fb_fix_screeninfo. This will
> have to be dealt with separately.

Thanks for this patch Benjamin, I use it together with what we have discussed in the "pci issue - wrong detection of pci ressources" thread.
Unfortunately I now hit exactly that issue with fb_fix_screeninfo you describe.

For everyone the fb_fix_screeninfo has two "unsigned long" vars that need to strore a IO address.
This fails in my case with a 32bit powerpc system (=sizeof(long)=4) which has paddr >4Gb and actually it should affect any 32bit platform with paddr>4Gb.
You see it e.g. when you try to initialize X11, the x11 radeon driver issues a FBIOGET_FSCREENINFO ioctl and because our address is >4Gb it get's clobbered by that unsigned long in the fb_fix_screeninfo structure (the value comes from a resource_size_t variable which has the correct 64bit).

struct fb_fix_screeninfo {
        char id[16];                    /* identification string eg "TT Builtin" */
        unsigned long smem_start;     /* Start of frame buffer mem */
[...]
        unsigned long mmio_start;     /* Start of Memory Mapped I/O   */
[...]

I tried the stupid solution to just change the fb_fix_screeninfo structure to resource_size_t, but that changes the size ioctl transports and would require awareness in the userspace applications using that ioctl.
The X11 & Framebuffer driver work on 64bit systems, so I think it's just an issue of not cutting that data down to 32bit when transporting it (has anyone already checked the x11 drivers, I hope they don't use unsigned long too).

I wanted to ask if there are any known workarounds atm that would allow me to use my X11 for now?

-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
