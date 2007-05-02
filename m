Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PTE entries
Date: Wed, 2 May 2007 12:58:20 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D762D0F8@corpexc01.corp.networkrobots.com>
In-Reply-To: <1177473008.14873.181.camel@localhost.localdomain>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D762C6C3@corpexc01.corp.networkrobots.com>
	<1177376700.14873.40.camel@localhost.localdomain>
	<D83235F0F3C86D4D889D8B9A0DA8C6D762CA85@corpexc01.corp.networkrobots.com>
	<1177473008.14873.181.camel@localhost.localdomain>
From: "Siva Prasad" <sprasad@bivio.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

First,=20
Are there any other places where we have self modifying code in Linux
kernel, other than in arch/powerpc/mm/ppc_mmu_32.c:MMU_init_hw()
(basically modified create_hpte and flush_hash_page)

Second,
Instead of using addis, why can't we move it from SDR1 register and mask
the second half. SDR1 has the required value. Right?
May be I am missing something here.

Thanks
- Siva


-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: Tuesday, April 24, 2007 8:50 PM
To: Siva Prasad
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: RE: PTE entries

On Tue, 2007-04-24 at 20:34 -0700, Siva Prasad wrote:
> Thanks Ben.
>=20
> I managed to fix this. I am working on how best we can rewrite the
self
> modifying code we have for create_hpte routine. I would prefer to read
> from SDR1, than to hardcode (or self modify the code) the way it is
done
> now.
>=20
> Feel free to let me know what you think.

Self-modifying allows better performances in that very critical code
path...

Why would you need to change that code anyway ?

Ben.
