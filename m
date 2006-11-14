Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 38B7767F5C
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 13:56:42 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAE2uebC003316
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 11:56:40 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAE2uel5003289
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 11:56:40 +0900 (JST)
Message-ID: <45593060.10602@am.sony.com>
Date: Mon, 13 Nov 2006 18:56:32 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
References: <4554DA9C.9040102@am.sony.com>	
	<1163391081.7410.65.camel@localhost.localdomain>	
	<4557F5C5.7080604@am.sony.com>
	<1163469714.8048.54.camel@localhost.localdomain>
In-Reply-To: <1163469714.8048.54.camel@localhost.localdomain>
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
>> > Why can't your PS3 platform code fake-up device nodes for SPUs? It seems
>> > that would simplify this quite a lot.
>> 
>> 
>> Seems like a hack to me.  My concern is that I just have to keep adding some
>> extra hack for every new spu feature that comes out.  I would prefer to make
>> a proper design from the start, but if anyone can be more convincing I am
>> open to suggestions.
> 
> Well the whole thrust of the flattened-device-tree model, is that we do
> as much platform-specific hackery in a boot-loader/early-init, and
> present the hardware in as standard a way as possible to the kernel via


The thing is that the spus are visualized, so to create one takes up
HV resources, mainly HV memory.  Creating spus in the bootloader has
several problems.  One is that you could be allocating HV memory that would
never be used if the kernel is not configured for spu support, and this
is memory could be used for other HV support.  Another problem is the
management of those HV resources across kernel reloads, with kexec for
example.  If the management is split then both entities need to have
knowledge of the other, which complicates things.


> The hope is that this isolates most of the kernel from platform specific
> details, as far as is possible - there will always be some things that
> need to be abstracted out - for that we have ppc_md and a few other
> callbacks.
> 
> The priv1_ops serve that purpose, providing callbacks, and there's
> really no way around that - you can't tap the priv1 area when you're
> running under a HV - fine. But for just finding the spus it strikes me
> that it would be _nicer_, perhaps not easier :), to have your
> "enumerate_spus" populate the flat device tree early on - which would
> leave more of the spu code untouched by the hv/bare-metal issue.


And how many would you like to find? 1? 5? 400? Although there is
a current limitation in the HV implementation, these are logical
spus.  It would seem the kernel could create spus based on the need,
and thus better balance resource usage, but this is not at all how
the current spu code works though.  I don't plan to do any work on
this, but it would be nice to keep it open.

-Geoff
