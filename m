Return-Path: <geoffrey.levand@am.sony.com>
Received: from ns6.sony.co.jp (NS6.Sony.CO.JP [137.153.0.32])
	by ozlabs.org (Postfix) with ESMTP id B6B8767D18
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 20:11:21 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAA9BJsa020547
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 18:11:19 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAA9BIdI020528
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 18:11:18 +0900 (JST)
Message-ID: <45544230.6070605@am.sony.com>
Date: Fri, 10 Nov 2006 01:11:12 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [PATCH 2/2] Add support for dumping spu info	from
	xmon
References: <20061012120312.10FDD67BE5@ozlabs.org>	
	<452E7E8E.8000808@am.sony.com>
	<1161154573.7906.11.camel@localhost.localdomain>
In-Reply-To: <1161154573.7906.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Thu, 2006-10-12 at 10:42 -0700, Geoff Levand wrote:
>> Michael Ellerman wrote:
>> > This patch adds a command to xmon for dumping information about
>> > spu structs. The command is 'sf' for "spu fields" perhaps, and
>> > takes the spu number as an argument. This is the same value as the
>> > spu->number field, or the "phys-id" value of a context when it is
>> > bound to a physical spu.
>> 
>> > +static void dump_spu_fields(struct spu *spu)
>> > +{
>> ...
>> > +	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
>> > +	DUMP_FIELD(spu, "0x%p", priv1);
>> > +
>> > +	if (spu->priv1)
>> > +		DUMP_FIELD(spu, "0x%lx", priv1->mfc_sr1_RW);
>> > +
>> > +	DUMP_FIELD(spu, "0x%p", priv2);
>> 
>> Just to let you know, I've been doing some work to abstract the platform
>> specific parts out of the spu support to better support running on a
>> hypervisor.  It shouldn't make much difference, but maybe I'll try to set
>> something up like this for you:
>>  
>> 	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
>> 	DUMP_FIELD(spu, "0x%p", priv2);
>> 	spu_dump_platform_fields(spu);
> 
> We already have the spu_priv1_ops abstracted out, is that not enough? I
> decided to check explicitly for the priv1 pointer because calling the
> hypervisor from a panicked kernel is risky at best. Although I haven't
> seen how you guys implement hypervisor calls, so perhaps it's not so
> bad.

Michael,

I tried to set this up as above, but unfortunately, your DUMP_FIELD is
setup in such a way that it is not easy to change to use from outside
xmon.c, so I left spu_dump_platform_fields() (I put it in spu_priv1_mmio.c)
empty.  We'll need to work on something usable here, or make some other way
to abstract those platform specific spu variables.

I'll re-post my abstract spu management routines patch again soon with
this xmon support added.

-Geoff
