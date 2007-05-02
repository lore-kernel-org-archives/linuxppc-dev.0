Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17977.2733.78406.322755@cargo.ozlabs.ibm.com>
Date: Thu, 3 May 2007 08:03:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Siva Prasad" <sprasad@bivio.net>
Subject: RE: PTE entries
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D762D0F8@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D762C6C3@corpexc01.corp.networkrobots.com>
	<1177376700.14873.40.camel@localhost.localdomain>
	<D83235F0F3C86D4D889D8B9A0DA8C6D762CA85@corpexc01.corp.networkrobots.com>
	<1177473008.14873.181.camel@localhost.localdomain>
	<D83235F0F3C86D4D889D8B9A0DA8C6D762D0F8@corpexc01.corp.networkrobots.com>
Cc: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Siva Prasad writes:

> Are there any other places where we have self modifying code in Linux
> kernel, other than in arch/powerpc/mm/ppc_mmu_32.c:MMU_init_hw()
> (basically modified create_hpte and flush_hash_page)

Yes, the cpu feature stuff writes nops over various bits of code
depending on what cpu you're running on.  See do_feature_fixups() in
arch/powerpc/kernel/cputable.c.

> Instead of using addis, why can't we move it from SDR1 register and mask
> the second half. SDR1 has the required value. Right?
> May be I am missing something here.

mtspr is slow on most processors, certainly slower than addis.

Paul.
