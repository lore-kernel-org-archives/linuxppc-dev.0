Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-res-R.bigfish.com (outbound-res.frontbridge.com
	[63.161.60.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 543A967B42
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 05:30:16 +1000 (EST)
Message-ID: <449845B8.6090401@am.sony.com>
Date: Tue, 20 Jun 2006 12:00:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [Cbe-oss-dev] [patch 01/20] cell: add RAS support
References: <20060620175007.GE4845@pb15.lixom.net>
In-Reply-To: <20060620175007.GE4845@pb15.lixom.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Tue, Jun 20, 2006 at 06:26:53PM +0200, Arnd Bergmann wrote:
>> On Tuesday 20 June 2006 17:43, Olof Johansson wrote:
>> > 
>> > > This is a first version of support for the Cell BE "Reliability,
>> > > Availability and Serviceability" features.
>> > 
>> > Does it really make sense to do this under a config option? I don't
> see
>> > why anyone would not want to know that their machine is about to
> melt.
>> > 
>> You can only have that when running on bare metal. Machines that run
>> on a hypervisor can't run that code.
> 
> Well, it's harmless to build it in even on hypervisor systems, right?


Harmless if you have a lot of RAM...


>> It probably makes sense to auto-select that option for
> CONFIG_CELL_BLADE
>> though.
> 
> Sounds like a reasonable trade-off.


If its always built in, then I guess we don't need the conditionals
in cell/setup.c:

+#ifdef CONFIG_CBE_RAS
+	cbe_ras_init();
+#endif


-Geoff
