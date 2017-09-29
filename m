Return-Path: <zi.yan@cs.rutgers.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0119.outbound.protection.outlook.com [104.47.36.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3YL83MpZzDrWB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 00:07:58 +1000 (AEST)
From: "Zi Yan" <zi.yan@cs.rutgers.edu>
To: abdul <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Anshuman Khandual" <khandual@linux.vnet.ibm.com>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>,
 linux-next <linux-next@vger.kernel.org>
Subject: Re: [linux-next] [bisected a4615d11] Memory DLPAR triggers
 WARN_ONCE() in mm/page_vma_mapped.c
Date: Fri, 29 Sep 2017 10:07:51 -0400
Message-ID: <08A52087-D1D6-45C9-A660-154EB6BF780B@cs.rutgers.edu>
In-Reply-To: <1505281695.9665.5.camel@abdul.in.ibm.com>
References: <1505123773.10243.9.camel@abdul>
 <FCEFC0A6-D32A-424C-9858-7C996956F4C0@cs.rutgers.edu>
 <1505281695.9665.5.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_A7E08F43-CCC4-4B27-81E6-38E39E8E71DC_=";
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

--=_MailMate_A7E08F43-CCC4-4B27-81E6-38E39E8E71DC_=
Content-Type: text/plain

Hi Abdul,

I just want to follow up with this.

Did you have a chance to test my patch? Does it fix your original problem?

Thanks.

--
Best Regards
Yan Zi

On 13 Sep 2017, at 1:48, abdul wrote:

> On Mon, 2017-09-11 at 10:53 -0400, Zi Yan wrote:
>> Hi Abdul,
>>
>> Can you try this patch below? I think I missed that pmd entries
>> can be zapped, so the WARN_ONCE is unnecessary.
>>
>> Thanks.
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 6a03946469a9..eb462e7db0a9 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -167,8 +167,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>                                                 return not_found(pvmw);
>>                                         return true;
>>                                 }
>> -                       } else
>> -                               WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>> +                       }
>>                         return not_found(pvmw);
>>                 } else {
>>                         /* THP pmd was split under us: handle on pte level */
>>
>> --
>> Best Regards
>> Yan Zi
>>
>> On 11 Sep 2017, at 5:56, abdul wrote:
>
> Kernel Oops a different bug is blocking me to verify the given patch,
> may be unrelated to this.
>
> I can validate once the below one gets fixed.
>
> BUG: Bad page state in process avocado  pfn:74943
> page:f000000001d250c0 count:1 mapcount:0 mapping:c00000000594a299
> index:0x1
> flags: 0x33ffff80004007c(referenced|uptodate|dirty|lru|active|
> swapbacked)
> raw: 033ffff80004007c c00000000594a299 0000000000000001 00000001ffffffff
> raw: 5deadbeef0000100 5deadbeef0000200 0000000000000000 c00000077e391800
> page dumped because: page still charged to cgroup
> page->mem_cgroup:c00000077e391800
> bad because of flags: 0x4007c(referenced|uptodate|dirty|lru|active|
> swapbacked)
> Unable to handle kernel paging request for data at address
> 0x5deadbeef0000108
> Faulting instruction address: 0xc0000000002b5604
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE SMP NR_CPUS=2048 NUMA pSeries
> Modules linked in: xt_addrtype xt_conntrack ipt_MASQUERADE
> nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
> nf_nat_ipv4 iptable_filter ip_tables x_tables nf_nat nf_conntrack bridge
> stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c
> rtc_generic vmx_crypto pseries_rng autofs4
> CPU: 3 PID: 922 Comm: avocado Tainted: G    B
> 4.13.0-next-20170907-autotest #2
> task: c000000771bc1700 task.stack: c000000771c04000
> NIP:  c0000000002b5604 LR: c0000000002b7678 CTR: 0000000000000000
> REGS: c000000771c072c0 TRAP: 0380   Tainted: G    B
> (4.13.0-next-20170907-autotest)
> MSR:  800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR:
> 82228228  XER: 2000000f
> CFAR: c0000000002b7674 SOFTE: 0
> GPR00: c0000000002b7678 c000000771c07540 c000000001599900
> 0000000000000000
> GPR04: f000000001d250e0 0000000000000001 5deadbeef0000100
> 5deadbeef0000200
> GPR08: 5deadbee00000000 c00000077ff54710 0000000000000000
> 0000000000000000
> GPR12: 0000000022242224 c00000000e741f80 000000077eb10000
> c00000077fbe88f8
> GPR16: c00000077ff54600 0000000040000000 0000000000000000
> 0000000020000000
> GPR20: 0000000000000002 c00000077fbe8918 c0000000010d88f8
> 0000000000000000
> GPR24: 0000000000000001 0000000000000040 c00000077ff54600
> f000000001d250c0
> GPR28: 0000000000000010 0000000000000000 0000000000000001
> 0000000000000000
> NIP [c0000000002b5604] __rmqueue+0xd4/0x680
> LR [c0000000002b7678] get_page_from_freelist+0x798/0xe30
> Call Trace:
> [c000000771c07540] [f000000001d250c0] 0xf000000001d250c0 (unreliable)
> [c000000771c075f0] [c0000000002b7678] get_page_from_freelist+0x798/0xe30
> [c000000771c07700] [c0000000002b88b8] __alloc_pages_nodemask
> +0x528/0x1120
> [c000000771c078f0] [c000000000358864] new_node_page+0x174/0x200
> [c000000771c07950] [c00000000035f170] migrate_pages+0x2d0/0x1160
> [c000000771c07a30] [c00000000035b1e4] __offline_pages.constprop.6
> +0x8c4/0xa80
> [c000000771c07b70] [c0000000007e2448] memory_subsys_offline+0xa8/0x110
> [c000000771c07ba0] [c0000000007b45d4] device_offline+0x104/0x140
> [c000000771c07be0] [c0000000007e223c] store_mem_state+0x17c/0x190
> [c000000771c07c20] [c0000000007aec28] dev_attr_store+0x68/0xa0
> [c000000771c07c60] [c000000000457680] sysfs_kf_write+0x80/0xb0
> [c000000771c07ca0] [c00000000045638c] kernfs_fop_write+0x17c/0x250
> [c000000771c07cf0] [c00000000038e20c] __vfs_write+0x6c/0x230
> [c000000771c07d90] [c000000000390170] vfs_write+0xd0/0x270
> [c000000771c07de0] [c00000000039214c] SyS_write+0x6c/0x110
> [c000000771c07e30] [c00000000000b184] system_call+0x58/0x6c
> Instruction dump:
> 39290100 7c9a482a 7d3a4a14 7fa92040 3764ffe0 419e01d8 41c201d4 3d005dea
> e8e40008 e8c40000 6108dbee 790807c6 <f8e60008> 6508f000 f8c70000
> 7d094378
> ---[ end trace ca28dd806080b418 ]---
>
>
>>>
>>> Regard's
>>> Abdul Haleem
>>> IBM Linux Technology Center

--=_MailMate_A7E08F43-CCC4-4B27-81E6-38E39E8E71DC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJZzlO3AAoJEEGLLxGcTqbMwLQH/1zkiOcQhvdJi2Fy1OlrZqxh
GWFuY/g7dXlcQsru3HFubpc4YKUVC8Jo9iGDDCFc0RdWkr+7lmkriOwkSQwcoO5E
B2ovb9L47RnTGHKR39wBwzh+bEF/qMLaNsh4TVFnWOcEGSduVQBFjqPPjH7nODI0
fmvx6vSQmAbDmoAjuxIlnbQlNsuUryt1g7x9KfRx5kWIVr0gWbmLy+kFrFYBSnTu
299MH+zfq/VKetUOuwtEoSbcrNNxn3qRzHWLqk3zVNWLbeN9t51c7AzFGLUzMvzB
ALEBG6I6MpxjyIo3RZ4UahnivQV1VsBnl8SMDnC9AwDE8j/4KdvxcpPzbjm+dhA=
=leEO
-----END PGP SIGNATURE-----

--=_MailMate_A7E08F43-CCC4-4B27-81E6-38E39E8E71DC_=--
