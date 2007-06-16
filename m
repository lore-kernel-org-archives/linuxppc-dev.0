Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/13] Abolish iopa(), mm_ptov(), io_block_mapping()
	from arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070613045254.4ACC0DDE31@ozlabs.org>
References: <20070613045254.4ACC0DDE31@ozlabs.org>
Content-Type: text/plain
Date: Sat, 16 Jun 2007 10:55:58 +1000
Message-Id: <1181955358.26853.108.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-13 at 14:52 +1000, David Gibson wrote:
> These old-fashioned IO mapping functions no longer have any callers in
> code which remains relevant on arch/powerpc.  Therefore, this patch
> removes them from arch/powerpc.

I think we still want a way to setup some hand crafted BATs... maybe a
special flag to pass to ioremap_flags ?

It makes sense to map some heavily accessed on chip register space with
a BAT on embedded. The reason I didn't like io_block_mapping() was
because the virtual address was hard coded. But I don't think we should
throw the baby with the bath water. If we can have it allocate the virt
address using the ioremap_bot trick, that would be a good thing to keep
around.

Ben.
