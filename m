Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 0ABB12C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 22:12:32 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: Error in frreing hugepages with preemption enabled
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07238568@039-SN2MPN1-012.039d.mgd.msft.net>
Date: Fri, 29 Nov 2013 12:13:03 +0100
Message-Id: <EDB02D3B-6B03-4CCB-95C8-FDF2F2932E1D@suse.de>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D07238568@039-SN2MPN1-012.039d.mgd.msft.net>
To: Bharat Bhushan <Bharat.Bhushan@freescale.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 29.11.2013, at 05:38, Bharat Bhushan <Bharat.Bhushan@freescale.com> =
wrote:

> Hi Alex,
>=20
> I am running KVM guest with host kernel having CONFIG_PREEMPT enabled. =
With allocated pages things seems to work fine but I uses hugepages for =
guest I see below prints when "quit" from qemu.
>=20
> (qemu) QEMU waiting for connection on: telnet:0.0.0.0:4444,server
> qemu-system-ppc64: pci_add_option_rom: failed to find romfile =
"efi-virtio.rom"
> q
> debug_smp_processor_id: 15 callbacks suppressed
> BUG: using smp_processor_id() in preemptible [00000000] code: =
qemu-system-ppc/2504
> caller is .free_hugepd_range+0xb0/0x21c
> CPU: 1 PID: 2504 Comm: qemu-system-ppc Not tainted =
3.12.0-rc3-07733-gabf4907 #175
> Call Trace:
> [c0000000fb433400] [c000000000007d38] .show_stack+0x7c/0x1cc =
(unreliable)
> [c0000000fb4334d0] [c0000000005e8ce0] .dump_stack+0x9c/0xf4
> [c0000000fb433560] [c0000000002de5ec] =
.debug_smp_processor_id+0x108/0x11c
> [c0000000fb4335f0] [c000000000025e10] .free_hugepd_range+0xb0/0x21c
> [c0000000fb433680] [c0000000000265bc] =
.hugetlb_free_pgd_range+0x2c8/0x3b0
> [c0000000fb4337a0] [c0000000000e428c] .free_pgtables+0x14c/0x158
> [c0000000fb433840] [c0000000000ef320] .exit_mmap+0xec/0x194
> [c0000000fb433960] [c00000000004d780] .mmput+0x64/0x124
> [c0000000fb4339e0] [c000000000051f40] .do_exit+0x29c/0x9c8
> [c0000000fb433ae0] [c0000000000527c8] .do_group_exit+0x50/0xc4
> [c0000000fb433b70] [c0000000000606a0] =
.get_signal_to_deliver+0x21c/0x5d8
> [c0000000fb433c70] [c000000000009b08] .do_signal+0x54/0x278
> [c0000000fb433db0] [c000000000009e50] .do_notify_resume+0x64/0x78
> [c0000000fb433e30] [c000000000000b44] .ret_from_except_lite+0x70/0x74
>=20
>=20
> This mean that free_hugepd_range() must be called with preemption =
enabled.

with preemption disabled.

> I tried below change and this seems to work fine (I am not having =
expertise in this area so not sure this is correct way)

Not sure - the scope looks odd to me. Let's ask Andrea - I'm sure he =
knows what to do :).


Alex

>=20
> diff --git a/arch/powerpc/mm/hugetlbpage.c =
b/arch/powerpc/mm/hugetlbpage.c
> index d67db4b..6bf8459 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -563,8 +563,10 @@ static void hugetlb_free_pmd_range(struct =
mmu_gather *tlb, pud_t *pud,
>                 */
>                next =3D addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
> #endif
> +               preempt_disable();
>                free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
>                                  addr, next, floor, ceiling);
> +               preempt_enable();
>        } while (addr =3D next, addr !=3D end);
>=20
>        start &=3D PUD_MASK;
>=20
>=20
> Thanks
> -Bharat
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
