Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 99CDF67C38
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 04:01:17 +1000 (EST)
Message-ID: <452E7E8E.8000808@am.sony.com>
Date: Thu, 12 Oct 2006 10:42:38 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH 2/2] Add support for dumping spu info from
	xmon
References: <20061012120312.10FDD67BE5@ozlabs.org>
In-Reply-To: <20061012120312.10FDD67BE5@ozlabs.org>
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
> This patch adds a command to xmon for dumping information about
> spu structs. The command is 'sf' for "spu fields" perhaps, and
> takes the spu number as an argument. This is the same value as the
> spu->number field, or the "phys-id" value of a context when it is
> bound to a physical spu.

> +static void dump_spu_fields(struct spu *spu)
> +{
...
> +	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
> +	DUMP_FIELD(spu, "0x%p", priv1);
> +
> +	if (spu->priv1)
> +		DUMP_FIELD(spu, "0x%lx", priv1->mfc_sr1_RW);
> +
> +	DUMP_FIELD(spu, "0x%p", priv2);

Just to let you know, I've been doing some work to abstract the platform
specific parts out of the spu support to better support running on a
hypervisor.  It shouldn't make much difference, but maybe I'll try to set
something up like this for you:
 
	DUMP_FIELD(spu, "0x%x", problem->spu_npc_RW);
	DUMP_FIELD(spu, "0x%p", priv2);
	spu_dump_platform_fields(spu);

-Geoff
