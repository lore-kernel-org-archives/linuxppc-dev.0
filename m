Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E4CE367A7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 13:59:25 +1100 (EST)
Date: Tue, 15 Feb 2005 18:59:21 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050216025921.GA25838@gate.ebshome.net>
References: <c3d0340b05021518037b1758cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05021518037b1758cc@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Incomplete network configuration information when booting from
	NFS root on Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 15, 2005 at 06:03:12PM -0800, Shawn Jin wrote:
> Is anybody using linux-2.6.10 from kernel.org for testing IBM Ebony board?

Yes, with stock boot loader and great success (bootp + NFS root). I 
just use "ip=on root=/dev/nfs" and let my bootp server tell the kernel 
about all other parameters.

[snip]

> However a new problem
> occurs. When the kernel tries to mount a NFS root filesystem, it
> complains incomplete network configuration information. See the
> following message dump. Any hints to solve the problem? Thanks a lot.

[snip]

> Kernel command line: root=/dev/nfs rw
> nfsroot=192.68.0.47:/opt/eldk3.1/ppc_4xx
> ip=192.168.0.245:192.168.0.47:::::off

[snip]

> IP-Config: Incomplete network configuration information.

Did you try looking at net/ipv4/ipconfig.c? This is file responsible 
for this message.

I think there is relevant comment in ip_auto_config() function:

/*
 * If the config information is insufficient (e.g., our IP address or
 * IP address of the boot server is missing or we have multiple network
 * interfaces and no default was set), use BOOTP or RARP to get the
 * missing values.
 */

Probably your case - multiple ethernet devices (440GX has 4) and 
you haven't specified which device should be assigned IP.

--
Eugene
