Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (news.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 84A8F67A89
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 03:48:00 +1100 (EST)
Date: Fri, 28 Jan 2005 17:47:56 +0100
From: Olaf Hering <olh@suse.de>
To: dtor_core@ameritech.net
Message-ID: <20050128164756.GA2154@suse.de>
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
	<d120d50005012806435a17fe98@mail.gmail.com>
	<20050128145511.GA29340@suse.de>
	<d120d500050128072268a5c2f0@mail.gmail.com>
	<20050128161746.GA1092@suse.de>
	<d120d500050128084345bb1abd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <d120d500050128084345bb1abd@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Jan 28, Dmitry Torokhov wrote:

> > i8042_write_data(56) swapper(1):c0,j4294674787 enter 96
> > i8042_write_data(58) swapper(1):c0,j4294674787 leave 96
> 
> So this trace is without printk but with udelay, right? This time
> keyboard does not hang but NAKs everything instead... What if you aso
> add udelay(20) after calls to i8042_write_data()?

Its with 2 printk in i8042_write_data(), just adding a printk after outb
in i8042_write_data fixes the hang.

> > md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
> > NET: Registered protocol family 2
> > .. here it hangs again.
> 
> Do you know where exactly? Is it some IO port access again?

Havent debugged that one, yet. Hopefully a different issue. According to
the logs from 2.6.5, the next message would be 

NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
