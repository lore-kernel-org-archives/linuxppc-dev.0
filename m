Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 783A767D4E
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:05:19 +1100 (EST)
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id kAD25HmD006049
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 11:05:17 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail7.sony.co.jp (R8/Sony) with SMTP id kAD25G0l006029
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 11:05:16 +0900 (JST)
Message-ID: <4557D2D2.20004@am.sony.com>
Date: Sun, 12 Nov 2006 18:05:06 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 13/16] powerpc: add ps3 platform lpar addressing
References: <4554DB14.3070900@am.sony.com> <20061111112847.GD24288@lst.de>	
	<1163292316.4982.240.camel@localhost.localdomain>
	<1163378514.7410.16.camel@localhost.localdomain>
In-Reply-To: <1163378514.7410.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Sun, 2006-11-12 at 11:45 +1100, Benjamin Herrenschmidt wrote:
>> On Sat, 2006-11-11 at 12:28 +0100, Christoph Hellwig wrote:
>> > On Fri, Nov 10, 2006 at 12:03:32PM -0800, Geoff Levand wrote:
>> > > Adds some needed bits for a config option PS3PF_USE_LPAR_ADDR that disables
>> > > the ps3pf lpar address translation mechanism.  This is a currently needed
>> > > workaround for limitations in the design of the spu support.
>> > 
>> > So make the code do the sane thing and don't put the config in the
>> > kernel tree.
>> 
>> Well... I'd like to keep the option for a little while.
>> 
>> There are performances issues with sparsemem the way it's used by
>> ps3pf.. the problem is that the memory map looks like you get a bunch of
>> memory at 0 (the RMO, not sure exactly how much in practice) and the
>> rest in a chunk all the way up the 48 bits or so max physical space.
>> 
>> So sparsemem ends up with an enormous mapping only populated at the very
>> beginning and the very end.
>> 
>> Thus, I'd like Geoff to keep the option of doing the manual translation
>> in the hash code for now until I finally get some HW and thus can do
>> some measurements, and possibly figure out a nicer way to deal with
>> that.
> 
> I haven't read the ps3 code very carefully, but at first glance it
> struck me that it has a similar problem to iSeries. It might be worth
> seeing if the iSeries mschunks_map gunk can help (see
> include/asm-powerpc/abs_addr.h)

Yes, it is essentially the same as iSeries, but since the current spu
code sets up the spu local stores as chunks of sparse memory, I still
need this for those.  To fix it properly the spu code needs to be re-worked,
and Ben said he plans to do some work there.  At that time I will reconsider
how to manage the mem regions.

As Christoph says though, this doesn't really need to be exposed as a config
option, but I wanted to include it for anyone that wanted to experiment with
it.  If you don't use spus you can save about 256KB with this option.

-Geoff
