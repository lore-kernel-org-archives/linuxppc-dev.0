Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 8C2A267CEE
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 15:34:26 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAD4YPKL006727
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:34:25 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAD4YPcs006712
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:34:25 +0900 (JST)
Message-ID: <4557F5C5.7080604@am.sony.com>
Date: Sun, 12 Nov 2006 20:34:13 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
References: <4554DA9C.9040102@am.sony.com>
	<1163391081.7410.65.camel@localhost.localdomain>
In-Reply-To: <1163391081.7410.65.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Fri, 2006-11-10 at 12:01 -0800, Geoff Levand wrote:
>> This adds a platform specific spu management abstraction and the coresponding
>> routines to support the IBM Cell Blade.  It also removes the hypervisor only
>> resources that were included in struct spu.
>> 
>> Three new platform specific routines are introduced, spu_enumerate_spus(),
>> spu_create_spu() and spu_destroy_spu().  The underlining design uses a new
>> type, struct spu_management_ops, to hold function pointers that the platform
>> setup code is expected to initialize to instances appropriate to that platform.
>> 
>> For the IBM Cell Blade support, I put the hypervisor only resources that were
>> in struct spu into a platform specific data structure struct spu_pdata.
> 
> As far as I can see you haven't posted your HV-backed management ops, is
> that right?


Yes, that is in '[PATCH 15/16] cell: add ps3 platform spu support' posted
with the other ps3pf patches.


> Why can't your PS3 platform code fake-up device nodes for SPUs? It seems
> that would simplify this quite a lot.


Seems like a hack to me.  My concern is that I just have to keep adding some
extra hack for every new spu feature that comes out.  I would prefer to make
a proper design from the start, but if anyone can be more convincing I am
open to suggestions.

-Geoff
