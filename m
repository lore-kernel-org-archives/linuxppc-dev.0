Return-Path: <zi.yan@cs.rutgers.edu>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0091.outbound.protection.outlook.com [104.47.41.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xrWBz436kzDrWL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 00:53:29 +1000 (AEST)
From: "Zi Yan" <zi.yan@cs.rutgers.edu>
To: abdul <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Anshuman Khandual" <khandual@linux.vnet.ibm.com>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>,
 linux-next <linux-next@vger.kernel.org>
Subject: Re: [linux-next] [bisected a4615d11] Memory DLPAR triggers
 WARN_ONCE() in mm/page_vma_mapped.c
Date: Mon, 11 Sep 2017 10:53:19 -0400
Message-ID: <FCEFC0A6-D32A-424C-9858-7C996956F4C0@cs.rutgers.edu>
In-Reply-To: <1505123773.10243.9.camel@abdul>
References: <1505123773.10243.9.camel@abdul>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_BF80F212-8DE9-4981-97D3-E062AB410CE6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_BF80F212-8DE9-4981-97D3-E062AB410CE6_=
Content-Type: text/plain

Hi Abdul,

Can you try this patch below? I think I missed that pmd entries
can be zapped, so the WARN_ONCE is unnecessary.

Thanks.

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 6a03946469a9..eb462e7db0a9 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -167,8 +167,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
                                                return not_found(pvmw);
                                        return true;
                                }
-                       } else
-                               WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
+                       }
                        return not_found(pvmw);
                } else {
                        /* THP pmd was split under us: handle on pte level */

--
Best Regards
Yan Zi

On 11 Sep 2017, at 5:56, abdul wrote:

> Hi,
>
> Memory DLPAR operation on PowerVM booted withnext-20170907, results in
> below warning message.
>
> Machine Type: Power 8 PowerVM LPAR
> Kernel version : 4.13.0-next-20170907
> gcc: 5.2.1
> config : attached
>
> Steps to recreate:
> ----------------------
> Perform dlpar memory add/remove in a loop using 'drmgr' command
>
> $ drmgr -c mem -d 5 -w 30 -r
> $ drmgr -c mem -d 5 -w 30 -a
>
> after few iterations of add / remove dmes shows below warning
>
>
> dmesg logs:
> ------------------
> Non present huge pmd without pmd migration enabled!
>  ------------[ cut here ]------------
>  WARNING: CPU: 14 PID: 5110 at mm/page_vma_mapped.c:171
> page_vma_mapped_walk+0x9a8/0xa10
>  Modules linked in: rpadlpar_io(E) rpaphp(E) xt_addrtype(E)
> xt_conntrack(E) ipt_MASQUERADE(E) nf_nat_masquerade_ipv4(E)
> iptable_nat(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(E)
> iptable_filter(E) ip_tables(E) x_tables(E) nf_nat(E) nf_conntrack(E)
> bridge(E) stp(E) llc(E) dm_thin_pool(E) dm_persistent_data(E)
> dm_bio_prison(E) dm_bufio(E) libcrc32c(E) pseries_rng(E) rtc_generic(E)
> vmx_crypto(E) autofs4(E)
>  CPU: 14 PID: 5110 Comm: stress Tainted: G            E
> 4.13.0-next-20170907-autotest #1
>  task: c000000760755900 task.stack: c0000007749b4000
>  NIP:  c000000000316078 LR: c000000000316074 CTR: c000000000c244b0
>  REGS: c0000007749b7160 TRAP: 0700   Tainted: G            E
> (4.13.0-next-20170907-autotest)
>  MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28242282  XER:
> 20000000
>  CFAR: c000000000182064 SOFTE: 1
>  GPR00: c000000000316074 c0000007749b73e0 c000000001599900
> 0000000000000033
>  GPR04: 0000000000000000 0000000000000000 6c62616e65206e6f
> c000000001769900
>  GPR08: 000000077edd0000 0000000000000000 0000000000000000
> c08000049d002386
>  GPR12: 0000000000002200 c00000000e749300 f000000001274020
> c00000077ff5e100
>  GPR16: c00000077ff54600 c00000077ff64600 f000000001274000
> c0000007749b7650
>  GPR20: 0000000000000000 c0000000032ec800 c0000007735bf5c8
> 000000007ffdab00
>  GPR24: 000000007ffdabff c00000000173e970 0000000000000001
> c0000007605b0000
>  GPR28: f000000001274000 c0000007605b0064 f000000001274000
> c0000007749b74b0
>  NIP [c000000000316078] page_vma_mapped_walk+0x9a8/0xa10
>  LR [c000000000316074] page_vma_mapped_walk+0x9a4/0xa10
>  Call Trace:
>  [c0000007749b73e0] [c000000000316074] page_vma_mapped_walk+0x9a4/0xa10
> (unreliable)
>  [c0000007749b7490] [c00000000031792c] page_referenced_one+0xcc/0x250
>  [c0000007749b7520] [c00000000031841c] rmap_walk_anon+0x15c/0x380
>  [c0000007749b7590] [c00000000031afdc] page_referenced+0x1bc/0x250
>  [c0000007749b7620] [c0000000002d0ebc] shrink_active_list+0x24c/0x5a0
>  [c0000007749b7720] [c0000000002d1850] shrink_node_memcg+0x640/0x790
>  [c0000007749b7820] [c0000000002d1ad8] shrink_node+0x138/0x410
>  [c0000007749b78e0] [c0000000002d1ec8] do_try_to_free_pages+0x118/0x490
>  [c0000007749b7970] [c0000000002d2350] try_to_free_pages+0x110/0x2b0
>  [c0000007749b7a00] [c0000000002b8ab4] __alloc_pages_nodemask
> +0x724/0x1120
>  [c0000007749b7bf0] [c000000000342c78] alloc_pages_vma+0xb8/0x290
>  [c0000007749b7c60] [c0000000003075b0] __handle_mm_fault+0x1150/0x1ad0
>  [c0000007749b7d40] [c000000000308058] handle_mm_fault+0x128/0x210
>  [c0000007749b7d80] [c0000000000671f8] __do_page_fault+0x218/0x8e0
>  [c0000007749b7e30] [c00000000000a4a4] handle_page_fault+0x18/0x38
>  Instruction dump:
>  2fa80000 409e0044 3cc2fff5 8926743d 2f890000 409ef6ec 3c62ff91 39200001
>  3863ce18 9926743d 4be6bfa5 60000000 <0fe00000> 4bfff6cc 7c0004ac
> 39400000
>  ---[ end trace c9b04ac31031ebc8 ]---
>
>
> WARN_ONCE() was introduced by commit a4615d115 ( mm: thp: enable thp
> migration in generic path)
>
>
> Regard's
> Abdul Haleem
> IBM Linux Technology Center

--=_MailMate_BF80F212-8DE9-4981-97D3-E062AB410CE6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJZtqNfAAoJEEGLLxGcTqbMOL0H/RPRmoWN1RaU5+0lClVPChrX
py3wzCp+MQo00PwZZE8a/3Xl+oJuXXRpAkXg1FF/td8NwHyprojE8hNSZZdIS61O
S7Ujdpx3lgGEvyxgREeAHw3H7NcUDGcqCeg4WwUflhNKKQaSGva8lVZ4yWBOckNJ
hmYyqUyd8G1KUi8bCJrcHeyreJoAPmuT1OEcox7V/SNyul6gMSLtHEqGAjGm2sI4
edyxMOdbtfNTSFsX0LSYOXX4SxDHgSiN1Tv5O/7V2jXdJ/qUuDX5efQb6exORt9V
Onck612IUKi/VcfNBZAqxr39Jsgp6E/9czvgWUVBcBEWemImXXCtCqWcUmZs+9Y=
=9Lsl
-----END PGP SIGNATURE-----

--=_MailMate_BF80F212-8DE9-4981-97D3-E062AB410CE6_=--
