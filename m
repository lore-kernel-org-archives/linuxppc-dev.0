Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40E4ADDFAA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 21:11:52 +1000 (EST)
Received: from [131.234.77.53]
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.67) (envelope-from <johannes@sipsolutions.net>)
	id 1I0bcg-0004eU-HX
	for linuxppc-dev@ozlabs.org; Tue, 19 Jun 2007 12:11:46 +0100
Subject: random code execution - kernel oops
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7kLx2xEI/xUaw6XhDm8U"
Date: Mon, 18 Jun 2007 15:04:19 +0200
Message-Id: <1182171859.21013.3.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-7kLx2xEI/xUaw6XhDm8U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

unsigned long hx =3D 0x4bfcc50c;
int main()
{
  asm("bl hx");
}


yields:

[101274.818295] Unable to handle kernel paging request for data at address =
0x0ffdc000
[101274.818313] Faulting instruction address: 0xc00122a8
[101274.818330] Oops: Kernel access of bad area, sig: 11 [#11]
[101274.818335] PREEMPT PowerMac
[101274.818341] Modules linked in: nls_iso8859_15 isofs zlib_inflate udf af=
_packet binfmt_misc radeon drm hci_usb rfcomm l2cap bluetooth snd_powermac =
configfs nls_utf8 hfsplus nls_base fuse dm_snapshot dm_mirror sha256 joydev=
 snd_aoa_codec_tas snd_aoa_fabric_layout appletouch snd_aoa usbhid firewire=
_ohci firewire_core crc_itu_t bcm43xx ieee80211softmac ieee80211 ieee80211_=
crypt arc4 snd_aoa_i2sbus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_p=
age_alloc rc80211_simple snd soundcore ohci1394 ieee1394 snd_aoa_soundbus b=
cm43xx_mac80211 ssb ehci_hcd pcmcia firmware_class mac80211 ohci_hcd cfg802=
11 yenta_socket rsrc_nonstatic usbcore uninorth_agp pcmcia_core agpgart evd=
ev unix
[101274.818448] NIP: c00122a8 LR: c0015950 CTR: 00000080
[101274.818456] REGS: cb157cd0 TRAP: 0300   Not tainted  (2.6.22-rc4-g7d594=
53a-dirty)
[101274.818463] MSR: 00009032 <EE,ME,IR,DR>  CR: 33003353  XER: 80000000
[101274.818478] DAR: 0ffdc000, DSISR: 40000000
[101274.818485] TASK =3D cfc56670[19956] '0x4bfcc50c' THREAD: cb156000
[101274.818490] GPR00: cfc0dc40 cb157d80 cfc56670 0ffdc000 00000080 2272310=
1 0ffdc000 40000000=20
[101274.818508] GPR08: c084e000 cfc0dc40 00000000 c084e000 0000015b 100189a=
0 c0610000 0ffdc000=20
[101274.818525] GPR16: c05f8a10 100d0000 fe3fffff 00000000 ca437200 0000000=
0 d2b170fc c0610000=20
[101274.818542] GPR24: cfc0dc40 00000f70 0ffdceac ec849a58 ec849a58 0ffdcea=
c 22723101 c0c9c460=20
[101274.818560] NIP [c00122a8] __flush_dcache_icache+0x14/0x40
[101274.818580] LR [c0015950] update_mmu_cache+0xec/0xf0
[101274.818591] Call Trace:
[101274.818596] [cb157d80] [00000f70] 0xf70 (unreliable)
[101274.818610] [cb157da0] [c0079cec] __handle_mm_fault+0x2d8/0xbe4
[101274.818623] [cb157e10] [c0301aa8] do_page_fault+0x41c/0x554
[101274.818640] [cb157f40] [c00119f4] handle_page_fault+0xc/0x80
[101274.818650] --- Exception: 401 at 0xffdceac
[101274.818660]     LR =3D 0x1000043c
[101274.818664] Instruction dump:
[101274.818670] 4d820020 7c8903a6 7c001bac 38630020 4200fff8 7c0004ac 4e800=
020 60000000=20
[101274.818687] 54630026 38800080 7c8903a6 7c661b78 <7c00186c> 38630020 420=
0fff8 7c0004ac=20
[101274.818707] note: 0x4bfcc50c[19956] exited with preempt_count 2
[101274.818716] BUG: sleeping function called from invalid context at kerne=
l/rwsem.c:20
[101274.818723] in_atomic():1, irqs_disabled():0
[101274.818727] Call Trace:
[101274.818732] [cb157bc0] [c0008e10] show_stack+0x3c/0x194 (unreliable)
[101274.818748] [cb157bf0] [c0027648] __might_sleep+0xd0/0xec
[101274.818764] [cb157c00] [c00494d4] down_read+0x24/0x5c
[101274.818778] [cb157c20] [c005cda4] acct_collect+0x44/0x1a4
[101274.818793] [cb157c40] [c0030470] do_exit+0x10c/0x8c4
[101274.818805] [cb157c80] [c000ff34] die+0x210/0x218
[101274.818815] [cb157cb0] [c0015600] bad_page_fault+0x90/0xd8
[101274.818825] [cb157cc0] [c0011a64] handle_page_fault+0x7c/0x80
[101274.818835] --- Exception: 300 at __flush_dcache_icache+0x14/0x40
[101274.818846]     LR =3D update_mmu_cache+0xec/0xf0
[101274.818852] [cb157d80] [00000f70] 0xf70 (unreliable)
[101274.818901] [cb157da0] [c0079cec] __handle_mm_fault+0x2d8/0xbe4
[101274.818911] [cb157e10] [c0301aa8] do_page_fault+0x41c/0x554
[101274.818923] [cb157f40] [c00119f4] handle_page_fault+0xc/0x80
[101274.818933] --- Exception: 401 at 0xffdceac
[101274.818942]     LR =3D 0x1000043c
[101274.818961] BUG: scheduling while atomic: 0x4bfcc50c/0x10000002/19956
[101274.818967] Call Trace:
[101274.818971] [cb157ac0] [c0008e10] show_stack+0x3c/0x194 (unreliable)
[101274.818984] [cb157af0] [c02fe44c] schedule+0x584/0x6b4
[101274.818994] [cb157b40] [c00276f4] __cond_resched+0x34/0x60
[101274.819006] [cb157b50] [c02fe8f4] cond_resched+0x50/0x58
[101274.819016] [cb157b60] [c0077964] unmap_vmas+0x698/0x6b4
[101274.819026] [cb157be0] [c007c558] exit_mmap+0x74/0x120
[101274.819036] [cb157c10] [c002a1f0] mmput+0x68/0xf8
[101274.819048] [cb157c20] [c002e7fc] exit_mm+0xac/0x110
[101274.819058] [cb157c40] [c0030484] do_exit+0x120/0x8c4
[101274.819067] [cb157c80] [c000ff34] die+0x210/0x218
[101274.819077] [cb157cb0] [c0015600] bad_page_fault+0x90/0xd8
[101274.819087] [cb157cc0] [c0011a64] handle_page_fault+0x7c/0x80
[101274.819097] --- Exception: 300 at __flush_dcache_icache+0x14/0x40
[101274.819109]     LR =3D update_mmu_cache+0xec/0xf0
[101274.819115] [cb157d80] [00000f70] 0xf70 (unreliable)
[101274.819125] [cb157da0] [c0079cec] __handle_mm_fault+0x2d8/0xbe4
[101274.819135] [cb157e10] [c0301aa8] do_page_fault+0x41c/0x554
[101274.819147] [cb157f40] [c00119f4] handle_page_fault+0xc/0x80
[101274.819157] --- Exception: 401 at 0xffdceac
[101274.819166]     LR =3D 0x1000043c


--=-7kLx2xEI/xUaw6XhDm8U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGdoLS/ETPhpq3jKURAmE8AJ9o/a8c6zjALQn0c2+v6DwXVU77vgCgiZKx
SBF+NxLpXHct4zXoCD/vQdk=
=LFnr
-----END PGP SIGNATURE-----

--=-7kLx2xEI/xUaw6XhDm8U--
