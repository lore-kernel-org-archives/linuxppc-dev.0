Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.203])
	by ozlabs.org (Postfix) with ESMTP id 4407767A77
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 03:59:06 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 40so136374rnz
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 08:59:02 -0800 (PST)
Message-ID: <c3d0340b05021608591692a460@mail.gmail.com>
Date: Wed, 16 Feb 2005 08:59:02 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050216025921.GA25838@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <c3d0340b05021518037b1758cc@mail.gmail.com>
	<20050216025921.GA25838@gate.ebshome.net>
Subject: Re: Incomplete network configuration information when booting from
	NFS root on Ebony
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Is anybody using linux-2.6.10 from kernel.org for testing IBM Ebony board?
> 
> Yes, with stock boot loader and great success (bootp + NFS root). I
> just use "ip=on root=/dev/nfs" and let my bootp server tell the kernel
> about all other parameters.

What's your boot loader? I should ask if anybody has successful story
on using uboot to boot 2.6.10 to test Ebony board.

> Did you try looking at net/ipv4/ipconfig.c? This is file responsible
> for this message.

Yes. I did find the comment you pointed and thought it might be a
problem. But another issue I don't understand is why it cannot fetch
MAC addresses from VPD? Without my hack the MAC addresses fetched from
VPD are all FF:FF:FF:FF:FF:FF. The Rom Monitor can detect the
addresses, which I guess are from VPD.

> /*
> * If the config information is insufficient (e.g., our IP address or
> * IP address of the boot server is missing or we have multiple network
> * interfaces and no default was set), use BOOTP or RARP to get the
> * missing values.
> */
> 
> Probably your case - multiple ethernet devices (440GX has 4) and
> you haven't specified which device should be assigned IP.

Do you know how to set a default active device?

Thanks,
-Shawn.
