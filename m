From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15744.5564.428016.887779@argo.ozlabs.ibm.com>
Date: Thu, 12 Sep 2002 14:19:08 +1000 (EST)
To: jmar@terayon.com
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 and HPTE
In-Reply-To: <3D7FD2A3.EC0E0F06@terayon.com>
References: <3D7FD2A3.EC0E0F06@terayon.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Mar writes:

> I am using 2.4.18 on a proprietary 8260 board. It appears that
> CPU_FTR_HPTE_TABLE is not supported for the 8260(603e). Therefore,
> MMU_init_hw in ppc_mmu.c returns without patching create_hpte and
> flush_hash_page in hashtable.S or allocating hash memory.
>
> However, a Data Access Exception(0x300) eventually calls create_hpte,
> trashing my memory.

This is fixed in the official 2.4.19 and in the current linuxppc_2_4
and linuxppc_2_4_devel trees.  The code that calls hash_page (which calls
create_hpte) in the DSI handler is in a feature section, which means
it gets overwritten with NOPs if we don't have a hash table.

Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
