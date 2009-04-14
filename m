Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D571DDF3F
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 03:42:36 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c  
	drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <1239724227.24771.9.camel@johannes.local>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-SZcTzQ2LtbIS/yi8SlRF"
Date: Tue, 14 Apr 2009 19:41:55 +0200
Message-Id: <1239730915.24771.12.camel@johannes.local>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SZcTzQ2LtbIS/yi8SlRF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-04-14 at 17:51 +0200, Johannes Berg wrote:
> On Tue, 2009-04-14 at 17:40 +0200, Johannes Berg wrote:
>=20
> > So I went to test this, but for some reason aoa doesn't work for me at
> > all, neither with nor without this patch.
> >=20
> > The reason seems to be that aoa_fabric_layout_probe() is never called,
> > but my driver model fu is weak so I can't tell why -- I definitely see
> > the i2sbus soundbus devices registered. soundbus_probe() isn't getting
> > called either though, but we do of_device_register(). I'm confused, but
> > don't have time to dig further right now.
>=20
> 2.6.29 works -- guess somebody could bisect, but I can't now.

Alright, with the patch Andreas pointed out it loads, but segfaults, as
below. Works fine without your patch.

johannes

[   10.267137] snd-aoa-codec-onyx: found pcm3052
[   10.267238] PM: Adding info for i2c:2-0046
[   10.267926] snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match=
!
[   10.267930] snd-aoa: fabric didn't like codec onyx
[   10.268041] aoa_codec_onyx: probe of 2-0046 failed with error -22
[   10.268067] Unable to handle kernel paging request for data at address 0=
x000000d0
[   10.268070] Faulting instruction address: 0xd000000001291d68
[   10.268074] Oops: Kernel access of bad area, sig: 11 [#1]
[   10.268076] PREEMPT SMP NR_CPUS=3D4 PowerMac
[   10.268080] Modules linked in: snd_aoa_codec_onyx(+) firewire_ohci usbhi=
d(+) arc4 snd_aoa_fabric_layout(+) snd_aoa ecb firewire_core crc_itu_t snd_=
aoa_i2sbus snd_aoa_soundbus iwlagn iwlcore snd_pcm snd_page_alloc ohci_hcd =
snd_timer ohci1394 ehci_hcd rfkill led_class ieee1394 usbcore snd mac80211 =
soundcore cfg80211
[   10.268109] NIP: d000000001291d68 LR: d000000001291d20 CTR: 000000000000=
0000
[   10.268113] REGS: c0000001e19a34e0 TRAP: 0300   Not tainted  (2.6.30-rc1=
-wl-dirty)
[   10.268115] MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 22000488  XER: 0000=
0000
[   10.268124] DAR: 00000000000000d0, DSISR: 0000000040000000
[   10.268127] TASK =3D c000000205cd9d30[3391] 'modprobe' THREAD: c0000001e=
19a0000 CPU: 1
[   10.268130] GPR00: d000000001291d20 c0000001e19a3760 d00000000129cdd8 c0=
00000200c177e0=20
[   10.268135] GPR04: c000000205cda760 0000000000000007 c000000205cd9d68 c0=
00000205cd9d68=20
[   10.268140] GPR08: 0000000000000000 0000000000000000 c000000200c179f0 c0=
000000010ab590=20
[   10.268145] GPR12: 0000000088000488 c0000000009c2500 0000000000000000 00=
00000000000000=20
[   10.268150] GPR16: 0000000000000000 0000000000000000 0000000000000000 00=
00000000000000=20
[   10.268155] GPR20: 0000000000000000 0000000000000001 000000000054bda0 00=
000000001ed780=20
[   10.268160] GPR24: 0000000000548080 00000000008c1858 c000000000847b18 00=
00000000000046=20
[   10.268165] GPR28: c000000217ff56d8 c000000200a59e68 d00000000129c990 c0=
000001e19a37d8=20
[   10.268175] NIP [d000000001291d68] .onyx_create+0xc0/0x100 [snd_aoa_code=
c_onyx]
[   10.268181] LR [d000000001291d20] .onyx_create+0x78/0x100 [snd_aoa_codec=
_onyx]
[   10.268183] Call Trace:
[   10.268188] [c0000001e19a3760] [d000000001291d20] .onyx_create+0x78/0x10=
0 [snd_aoa_codec_onyx] (unreliable)
[   10.268196] [c0000001e19a3840] [c00000000037f900] .__attach_adapter+0x4c=
/0x6c
[   10.268203] [c0000001e19a38d0] [c0000000002f7e34] .class_for_each_device=
+0xb4/0x10c
[   10.268208] [c0000001e19a3990] [c00000000037ecec] .i2c_register_driver+0=
xf0/0x128
[   10.268214] [c0000001e19a3a30] [d000000001291f20] .onyx_init+0x20/0x668 =
[snd_aoa_codec_onyx]
[   10.268219] [c0000001e19a3ab0] [c000000000007f68] .do_one_initcall+0x9c/=
0x1dc
[   10.268225] [c0000001e19a3d90] [c000000000099b0c] .SyS_init_module+0xd8/=
0x238
[   10.268229] [c0000001e19a3e30] [c000000000007554] syscall_exit+0x0/0x40
[   10.268232] Instruction dump:
[   10.268235] a0090022 8129001e b0010074 91210070 48000341 e8410028 2fa300=
00 3900ffed=20
[   10.268242] 419e0028 e9230020 39430210 39000000 <e96900d0> 380900c8 f949=
00d0 f8030210=20
[   10.268253] BUG: using smp_processor_id() in preemptible [00000000] code=
: modprobe/3391
[   10.268258] caller is .die+0x188/0x1d4
[   10.268260] Call Trace:
[   10.268264] [c0000001e19a3210] [c00000000000fcc4] .show_stack+0x6c/0x174=
 (unreliable)
[   10.268271] [c0000001e19a32c0] [c00000000029e65c] .debug_smp_processor_i=
d+0xe0/0x118
[   10.268275] [c0000001e19a3350] [c000000000020918] .die+0x188/0x1d4
[   10.268280] [c0000001e19a33f0] [c000000000027f74] .bad_page_fault+0xb8/0=
xd4
[   10.268284] [c0000001e19a3470] [c00000000000524c] handle_page_fault+0x3c=
/0x5c
[   10.268293] --- Exception: 300 at .onyx_create+0xc0/0x100 [snd_aoa_codec=
_onyx]
[   10.268295]     LR =3D .onyx_create+0x78/0x100 [snd_aoa_codec_onyx]
[   10.268299] [c0000001e19a3840] [c00000000037f900] .__attach_adapter+0x4c=
/0x6c
[   10.268304] [c0000001e19a38d0] [c0000000002f7e34] .class_for_each_device=
+0xb4/0x10c
[   10.268308] [c0000001e19a3990] [c00000000037ecec] .i2c_register_driver+0=
xf0/0x128
[   10.268315] [c0000001e19a3a30] [d000000001291f20] .onyx_init+0x20/0x668 =
[snd_aoa_codec_onyx]
[   10.268319] [c0000001e19a3ab0] [c000000000007f68] .do_one_initcall+0x9c/=
0x1dc
[   10.268323] [c0000001e19a3d90] [c000000000099b0c] .SyS_init_module+0xd8/=
0x238
[   10.268328] [c0000001e19a3e30] [c000000000007554] syscall_exit+0x0/0x40
[   10.268331] ---[ end trace dbcf63aa775331e7 ]---


--=-SZcTzQ2LtbIS/yi8SlRF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5MrgAAoJEKVg1VMiehFYWBUP/3C9xEvCdUF24JS7/ky0y9ro
4uxh7L1eNsoKEn3FvGfgin1tBNj7ILilnQhsB/g5puDE4vRM4gVKwg4n0ecUvWS8
jBnHXnXNPuroe9JphE2l+MeIPhGH5NJgNSbC8ZO1FunrS84JbAA0uTc9kk9U08XC
fW5aL9p7XyMS3JyIIj/d7sMH0oXmeCoEu77EBjIEtWHZzNJVNj8BVKtSvAA7RutX
AI1dJio34aWbjunAE0+EfCosNcmN1TW/l6UwmIqXq3YC+ciANhN5odM3Xv5rpLgI
aRHMa88TSbdN4HWD3+oDxjiw2o4NoysbYOrsfQMp46IFo3S7Lgsq3+q4O9GFPSuP
gHPhxuFxyahqYngvX0dRcr/mprGWQ/KsEID+iTXO2Jn3TkaNN5MXbeVkzh4Yj3sX
i8Gig2cXypHXV+evU5PDJZd680YeMhs2Qb9vDrriRPbjO/RsB7/q74V47gBQpl+p
Axq91hlTnUTWTGAQeQUCDeIv8oHmrwvM0UPZuQQhcrNsCEw0LlztCmLuKhOYYbxo
8c4vy+dlnrexbn8K5yTx1Xs21Fj/scP+TZixt6ZyVppjcxlJAedFF552oc8fexw7
I1rE/jl6GbVIaVfQ7mPEsoAJo5jFDnVLrR6mjj7FWPBLx9qXVp824GwYPeriuXwv
SCkzrrxog3b3b53wSJx5
=F7Vo
-----END PGP SIGNATURE-----

--=-SZcTzQ2LtbIS/yi8SlRF--
