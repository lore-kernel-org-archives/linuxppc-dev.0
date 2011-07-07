Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B39C2B6F68
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 01:32:37 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p67FWVsh030032
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jul 2011 17:32:31 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@ozlabs.org
Subject: Re: Analysing a kernel panic
Date: Thu, 7 Jul 2011 17:32:30 +0200
References: <201107051619.50548.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201107051619.50548.dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107071732.31051.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'll expand a bit on my previous message. Here's a more detailed dump of what happens when my system receives a second 
interrupt (the 1st one works fine) from my hardware:

[  263.586996] do_IRQ: stack overflow: 1920
[  263.590785] Call Trace:
[  263.593275] [c7792780] [c00073ac] show_stack+0x80/0x19c (unreliable)
[  263.599543] [c77927c0] [c0004d98] do_IRQ+0x48/0xcc
[  263.604314] [c77927d0] [c000f434] ret_from_except+0x0/0x18
[  263.609714] [c7792890] [00000000] (null)
[  263.613628] [c77928a0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.619476] [c7792960] [00000000] (null)
[  263.623410] [c7792970] [c0052554] handle_level_irq+0x54/0x128
[  263.629090] [c7792980] [c0004dd8] do_IRQ+0x88/0xcc
[  263.633852] [c7792990] [c000f434] ret_from_except+0x0/0x18
[  263.639262] [c7792a50] [00000000] (null)
[  263.643176] [c7792a60] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.649025] [c7792b20] [00000000] (null)
[  263.652945] [c7792b30] [c0052554] handle_level_irq+0x54/0x128
[  263.658638] [c7792b40] [c0004dd8] do_IRQ+0x88/0xcc
[  263.663400] [c7792b50] [c000f434] ret_from_except+0x0/0x18
[  263.668811] [c7792c10] [00000000] (null)
[  263.672725] [c7792c20] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.678574] [c7792ce0] [00000000] (null)
[  263.682494] [c7792cf0] [c0052554] handle_level_irq+0x54/0x128
[  263.688189] [c7792d00] [c0004dd8] do_IRQ+0x88/0xcc
[  263.692949] [c7792d10] [c000f434] ret_from_except+0x0/0x18
[  263.698360] [c7792dd0] [00000000] (null)
[  263.702274] [c7792de0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.708123] [c7792ea0] [00000000] (null)
[  263.712043] [c7792eb0] [c0052554] handle_level_irq+0x54/0x128
[  263.717736] [c7792ec0] [c0004dd8] do_IRQ+0x88/0xcc
[  263.722498] [c7792ed0] [c000f434] ret_from_except+0x0/0x18
[  263.727909] [c7792f90] [00000000] (null)
[  263.731822] [c7792fa0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.737671] [c7793060] [00000000] (null)
[  263.741592] [c7793070] [c0052554] handle_level_irq+0x54/0x128
[  263.747285] [c7793080] [c0004dd8] do_IRQ+0x88/0xcc
[  263.752048] [c7793090] [c000f434] ret_from_except+0x0/0x18
[  263.757457] [c7793150] [00000000] (null)
[  263.761372] [c7793160] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.767221] [c7793220] [00000000] (null)
[  263.771143] [c7793230] [c0052554] handle_level_irq+0x54/0x128
[  263.776834] [c7793240] [c0004dd8] do_IRQ+0x88/0xcc
[  263.781597] [c7793250] [c000f434] ret_from_except+0x0/0x18
[  263.787006] [c7793310] [00000000] (null)
[  263.790921] [c7793320] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.796770] [c77933e0] [00000000] (null)
[  263.800693] [c77933f0] [c0052554] handle_level_irq+0x54/0x128
[  263.806383] [c7793400] [c0004dd8] do_IRQ+0x88/0xcc
[  263.811146] [c7793410] [c000f434] ret_from_except+0x0/0x18
[  263.816555] [c77934d0] [00000000] (null)
[  263.820470] [c77934e0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.826319] [c77935a0] [00000000] (null)
[  263.830241] [c77935b0] [c0052554] handle_level_irq+0x54/0x128
[  263.835932] [c77935c0] [c0004dd8] do_IRQ+0x88/0xcc
[  263.840694] [c77935d0] [c000f434] ret_from_except+0x0/0x18
[  263.846104] [c7793690] [00000000] (null)
[  263.850019] [c77936a0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.855867] [c7793760] [00000000] (null)
[  263.859788] [c7793770] [c0052554] handle_level_irq+0x54/0x128
[  263.865481] [c7793780] [c0004dd8] do_IRQ+0x88/0xcc
[  263.870242] [c7793790] [c000f434] ret_from_except+0x0/0x18
[  263.875653] [c7793850] [00000000] (null)
[  263.879567] [c7793860] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.885416] [c7793920] [00000000] (null)
[  263.889336] [c7793930] [c0052554] handle_level_irq+0x54/0x128
[  263.895030] [c7793940] [c0004dd8] do_IRQ+0x88/0xcc
[  263.899790] [c7793950] [c000f434] ret_from_except+0x0/0x18
[  263.905201] [c7793a10] [00000000] (null)
[  263.909115] [c7793a20] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.914971] do_IRQ: stack overflow: 1472
[  263.918843] Call Trace:
[  263.921304] [c77925c0] [c00073ac] show_stack+0x80/0x19c (unreliable)
[  263.927600] [c7792600] [c0004d98] do_IRQ+0x48/0xcc
[  263.932357] [c7792610] [c000f434] ret_from_except+0x0/0x18
[  263.937791] [c77926d0] [3b9aca00] 0x3b9aca00
[  263.942035] [c77926e0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.947899] [c77927a0] [3b9aca00] 0x3b9aca00
[  263.952151] [c77927b0] [c0052554] handle_level_irq+0x54/0x128
[  263.957842] [c77927c0] [c0004dd8] do_IRQ+0x88/0xcc
[  263.962603] [c77927d0] [c000f434] ret_from_except+0x0/0x18
[  263.968014] [c7792890] [00000000] (null)
[  263.971928] [c77928a0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  263.977777] [c7792960] [00000000] (null)
[  263.981697] [c7792970] [c0052554] handle_level_irq+0x54/0x128
[  263.987390] [c7792980] [c0004dd8] do_IRQ+0x88/0xcc
[  263.992152] [c7792990] [c000f434] ret_from_except+0x0/0x18
[  263.997563] [c7792a50] [00000000] (null)
[  264.001476] [c7792a60] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.007326] [c7792b20] [00000000] (null)
[  264.011246] [c7792b30] [c0052554] handle_level_irq+0x54/0x128
[  264.016939] [c7792b40] [c0004dd8] do_IRQ+0x88/0xcc
[  264.021701] [c7792b50] [c000f434] ret_from_except+0x0/0x18
[  264.027111] [c7792c10] [00000000] (null)
[  264.031025] [c7792c20] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.036875] [c7792ce0] [00000000] (null)
[  264.040796] [c7792cf0] [c0052554] handle_level_irq+0x54/0x128
[  264.046488] [c7792d00] [c0004dd8] do_IRQ+0x88/0xcc
[  264.051250] [c7792d10] [c000f434] ret_from_except+0x0/0x18
[  264.056661] [c7792dd0] [00000000] (null)
[  264.060574] [c7792de0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.066424] [c7792ea0] [00000000] (null)
[  264.070344] [c7792eb0] [c0052554] handle_level_irq+0x54/0x128
[  264.076037] [c7792ec0] [c0004dd8] do_IRQ+0x88/0xcc
[  264.080799] [c7792ed0] [c000f434] ret_from_except+0x0/0x18
[  264.086209] [c7792f90] [00000000] (null)
[  264.090123] [c7792fa0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.095972] [c7793060] [00000000] (null)
[  264.099893] [c7793070] [c0052554] handle_level_irq+0x54/0x128
[  264.105586] [c7793080] [c0004dd8] do_IRQ+0x88/0xcc
[  264.110347] [c7793090] [c000f434] ret_from_except+0x0/0x18
[  264.115758] [c7793150] [00000000] (null)
[  264.119672] [c7793160] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.125521] [c7793220] [00000000] (null)
[  264.129441] [c7793230] [c0052554] handle_level_irq+0x54/0x128
[  264.135134] [c7793240] [c0004dd8] do_IRQ+0x88/0xcc
[  264.139896] [c7793250] [c000f434] ret_from_except+0x0/0x18
[  264.145307] [c7793310] [00000000] (null)
[  264.149221] [c7793320] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.155070] [c77933e0] [00000000] (null)
[  264.158990] [c77933f0] [c0052554] handle_level_irq+0x54/0x128
[  264.164684] [c7793400] [c0004dd8] do_IRQ+0x88/0xcc
[  264.169446] [c7793410] [c000f434] ret_from_except+0x0/0x18
[  264.174856] [c77934d0] [00000000] (null)
[  264.178770] [c77934e0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.184619] [c77935a0] [00000000] (null)
[  264.188540] [c77935b0] [c0052554] handle_level_irq+0x54/0x128
[  264.194233] [c77935c0] [c0004dd8] do_IRQ+0x88/0xcc
[  264.198994] [c77935d0] [c000f434] ret_from_except+0x0/0x18
[  264.204405] [c7793690] [00000000] (null)
[  264.208320] [c77936a0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.214168] [c7793760] [00000000] (null)
[  264.218088] [c7793770] [c0052554] handle_level_irq+0x54/0x128
[  264.223782] [c7793780] [c0004dd8] do_IRQ+0x88/0xcc
[  264.228543] [c7793790] [c000f434] ret_from_except+0x0/0x18
[  264.233953] [c7793850] [00000000] (null)
[  264.237867] [c7793860] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.243723] do_IRQ: stack overflow: 1024
[  264.247595] Call Trace:
[  264.250053] [c7792400] [c00073ac] show_stack+0x80/0x19c (unreliable)
[  264.256352] [c7792440] [c0004d98] do_IRQ+0x48/0xcc
[  264.261109] [c7792450] [c000f434] ret_from_except+0x0/0x18
[  264.266542] [c7792510] [3b9aca00] 0x3b9aca00
[  264.270787] [c7792520] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.276651] [c77925e0] [3b9aca00] 0x3b9aca00
[  264.280903] [c77925f0] [c0052554] handle_level_irq+0x54/0x128
[  264.286595] [c7792600] [c0004dd8] do_IRQ+0x88/0xcc
[  264.291355] [c7792610] [c000f434] ret_from_except+0x0/0x18
[  264.296782] [c77926d0] [3b9aca00] 0x3b9aca00
[  264.301027] [c77926e0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.306891] [c77927a0] [3b9aca00] 0x3b9aca00
[  264.311142] [c77927b0] [c0052554] handle_level_irq+0x54/0x128
[  264.316835] [c77927c0] [c0004dd8] do_IRQ+0x88/0xcc
[  264.321595] [c77927d0] [c000f434] ret_from_except+0x0/0x18
[  264.327006] [c7792890] [00000000] (null)
[  264.330920] [c77928a0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.336769] [c7792960] [00000000] (null)
[  264.340689] [c7792970] [c0052554] handle_level_irq+0x54/0x128
[  264.346383] [c7792980] [c0004dd8] do_IRQ+0x88/0xcc
[  264.351144] [c7792990] [c000f434] ret_from_except+0x0/0x18
[  264.356555] [c7792a50] [00000000] (null)
[  264.360469] [c7792a60] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.366318] [c7792b20] [00000000] (null)
[  264.370238] [c7792b30] [c0052554] handle_level_irq+0x54/0x128
[  264.375932] [c7792b40] [c0004dd8] do_IRQ+0x88/0xcc
[  264.380693] [c7792b50] [c000f434] ret_from_except+0x0/0x18
[  264.386104] [c7792c10] [00000000] (null)
[  264.390018] [c7792c20] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.395867] [c7792ce0] [00000000] (null)
[  264.399787] [c7792cf0] [c0052554] handle_level_irq+0x54/0x128
[  264.405481] [c7792d00] [c0004dd8] do_IRQ+0x88/0xcc
[  264.410242] [c7792d10] [c000f434] ret_from_except+0x0/0x18
[  264.415653] [c7792dd0] [00000000] (null)
[  264.419566] [c7792de0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.425416] [c7792ea0] [00000000] (null)
[  264.429336] [c7792eb0] [c0052554] handle_level_irq+0x54/0x128
[  264.435030] [c7792ec0] [c0004dd8] do_IRQ+0x88/0xcc
[  264.439792] [c7792ed0] [c000f434] ret_from_except+0x0/0x18
[  264.445201] [c7792f90] [00000000] (null)
[  264.449116] [c7792fa0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.454964] [c7793060] [00000000] (null)
[  264.458888] [c7793070] [c0052554] handle_level_irq+0x54/0x128
[  264.464578] [c7793080] [c0004dd8] do_IRQ+0x88/0xcc
[  264.469341] [c7793090] [c000f434] ret_from_except+0x0/0x18
[  264.474750] [c7793150] [00000000] (null)
[  264.478665] [c7793160] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.484513] [c7793220] [00000000] (null)
[  264.488436] [c7793230] [c0052554] handle_level_irq+0x54/0x128
[  264.494126] [c7793240] [c0004dd8] do_IRQ+0x88/0xcc
[  264.498889] [c7793250] [c000f434] ret_from_except+0x0/0x18
[  264.504299] [c7793310] [00000000] (null)
[  264.508213] [c7793320] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.514062] [c77933e0] [00000000] (null)
[  264.517985] [c77933f0] [c0052554] handle_level_irq+0x54/0x128
[  264.523675] [c7793400] [c0004dd8] do_IRQ+0x88/0xcc
[  264.528438] [c7793410] [c000f434] ret_from_except+0x0/0x18
[  264.533848] [c77934d0] [00000000] (null)
[  264.537762] [c77934e0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.543611] [c77935a0] [00000000] (null)
[  264.547532] [c77935b0] [c0052554] handle_level_irq+0x54/0x128
[  264.553225] [c77935c0] [c0004dd8] do_IRQ+0x88/0xcc
[  264.557986] [c77935d0] [c000f434] ret_from_except+0x0/0x18
[  264.563397] [c7793690] [00000000] (null)
[  264.567312] [c77936a0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.573166] do_IRQ: stack overflow: 576
[  264.576952] Call Trace:
[  264.579413] [c7792240] [c00073ac] show_stack+0x80/0x19c (unreliable)
[  264.585709] [c7792280] [c0004d98] do_IRQ+0x48/0xcc
[  264.590466] [c7792290] [c000f434] ret_from_except+0x0/0x18
[  264.595899] [c7792350] [3b9aca00] 0x3b9aca00
[  264.600143] [c7792360] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.606008] [c7792420] [3b9aca00] 0x3b9aca00
[  264.610260] [c7792430] [c0052554] handle_level_irq+0x54/0x128
[  264.615951] [c7792440] [c0004dd8] do_IRQ+0x88/0xcc
[  264.620712] [c7792450] [c000f434] ret_from_except+0x0/0x18
[  264.626139] [c7792510] [3b9aca00] 0x3b9aca00
[  264.630384] [c7792520] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.636247] [c77925e0] [3b9aca00] 0x3b9aca00
[  264.640499] [c77925f0] [c0052554] handle_level_irq+0x54/0x128
[  264.646191] [c7792600] [c0004dd8] do_IRQ+0x88/0xcc
[  264.650952] [c7792610] [c000f434] ret_from_except+0x0/0x18
[  264.656379] [c77926d0] [3b9aca00] 0x3b9aca00
[  264.660624] [c77926e0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.666487] [c77927a0] [3b9aca00] 0x3b9aca00
[  264.670738] [c77927b0] [c0052554] handle_level_irq+0x54/0x128
[  264.676431] [c77927c0] [c0004dd8] do_IRQ+0x88/0xcc
[  264.681192] [c77927d0] [c000f434] ret_from_except+0x0/0x18
[  264.686603] [c7792890] [00000000] (null)
[  264.690517] [c77928a0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.696366] [c7792960] [00000000] (null)
[  264.700286] [c7792970] [c0052554] handle_level_irq+0x54/0x128
[  264.705980] [c7792980] [c0004dd8] do_IRQ+0x88/0xcc
[  264.710741] [c7792990] [c000f434] ret_from_except+0x0/0x18
[  264.716152] [c7792a50] [00000000] (null)
[  264.720065] [c7792a60] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.725915] [c7792b20] [00000000] (null)
[  264.729835] [c7792b30] [c0052554] handle_level_irq+0x54/0x128
[  264.735528] [c7792b40] [c0004dd8] do_IRQ+0x88/0xcc
[  264.740290] [c7792b50] [c000f434] ret_from_except+0x0/0x18
[  264.745700] [c7792c10] [00000000] (null)
[  264.749614] [c7792c20] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.755464] [c7792ce0] [00000000] (null)
[  264.759384] [c7792cf0] [c0052554] handle_level_irq+0x54/0x128
[  264.765077] [c7792d00] [c0004dd8] do_IRQ+0x88/0xcc
[  264.769838] [c7792d10] [c000f434] ret_from_except+0x0/0x18
[  264.775249] [c7792dd0] [00000000] (null)
[  264.779163] [c7792de0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.785013] [c7792ea0] [00000000] (null)
[  264.788933] [c7792eb0] [c0052554] handle_level_irq+0x54/0x128
[  264.794626] [c7792ec0] [c0004dd8] do_IRQ+0x88/0xcc
[  264.799387] [c7792ed0] [c000f434] ret_from_except+0x0/0x18
[  264.804798] [c7792f90] [00000000] (null)
[  264.808712] [c7792fa0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.814561] [c7793060] [00000000] (null)
[  264.818481] [c7793070] [c0052554] handle_level_irq+0x54/0x128
[  264.824174] [c7793080] [c0004dd8] do_IRQ+0x88/0xcc
[  264.828936] [c7793090] [c000f434] ret_from_except+0x0/0x18
[  264.834347] [c7793150] [00000000] (null)
[  264.838261] [c7793160] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.844110] [c7793220] [00000000] (null)
[  264.848030] [c7793230] [c0052554] handle_level_irq+0x54/0x128
[  264.853723] [c7793240] [c0004dd8] do_IRQ+0x88/0xcc
[  264.858485] [c7793250] [c000f434] ret_from_except+0x0/0x18
[  264.863895] [c7793310] [00000000] (null)
[  264.867809] [c7793320] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.873659] [c77933e0] [00000000] (null)
[  264.877579] [c77933f0] [c0052554] handle_level_irq+0x54/0x128
[  264.883272] [c7793400] [c0004dd8] do_IRQ+0x88/0xcc
[  264.888034] [c7793410] [c000f434] ret_from_except+0x0/0x18
[  264.893445] [c77934d0] [00000000] (null)
[  264.897359] [c77934e0] [c000f3e8] ret_from_except_full+0x0/0x4c
[  264.903213] do_IRQ: stack overflow: 128
[  264.907000] Call Trace:
[  264.909444] Kernel stack overflow in process c6cea0a0, r1=c77920a0
[  264.915569] NIP: c0003e84 LR: c0018114 CTR: c00180f8
[  264.920498] REGS: c7791ff0 TRAP: 0700   Not tainted  (2.6.34)
[  264.926185] MSR: 00021030 <ME,CE,IR,DR>  CR: 44000088  XER: 00000000
[  264.932505] TASK = c6cea0a0[241] 'SoftNoy' THREAD: c7792000
[  264.937850] GPR00: c0052554 c77920a0 c6cea0a0 00000015 c05a7ad4 ffffffff c0154414 00000000
[  264.946142] GPR08: c05c60e0 c05a51bc c05c6584 ffffffff 06cea2a8 100265c8 00000000 1007c600
[  264.954436] GPR16: 100acd0c c7793daf 0000000f c7793daf 00000036 c0242f89 000003e8 c7793d98
[  264.962731] GPR24: 00000001 3b9aca00 00000000 00029030 c7793da0 c05a5780 00000015 c05a7ad4
[  264.971230] NIP [c0003e84] virq_to_hw+0x0/0x14
[  264.975653] LR [c0018114] xilinx_intc_mask+0x1c/0x54
[  264.980528] Call Trace:
[  264.982947] Instruction dump:
[  264.985889] 0000057f 0000078f 0000058f 0000079f 0000059f 000007af 000005af 000007bf
[  264.993576] 000005bf 000007cf 000005cf 000007df <000005df> 000007ef 000005ef 000007ff
[  265.001447] Kernel panic - not syncing: kernel stack overflow
[  265.007137] Call Trace:
[  265.009580] Rebooting in 180 seconds..

I have a hard time understanding the cause of the problem. It may very well be the hardware as my code works fine on a 
different but very similar piece of hardware.
Does the above mean that Linux is crashing in the do_IRQ routine, before even entering my own interrupt function ?

The electronics guys assure me that only ONE interrupt signal is sent to the processor...
Any lead ?


On Tuesday 05 July 2011 16:19:50 Guillaume Dargaud wrote:
> Hello all,
> one of my drivers is causing a kernel panic and I _think_ it happens in the
> 1st call to the interrupt routine. What kind of information can I extract
> from the following ?
> Is it like a core dump that I can load with the executable in the debugger
> to know exactly what happened (I doubt it) ?
> 
> Oops: Exception in kernel mode, sig: 4 [#1]
> Xilinx Virtex
> last sysfs file:
> Modules linked in: xad
> NIP: c0002328 LR: c0011de8 CTR: c001d77c
> REGS: c778de20 TRAP: 0700   Not tainted  (2.6.34)
> MSR: 00021030 <ME,CE,IR,DR>  CR: 24000044  XER: 00000000
> TASK = c6ce80a0[241] 'SoftNoy' THREAD: c778c000
> GPR00: 00000000 c778ded0 c6ce80a0 00000026 c6dbe000 00000000 e146dcab
> 00000000 GPR08: 02134be0 00000000 000020e7 00000001 000020e6 100265d8
> 00000000 1007c600 GPR16: 100acd0c 100822e4 1009024d bfa39a48 c7452080
> c05bf0e8 c05bf02c c0207d6c GPR24: c778c03c 00000004 c6cc7040 c05c1b88
> 00000001 00000004 c6cc73c0 00000026 NIP [c0002328] set_context+0x0/0x10
> LR [c0011de8] switch_mmu_context+0x194/0x1b8
> Call Trace:
> [c778ded0] [c001a810] pick_next_task_fair+0xec/0x130 (unreliable)
> [c778def0] [c0203514] schedule+0x300/0x394
> [c778df40] [c000f63c] recheck+0x0/0x24
> Instruction dump:
> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000 00000000 <00000000> 00000000 00000000 00000000
> Kernel stack overflow in process c6ce80a0, r1=c778c070
> NIP: c000d270 LR: c000f3c8 CTR: c0017fd0
> REGS: c778bfc0 TRAP: 0501   Tainted: G      D     (2.6.34)
> MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 24000048  XER: 00000000
> TASK = c6ce80a0[241] 'SoftNoy' THREAD: c778c000
> GPR00: 00029030 c778c070 c6ce80a0 c778c090 08000000 ffff32d8 00000001
> 00000001 GPR08: ffff32da 00000000 00021032 c000d110 06ce82a8
> NIP [c000d270] program_check_exception+0x160/0x228
> LR [c000f3c8] ret_from_except_full+0x0/0x4c
> Call Trace:
> Instruction dump:
> 38090004 901f0080 480000d8 3ca00003 7fe4fb78 80df0080 60a50001 38600005
> 480000a8 7c0000a6 60008000 7c000124 <77c00c04> 41a20068 4bffef89 2f83fff2
> Kernel panic - not syncing: kernel stack overflow
> Call Trace:
> Rebooting in 180 seconds..
> 
> My driver is xad.ko, though /dev/xps-acqui-data. The user program is
> SoftNoy. The code for the ISR (note that this code works fine on the same
> driver for a slightly different piece of custom hardware):
> 
> static irqreturn_t XadIsr(int irq, void *dev_id) {
> 	Xad.control_reg->fin_in = 0;
> 	Xad.interrupt_reg->ISR  = 1;
> 	Xad.interrupt_IPIF_reg->ISR = 4;
> 
> 	Xad.control_reg->flux_address[0] = BUFFER_PHY_BASE + BUF_SZ*(++Xad.Icnt %
> BUF_NB); Xad.control_reg->flux_address[1] =
> Xad.control_reg->flux_address[0] + BUF_SZ/2;
> 
> 	if (Xad.Icnt<Xad.Rcnt+BUF_NB)
> 		Xad.control_reg->flux_start=255;	// Arm the next interrupt
> 	else {
> 		// There aren't any buffers available for the next read. We'll do the
> start in the read routine Xad.Suspended=1;
> 		Xad.OverflowsSinceLastRead++;
> 		Xad.Overflow++;
> 		DBG_ADD_CHAR('*');
> 		if (Verbose) printk(KERN_WARNING SD "%dth buffer overflow:
> %d-%d=%d>=%d\n" FL, Xad.Overflow, Xad.Icnt, Xad.Rcnt, Xad.Icnt-Xad.Rcnt,
> BUF_NB);
> 	}
> 
> 	wake_up_interruptible(&Xad.wait);
> 	return IRQ_HANDLED;
> }

-- 
Guillaume Dargaud
http://www.gdargaud.net/
