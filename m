Return-Path: <efault@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCPnr21DvzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 22:54:55 +1100 (AEDT)
Message-ID: <1485863317.4498.2.camel@gmx.de>
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch
 missing update_rq_clock() calls
From: Mike Galbraith <efault@gmx.de>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>, Matt Fleming
 <matt@codeblueprint.co.uk>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 peterz@infradead.org, "linux-next@vger.kernel.org"
 <linux-next@vger.kernel.org>,  linux-kernel@vger.kernel.org
Date: Tue, 31 Jan 2017 12:48:37 +0100
In-Reply-To: <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
References: <20160921133813.31976-8-matt@codeblueprint.co.uk>
 <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
 <87tw8gutp6.fsf@concordia.ellerman.id.au>
 <20170130213435.GM31613@codeblueprint.co.uk>
 <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
Content-Type: text/plain; charset="iso-8859-7"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-31 at 16:30 +0530, Sachin Sant wrote:
> Trimming the cc list.
>=20
> > > I assume I should be worried?
> >=20
> > Thanks for the report. No need to worry, the bug has existed for a
> > while, this patch just turns on the warning ;-)
> >=20
> > The following commit queued up in tip/sched/core should fix your
> > issues (assuming you see the same callstack on all your powerpc
> > machines):
> >=20
> >  https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=3Ds=
ched/core&id=3D1b1d62254df0fe42a711eb71948f915918987790
>=20
> I still see this warning with today=A2s next running inside PowerVM LPAR
> on a POWER8 box. The stack trace is different from what Michael had
> reported.
>=20
> Easiest way to recreate this is to Online/offline cpu=A2s.

(Ditto tip.today, x86_64 + hotplug stress)

[   94.804196] ------------[ cut here ]------------
[   94.804201] WARNING: CPU: 3 PID: 27 at kernel/sched/sched.h:804 set_next=
_entity+0x81c/0x910
[   94.804201] rq->clock_update_flags < RQCF_ACT_SKIP
[   94.804202] Modules linked in: ebtable_filter(E) ebtables(E) fuse(E) bri=
dge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) ip6t_REJECT(E) xt_tc=
pudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E=
) iptable_raw(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_=
ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_t=
ables(E) xt_conntrack(E) nf_conntrack(E) ip6table_filter(E) ip6_tables(E) x=
_tables(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_inte=
l(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) nls_iso8859_1(=
E) crc32c_intel(E) nls_cp437(E) snd_hda_codec_realtek(E) snd_hda_codec_hdmi=
(E) snd_hda_codec_generic(E) nfsd(E) aesni_intel(E) snd_hda_intel(E) snd_hd=
a_codec(E) snd_hwdep(E) aes_x86_64(E) snd_hda_core(E) crypto_simd(E)
[   94.804220]  snd_pcm(E) auth_rpcgss(E) snd_timer(E) snd(E) iTCO_wdt(E) i=
TCO_vendor_support(E) joydev(E) nfs_acl(E) lpc_ich(E) cryptd(E) lockd(E) in=
tel_smartconnect(E) mfd_core(E) i2c_i801(E) battery(E) glue_helper(E) mei_m=
e(E) shpchp(E) mei(E) soundcore(E) grace(E) fan(E) thermal(E) tpm_infineon(=
E) pcspkr(E) sunrpc(E) efivarfs(E) sr_mod(E) cdrom(E) hid_logitech_hidpp(E)=
 hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(=
E) wmi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) s=
ysimgblt(E) fb_sys_fops(E) ahci(E) xhci_pci(E) ehci_pci(E) ttm(E) libahci(E=
) xhci_hcd(E) ehci_hcd(E) r8169(E) mii(E) libata(E) drm(E) usbcore(E) fjes(=
E) video(E) button(E) af_packet(E) sd_mod(E) vfat(E) fat(E) ext4(E) crc16(E=
) jbd2(E) mbcache(E) dm_mod(E) loop(E) sg(E) scsi_mod(E) autofs4(E)
[   94.804246] CPU: 3 PID: 27 Comm: migration/3 Tainted: G            E   4=
.10.0-tip #15
[   94.804247] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[   94.804247] Call Trace:
[   94.804251]  ? dump_stack+0x5c/0x7c
[   94.804253]  ? __warn+0xc4/0xe0
[   94.804255]  ? warn_slowpath_fmt+0x4f/0x60
[   94.804256]  ? set_next_entity+0x81c/0x910
[   94.804258]  ? pick_next_task_fair+0x20a/0xa20
[   94.804259]  ? sched_cpu_starting+0x50/0x50
[   94.804260]  ? sched_cpu_dying+0x237/0x280
[   94.804261]  ? sched_cpu_starting+0x50/0x50
[   94.804262]  ? cpuhp_invoke_callback+0x83/0x3e0
[   94.804263]  ? take_cpu_down+0x56/0x90
[   94.804266]  ? multi_cpu_stop+0xa9/0xd0
[   94.804267]  ? cpu_stop_queue_work+0xb0/0xb0
[   94.804268]  ? cpu_stopper_thread+0x81/0x110
[   94.804270]  ? smpboot_thread_fn+0xfe/0x150
[   94.804272]  ? kthread+0xf4/0x130
[   94.804273]  ? sort_range+0x20/0x20
[   94.804274]  ? kthread_park+0x80/0x80
[   94.804276]  ? ret_from_fork+0x26/0x40
[   94.804277] ---[ end trace b0a9e4aa1fb229bb ]---
