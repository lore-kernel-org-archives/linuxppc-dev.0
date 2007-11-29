Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 87BC7DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 21:41:50 +1100 (EST)
Date: Thu, 29 Nov 2007 11:41:47 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
Message-ID: <20071129104147.GA3694@aepfle.de>
References: <20071120012815.GB7969@austin.ibm.com>
	<1196208960.11297.26.camel@farscape.rchland.ibm.com>
	<20071128110037.GB31217@aepfle.de>
	<20071128200932.GG19584@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20071128200932.GG19584@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 28, Linas Vepstas wrote:

> On Wed, Nov 28, 2007 at 12:00:37PM +0100, Olaf Hering wrote:
> > On Tue, Nov 27, Will Schmidt wrote:

> > > > -	if (panic_timeout)
> > > > -		return;
> > 
> > This change is wrong. Booting with panic=123 really means the system
> > has to reboot in 123 seconds after a panic.
> 
> And it does.

Have you ever tried it? Current state is that the JS20 hangs after
panic, simply because it calls into the hypervisor (or whatever).
To reproduce:
 mkdir ../O-os-term
 cp arch/powerpc/configs/pseries_defconfig ../O-os-term/.config
 yes '' | make -kj6 O=../O-os-term zImage
 scp -4pr ../O-os-term/arch/powerpc/boot/zImage root@tftp:/tftpboot/js20


 boot /pci@8000000f8000000/pci@0/ethernet@1,1 debug panic=1 root=/dev/sdx42


Whoever relies on the string passing to the HMC can boot with panic=0 or
use some sysctl to write to /proc/sys/kernel/panic
So, please restore the panic_timeout check.
