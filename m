Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 88CC367BDC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:31:10 +1100 (EST)
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id kAH1V8mD013004
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 10:31:08 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail7.sony.co.jp (R8/Sony) with SMTP id kAH1V80l012982
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 10:31:08 +0900 (JST)
Message-ID: <455D10D5.9010105@am.sony.com>
Date: Thu, 16 Nov 2006 17:31:01 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com> <20061115180440.GB18856@lst.de>	
	<455BC1E1.2010300@am.sony.com>
	<1163643181.8805.19.camel@localhost.localdomain>
In-Reply-To: <1163643181.8805.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Wed, 2006-11-15 at 17:41 -0800, Geoff Levand wrote:
>> Christoph Hellwig wrote:
> 
>> >> +#if !defined(PPC_MSG_MIGRATE_TASK)
>> >> +static const int PPC_MSG_MIGRATE_TASK = 2;
>> >> +#endif
>> > 
>> > This looks rather odd, what is it trying to do?
>> 
>> 
>> For some reason the definition of PPC_MSG_MIGRATE_TASK is sometimes 2, and
>> sometimes not defined, depending on other config options.  It makes the code
>> much simpler if it is always defined as 2.  Maybe it makes more sense if I
>> change it to this:
>> 
>> #if !defined(PPC_MSG_MIGRATE_TASK)
>> #define PPC_MSG_MIGRATE_TASK 2
>> #endif
> 
> include/asm-powerpc/smp.h says:
> 
> /* This is unused now */
> #if 0
> #define PPC_MSG_MIGRATE_TASK    2
> #endif
> 
> 
> So it will never be defined. Why do you need it, you don't seem to use
> it anywhere?

Yes, you are correct.  I changed the implementation, but didn't update these
bits.  I'll get rid of that code.

-Geoff
