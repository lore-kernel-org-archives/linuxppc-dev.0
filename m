Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 06C0267A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 04:35:31 +1100 (EST)
Date: Wed, 16 Feb 2005 09:35:28 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050216173528.GD989@gate.ebshome.net>
References: <c3d0340b05021518037b1758cc@mail.gmail.com>
	<20050216025921.GA25838@gate.ebshome.net>
	<c3d0340b05021608591692a460@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05021608591692a460@mail.gmail.com>
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

On Wed, Feb 16, 2005 at 08:59:02AM -0800, Shawn Jin wrote:
> > > Is anybody using linux-2.6.10 from kernel.org for testing IBM Ebony board?
> > 
> > Yes, with stock boot loader and great success (bootp + NFS root). I
> > just use "ip=on root=/dev/nfs" and let my bootp server tell the kernel
> > about all other parameters.
> 
> What's your boot loader? 

Default IBM one (OpenBIOS).

> 
> > Did you try looking at net/ipv4/ipconfig.c? This is file responsible
> > for this message.
> 
> Yes. I did find the comment you pointed and thought it might be a
> problem. But another issue I don't understand is why it cannot fetch
> MAC addresses from VPD? Without my hack the MAC addresses fetched from
> VPD are all FF:FF:FF:FF:FF:FF. The Rom Monitor can detect the
> addresses, which I guess are from VPD.

I'd suggest using standard IBM bootloader which is what Ebony comes 
with and make it work first, and only after this you should try to put 
non-standard one like u-boot. This is just common sense. If you need 
help with u-boot, there is a mail list for it. Ask quiestions there.

> 
> > /*
> > * If the config information is insufficient (e.g., our IP address or
> > * IP address of the boot server is missing or we have multiple network
> > * interfaces and no default was set), use BOOTP or RARP to get the
> > * missing values.
> > */
> > 
> > Probably your case - multiple ethernet devices (440GX has 4) and
> > you haven't specified which device should be assigned IP.
> 
> Do you know how to set a default active device?

Doh, please, spend some time and read this ipconfig.c yourself. It has 
a big comment describing format of "ip=...":

<client-ip>:<server-ip>:<gw-ip>:<netmask>:<host name>:<device>:<PROTO>

--
Eugene.
