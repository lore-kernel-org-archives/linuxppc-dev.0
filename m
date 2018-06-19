Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419HcM0pr5zF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 05:10:57 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>, Meelis Roos <mroos@linux.ee>,
 netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
 <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com>
 <87o9g8geu0.fsf@igel.home>
 <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
 <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
 <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
 <dd6f13bc-c5f2-85f8-c08d-837bc024fc7c@gmail.com>
Date: Tue, 19 Jun 2018 21:10:50 +0200
In-Reply-To: <dd6f13bc-c5f2-85f8-c08d-837bc024fc7c@gmail.com> (Eric Dumazet's
 message of "Mon, 18 Jun 2018 16:36:15 -0700")
Message-ID: <87po0mvbgl.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Jun 18 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:

> DUMP_PREFIX_ADDRESS might give us more information (say alignment problem, or crossing page boundaries)

DUMP_PREFIX_ADDRESS is useless for that purpose.

Here are some samples of broken csums:

[  853.849225] sungem: sungem wrong csum : 9886/07be, len 94 bytes, c0000001fa187e02
[  853.849232] raw data: 00000000: 00 0d 93 43 81 62 18 d6 c7 51 b8 1c 08 00 45 10  ...C.b...Q....E.
[  853.849235] raw data: 00000010: 00 4c cb a0 40 00 40 11 d9 97 c0 a8 0a 01 c0 a8  .L..@.@.........
[  853.849237] raw data: 00000020: 0a 07 00 7b 00 7b 00 38 69 e1 1c 03 0c f7 00 00  ...{.{.8i.......
[  853.849240] raw data: 00000030: 08 f0 00 00 15 f0 c0 35 67 67 de d3 ca c9 d9 5b  .......5gg.....[
[  853.849242] raw data: 00000040: 1f ff de d3 d2 86 8f 67 fa f2 de d3 d2 86 8f 38  .......g.......8
[  853.849244] raw data: 00000050: 2f ff de d3 d2 86 8f 3b ff ff d1 93 bc 50        /......;.....P

[  857.883052] sungem: sungem wrong csum : dbb4/c48f, len 94 bytes, c0000001fa185882
[  857.883058] raw data: 00000000: 00 0d 93 43 81 62 18 d6 c7 51 b8 1c 08 00 45 00  ...C.b...Q....E.
[  857.883070] raw data: 00000010: 00 4c a1 97 40 00 3a 11 ce ed d9 5b 2c 11 c0 a8  .L..@.:....[,...
[  857.883080] raw data: 00000020: 0a 07 00 7b 00 7b 00 38 14 4b 24 02 06 ea 00 00  ...{.{.8.K$.....
[  857.883085] raw data: 00000030: 00 0b 00 00 02 99 c0 a8 64 09 de d3 d2 5a 36 e4  ........d....Z6.
[  857.883090] raw data: 00000040: bc f5 de d3 d2 8a 8f 2c 17 44 de d3 d2 8a 93 8b  .......,.D......
[  857.883094] raw data: 00000050: d7 b7 de d3 d2 8a 93 97 69 6e 39 7b d2 5a        ........in9{.Z

[  858.124689] sungem: sungem wrong csum : 1f4f/02d0, len 118 bytes, c0000001fa185602
[  858.124700] raw data: 00000000: 00 0d 93 43 81 62 d4 3d 7e 4c 48 b7 86 dd 61 01  ...C.b.=~LH...a.
[  858.124705] raw data: 00000010: 1e b1 00 3c 06 40 20 01 0a 62 17 11 88 01 00 00  ...<.@ ..b......
[  858.124709] raw data: 00000020: 00 00 00 00 0a 38 20 01 0a 62 17 11 88 01 00 00  .....8 ..b......
[  858.124714] raw data: 00000030: 00 00 00 00 00 07 94 b4 00 16 86 f5 29 e8 36 cb  ............).6.
[  858.124718] raw data: 00000040: 50 49 80 18 05 93 9a 53 00 00 01 01 08 0a 58 b2  PI.....S......X.
[  858.124723] raw data: 00000050: de 54 61 5f 2f 3c 00 00 00 10 cc 08 55 f7 da 21  .Ta_/<......U..!
[  858.124727] raw data: 00000060: f4 60 0a 6b 3c aa b9 b3 7e 61 10 b8 c2 be 9a 0b  .`.k<...~a......
[  858.124731] raw data: 00000070: c7 e9 5b 97 1b ac                                ..[...

[  858.126522] sungem: sungem wrong csum : 0836/19e9, len 90 bytes, c0000001fa185382
[  858.126530] raw data: 00000000: 00 0d 93 43 81 62 d4 3d 7e 4c 48 b7 86 dd 61 01  ...C.b.=~LH...a.
[  858.126532] raw data: 00000010: 1e b1 00 20 06 40 20 01 0a 62 17 11 88 01 00 00  ... .@ ..b......
[  858.126535] raw data: 00000020: 00 00 00 00 0a 38 20 01 0a 62 17 11 88 01 00 00  .....8 ..b......
[  858.126537] raw data: 00000030: 00 00 00 00 00 07 94 b4 00 16 86 f5 2a 04 36 cb  ............*.6.
[  858.126540] raw data: 00000040: 50 65 80 10 05 93 3e 56 00 00 01 01 08 0a 58 b2  Pe....>V......X.
[  858.126542] raw data: 00000050: de 56 61 5f 30 4d 1d 58 42 d2                    .Va_0M.XB.

[  858.131559] sungem: sungem wrong csum : 5891/c98d, len 90 bytes, c0000001fa185102
[  858.131567] raw data: 00000000: 00 0d 93 43 81 62 d4 3d 7e 4c 48 b7 86 dd 61 01  ...C.b.=~LH...a.
[  858.131570] raw data: 00000010: 1e b1 00 20 06 40 20 01 0a 62 17 11 88 01 00 00  ... .@ ..b......
[  858.131572] raw data: 00000020: 00 00 00 00 0a 38 20 01 0a 62 17 11 88 01 00 00  .....8 ..b......
[  858.131574] raw data: 00000030: 00 00 00 00 00 07 94 b4 00 16 86 f5 2a 04 36 cb  ............*.6.
[  858.131577] raw data: 00000040: 50 a1 80 10 05 93 3e 10 00 00 01 01 08 0a 58 b2  P.....>.......X.
[  858.131579] raw data: 00000050: de 5b 61 5f 30 52 3f ea 70 9b                    .[a_0R?.p.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
