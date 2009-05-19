Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 04044DE0C1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 06:03:16 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so9784ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 13:03:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090519.120514.26253637.davem@davemloft.net>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<200905191812.03347.arnd@arndb.de>
	<20090519.120514.26253637.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 14:02:55 -0600
Message-ID: <fa686aa40905191302g6c7c3b9dmedacfcd96462a23f@mail.gmail.com>
Subject: Re: Musings on PCI busses
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com,
	arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 19, 2009 at 1:05 PM, David Miller <davem@davemloft.net> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 19 May 2009 18:12:02 +0200
>
>> On Tuesday 19 May 2009, Grant Likely wrote:
>>> 1) Probe the host controller in an of_platform driver. =A0This has the
>>> advantage of simplicity. =A0The probe routine will get automatically
>>> called when the PCI host controller device tree node is registered
>>> with the of_platform bus. =A0The bus parenthood also gets reflected in
>>> the device model and sysfs. =A0The disadvantage is that it defers PCI
>>> bus probing until after the of_platform bus is probed (maybe this is
>>> okay; maybe this already happens anyway).
>>
>> This is also what we do on 64-bit systems (well, Cell at this time).
>> There are no fundamental problems with this, just some slightly
>> unexpected interactions e.g. when you have use a PCI serial port
>> as your console before probing PCI.
>
> This is also what sparc64 does :-)
>
> All of the individual sparc64 PCI controller types have a OF driver
> and then there is a common layer of OF PCI helper code to do most
> of the work.

Cool, well I have my solution then.  :-)

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
