Return-Path: <benh@kernel.crashing.org>
Subject: RE: PTE entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Siva Prasad <sprasad@bivio.net>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D762D0F8@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D762C6C3@corpexc01.corp.networkrobots.com>
	<1177376700.14873.40.camel@localhost.localdomain>
	<D83235F0F3C86D4D889D8B9A0DA8C6D762CA85@corpexc01.corp.networkrobots.com>
	<1177473008.14873.181.camel@localhost.localdomain>
	<D83235F0F3C86D4D889D8B9A0DA8C6D762D0F8@corpexc01.corp.networkrobots.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 08:12:46 +1000
Message-Id: <1178143966.17299.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-02 at 12:58 -0700, Siva Prasad wrote:
> Hi Ben,
> 
> First, 
> Are there any other places where we have self modifying code in Linux
> kernel, other than in arch/powerpc/mm/ppc_mmu_32.c:MMU_init_hw()
> (basically modified create_hpte and flush_hash_page)

There is the cpu feature fixup code, there might also be something
around the SMP code.

> Second,
> Instead of using addis, why can't we move it from SDR1 register and mask
> the second half. SDR1 has the required value. Right?
> May be I am missing something here.

Would be slower. Accessing SPRs is slow.
