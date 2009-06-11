Return-Path: <ricardo.ribalda@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5F47CB7136
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 05:24:12 +1000 (EST)
Received: from mail-bw0-f219.google.com (mail-bw0-f219.google.com
	[209.85.218.219]) by ozlabs.org (Postfix) with ESMTP id 91F6DDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 05:24:10 +1000 (EST)
Received: by bwz19 with SMTP id 19so1779703bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 12:24:07 -0700 (PDT)
MIME-Version: 1.0
Sender: ricardo.ribalda@gmail.com
In-Reply-To: <1244568361.25223.16.camel@localhost>
References: <1244216069.21470.12.camel@localhost>
	<1244568361.25223.16.camel@localhost>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Date: Thu, 11 Jun 2009 21:15:26 +0200
Message-ID: <aa76a2be0906111215j15933053rf128f1985a982ca0@mail.gmail.com>
Subject: Re: SD card over (xilinx_)SPI, timeout error while CID
To: Joachim Foerster <JOFT@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: joachim@missinglinkelectronics.com, dbrownell@users.sourceforge.net,
	hp@axis.com, lorenz@missinglinkelectronics.com,
	linuxppc-dev@ozlabs.org, mike@steroidmicros.com,
	pierre@ossman.eu, jan.nikitenko@gmail.com, john.linn@xilinx.com,
	linuxkernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

   It seems that I am facing the same problem!. I attach another trace
that also shows the sd I/O.

 I have also commented out the dma line at probe and no better results....

  As you point, the card is unable to reply the cid. But not only
that, after that failure the card replyies allways FF!!! So it seems
that after that command the card is "dead"

  I have tried with spi modes 3 and 0, having the same results.

          Best regards

[   48.539108] irq: irq 16 on host
/plb@0/interrupt-controller@87000000 mapped to virtual irq 27
[   48.570049] xilinx-xps-spi 8a000000.xps-spi: at 0x8A000000 mapped
to 0xD93A0000, irq=27
[   48.600625] Xilinx SPI: change mode 0, 0 bits/w, 0 cs_high
[   48.622642] Xilins SPI: cs off
[   48.853914] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   48.875780] Xilins SPI: cs off
[   48.895013] mmc_spi spi1.0: ASSUMING SPI bus stays unshared!
[   48.921849] mmc0: clock 0Hz busmode 0 powermode 0 cs 0 Vdd 0 width 0 timing 0
[   48.945429] mmc0: clock 0Hz busmode 2 powermode 1 cs 1 Vdd 21 width
0 timing 0
[   48.968949] mmc_spi spi1.0: mmc_spi: power up (21)
[   48.990098] mmc_spi spi1.0: SD/MMC host mmc0, no DMA, no WP, no
poweroff, cd polling
[   49.014178] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21
width 0 timing 0
[   49.038579] mmc_spi spi1.0: mmc_spi: power on (21)
[   49.059543] Xilinx SPI: cs on
[   49.078528] Spi  Transfer at 0x8A000000
[   49.098000] Sending 29 bytes
[   49.099687] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   49.119458] roff ff ff ff ff ff ff ff ff ff ff ff ff
[   49.161376] Received 29 bytes
[   49.163329] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   49.183066] ff ff ff ff ff ff ff ff ff ff ff ff ff
[   49.218076] Xilinx SPI: cs on
[   49.235595] Spi  Transfer at 0x8A000000
[   49.254150] Sending 10 bytes
[   49.255804] ff ff ff ff ff ff ff ff ff ff
[   49.289548] Received 10 bytes
[   49.291330] ff ff ff ff ff ff ff ff ff ff
[   49.324085] Xilinx SPI: change mode 7, 8 bits/w, 4 cs_high
[   49.343351] Xilins SPI: cs off
[   49.359698] Xilinx SPI: cs on
[   49.375759] Spi  Transfer at 0x8A000000
[   49.392781] Sending 18 bytes
[   49.394467] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   49.412181] ff ff
[   49.441053] Received 18 bytes
[   49.442834] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   49.460487] ff ff
[   49.489213] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   49.507989] Xilins SPI: cs off
[   49.524119] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   49.542881] Xilins SPI: cs off
[   49.558995] mmc_spi spi1.0: mmc_spi:  clock to 400000 Hz, 0
[   49.592549] mmc0: starting CMD0 arg 00000000 flags 000000c0
[   49.611249] mmc_spi spi1.0:   mmc_spi: CMD0, resp R1
[   49.629037] Xilinx SPI: cs on
[   49.644017] Spi  Transfer at 0x8A000000
[   49.660436] Sending 17 bytes
[   49.662539] ff 40 00 00 00 00 95 ff ff ff ff ff ff ff ff ff
[   49.679625] ff
[   49.706964] Received 17 bytes
[   49.709175] ff ff ff ff ff ff ff ff 01 ff ff ff ff ff ff ff
[   49.725994] ff
[   49.752770] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   49.770409] Xilins SPI: cs off
[   49.785069] mmc0: req done (CMD0): 0: 00000001 00000000 00000000 00000000
[   49.804839] mmc0: starting CMD8 arg 000001aa flags 000002f5
[   49.822469] mmc_spi spi1.0:   mmc_spi: CMD8, resp R3/R4/R7
[   49.839895] Xilinx SPI: cs on
[   49.854839] Spi  Transfer at 0x8A000000
[   49.870638] Sending 21 bytes
[   49.872294] ff 48 00 00 01 aa 87 ff ff ff ff ff ff ff ff ff
[   49.889218] ff ff ff ff ff
[   49.916288] Received 21 bytes
[   49.918498] ff ff ff ff ff ff ff ff 01 00 00 01 aa ff ff ff
[   49.935246] ff ff ff ff ff
[   49.962416] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   49.980219] Xilins SPI: cs off
[   49.995410] mmc0: req done (CMD8): 0: 00000001 000001aa 00000000 00000000
[   50.014912] mmc0: starting CMD5 arg 00000000 flags 000002e1
[   50.033278] mmc_spi spi1.0:   mmc_spi: CMD5, resp R3/R4/R7
[   50.051561] Xilinx SPI: cs on
[   50.067193] Spi  Transfer at 0x8A000000
[   50.083948] Sending 21 bytes
[   50.086041] ff 45 00 00 00 00 5b ff ff ff ff ff ff ff ff ff
[   50.103588] ff ff ff ff ff
[   50.132604] Received 21 bytes
[   50.134387] ff ff ff ff ff ff ff ff 05 ff ff ff ff ff ff ff
[   50.151844] ff ff ff ff ff
[   50.180735] mmc_spi spi1.0:   ... CMD5 response SPI_R3/R4/R: resp
0005 ffffffff
[   50.201467] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   50.220507] Xilins SPI: cs off
[   50.236890] mmc0: req done (CMD5): -22: 00000005 ffffffff 00000000 00000000
[   50.257701] mmc0: starting CMD55 arg 00000000 flags 000000f5
[   50.277204] mmc_spi spi1.0:   mmc_spi: CMD55, resp R1
[   50.296051] Xilinx SPI: cs on
[   50.312639] Spi  Transfer at 0x8A000000
[   50.330024] Sending 17 bytes
[   50.331710] ff 77 00 00 00 00 65 ff ff ff ff ff ff ff ff ff
[   50.349786] ff
[   50.379487] Received 17 bytes
[   50.381697] ff ff ff ff ff ff ff ff 01 ff ff ff ff ff ff ff
[   50.399768] ff
[   50.429230] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   50.448429] Xilins SPI: cs off
[   50.465013] mmc0: req done (CMD55): 0: 00000001 00000000 00000000 00000000
[   50.485866] mmc0: starting CMD41 arg 00000000 flags 000000e1
[   50.505616] mmc_spi spi1.0:   mmc_spi: CMD41, resp R1
[   50.524494] Xilinx SPI: cs on
[   50.541042] Spi  Transfer at 0x8A000000
[   50.558421] Sending 17 bytes
[   50.560106] ff 69 00 00 00 00 e5 ff ff ff ff ff ff ff ff ff
[   50.578141] ff
[   50.607645] Received 17 bytes
[   50.609850] ff ff ff ff ff ff ff ff 01 ff ff ff ff ff ff ff
[   50.627891] ff
[   50.657292] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   50.676490] Xilins SPI: cs off
[   50.693073] mmc0: req done (CMD41): 0: 00000001 00000000 00000000 00000000
[   50.713950] mmc0: starting CMD0 arg 00000000 flags 000000c0
[   50.733526] mmc_spi spi1.0:   mmc_spi: CMD0, resp R1
[   50.752333] Xilinx SPI: cs on
[   50.768877] Spi  Transfer at 0x8A000000
[   50.786234] Sending 17 bytes
[   50.787927] ff 40 00 00 00 00 95 ff ff ff ff ff ff ff ff ff
[   50.805943] ff
[   50.835559] Received 17 bytes
[   50.837768] ff ff ff ff ff ff ff ff 00 ff ff ff ff ff ff ff
[   50.855765] ff
[   50.885197] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   50.904434] Xilins SPI: cs off
[   50.921092] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[   50.942690] mmc0: starting CMD58 arg 00000000 flags 00000280
[   50.961863] mmc_spi spi1.0:   mmc_spi: CMD58, resp R3/R4/R7
[   50.981057] Xilinx SPI: cs on
[   50.997358] Spi  Transfer at 0x8A000000
[   51.014356] Sending 21 bytes
[   51.016048] ff 7a 00 00 00 00 fd ff ff ff ff ff ff ff ff ff
[   51.033727] ff ff ff ff ff
[   51.063147] Received 21 bytes
[   51.065361] ff ff ff ff ff ff ff ff 00 00 7f 80 00 7f ff ff
[   51.082985] ff ff ff ff ff
[   51.111831] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   51.130578] Xilins SPI: cs off
[   51.146636] mmc0: req done (CMD58): 0: 00000000 007f8000 00000000 00000000
[   51.167049] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 20
width 0 timing 0
[   51.188667] mmc0: starting CMD0 arg 00000000 flags 000000c0
[   51.208074] mmc_spi spi1.0:   mmc_spi: CMD0, resp R1
[   51.226728] Xilinx SPI: cs on
[   51.243154] Spi  Transfer at 0x8A000000
[   51.260387] Sending 17 bytes
[   51.262487] ff 40 00 00 00 00 95 ff ff ff ff ff ff ff ff ff
[   51.280453] ff
[   51.309719] Received 17 bytes
[   51.311501] ff ff ff ff ff ff ff ff 00 ff ff ff ff ff ff ff
[   51.329336] ff
[   51.358446] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   51.377485] Xilins SPI: cs off
[   51.393875] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[   51.415465] mmc0: starting CMD8 arg 000001aa flags 000002f5
[   51.434899] mmc_spi spi1.0:   mmc_spi: CMD8, resp R3/R4/R7
[   51.454224] Xilinx SPI: cs on
[   51.470813] Spi  Transfer at 0x8A000000
[   51.488233] Sending 21 bytes
[   51.490336] ff 48 00 00 01 aa 87 ff ff ff ff ff ff ff ff ff
[   51.508496] ff ff ff ff ff
[   51.538541] Received 21 bytes
[   51.540323] ff ff ff ff ff ff ff ff 00 00 00 00 80 7f ff ff
[   51.558375] ff ff ff ff ff
[   51.588247] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   51.607401] Xilins SPI: cs off
[   51.623861] mmc0: req done (CMD8): 0: 00000000 00000080 00000000 00000000
[   51.644516] mmc0: starting CMD55 arg 00000000 flags 000000f5
[   51.664028] mmc_spi spi1.0:   mmc_spi: CMD55, resp R1
[   51.682831] Xilinx SPI: cs on
[   51.699284] Spi  Transfer at 0x8A000000
[   51.716597] Sending 17 bytes
[   51.718281] ff 77 00 00 00 00 65 ff ff ff ff ff ff ff ff ff
[   51.736204] ff
[   51.765505] Received 17 bytes
[   51.767288] ff ff ff ff ff ff ff ff 00 ff ff ff ff ff ff ff
[   51.785197] ff
[   51.814313] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   51.833614] Xilins SPI: cs off
[   51.850111] mmc0: req done (CMD55): 0: 00000000 00000000 00000000 00000000
[   51.870983] mmc0: starting CMD41 arg 00000000 flags 000000e1
[   51.890595] mmc_spi spi1.0:   mmc_spi: CMD41, resp R1
[   51.909383] Xilinx SPI: cs on
[   51.925698] Spi  Transfer at 0x8A000000
[   51.942753] Sending 17 bytes
[   51.944443] ff 69 00 00 00 00 e5 ff ff ff ff ff ff ff ff ff
[   51.962122] ff
[   51.990760] Received 17 bytes
[   51.992969] ff ff ff ff ff ff ff ff 00 ff ff ff ff ff ff ff
[   52.010627] ff
[   52.039135] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   52.057943] Xilins SPI: cs off
[   52.074081] mmc0: req done (CMD41): 0: 00000000 00000000 00000000 00000000
[   52.094569] mmc0: starting CMD10 arg 00000000 flags 000000b5
[   52.113755] mmc0:     blksz 16 blocks 1 flags 00000200 tsac 0 ms nsac 64
[   52.134240] mmc_spi spi1.0:   mmc_spi: CMD10, resp R1
[   52.152922] Xilinx SPI: cs on
[   52.169228] Spi  Transfer at 0x8A000000
[   52.186386] Sending 9 bytes
[   52.187978] ff 4a 00 00 00 00 1b ff ff
[   52.218225] Received 9 bytes
[   52.219911] ff ff ff ff ff ff ff ff 00
[   52.249970] mmc_spi spi1.0:     mmc_spi: read block, 16 bytes
[   52.269009] Xilinx SPI: cs on
[   52.285210] Spi  Transfer at 0x8A000000
[   52.302276] Sending 1 bytes
[   52.303867] ff
[   52.332598] Received 1 bytes
[   52.334287] ff
[   52.362345] Xilinx SPI: cs on
[   52.377675] Spi  Transfer at 0x8A000000
[   52.393815] Sending 1 bytes
[   52.395408] ff
[   52.422215] Received 1 bytes
[   52.423901] ff
[   52.450210] mmc_spi spi1.0: read error ffffff92 (-110)
[   52.467376] mmc_spi spi1.0: read status -110
[   52.483642] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   52.501298] Xilins SPI: cs off
[   52.516304] mmc0: req done (CMD10): 0: 00000000 00000000 00000000 00000000
[   52.535655] mmc0:     0 bytes transferred: -110
[   52.552762] mmc0: clock 0Hz busmode 2 powermode 0 cs 1 Vdd 0 width 0 timing 0
[   52.572513] mmc_spi spi1.0: mmc_spi: power off (0)
[   52.589792] mmc0: error -110 whilst initialising SD card
[   52.607573] mmc0: clock 0Hz busmode 2 powermode 0 cs 1 Vdd 0 width 0 timing 0
[   53.624548] mmc0: clock 0Hz busmode 2 powermode 1 cs 1 Vdd 21 width
0 timing 0
[   53.644565] mmc_spi spi1.0: mmc_spi: power up (21)
[   53.676546] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21
width 0 timing 0
[   53.697303] mmc_spi spi1.0: mmc_spi: power on (21)
[   53.715149] Xilinx SPI: cs on
[   53.730775] Spi  Transfer at 0x8A000000
[   53.747808] Sending 29 bytes
[   53.749948] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   53.767622] ff ff ff ff ff ff ff ff ff ff ff ff ff
[   53.798870] Received 29 bytes
[   53.801072] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   53.818374] ff ff ff ff ff ff ff ff ff ff ff ff ff
[   53.848277] Xilinx SPI: cs on
[   53.863238] Spi  Transfer at 0x8A000000
[   53.879061] Sending 10 bytes
[   53.881166] ff ff ff ff ff ff ff ff ff ff
[   53.909364] Received 10 bytes
[   53.911147] ff ff ff ff ff ff ff ff ff ff
[   53.939310] Xilinx SPI: change mode 7, 8 bits/w, 4 cs_high
[   53.957098] Xilins SPI: cs off
[   53.972202] Xilinx SPI: cs on
[   53.986965] Spi  Transfer at 0x8A000000
[   54.002665] Sending 18 bytes
[   54.004355] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   54.021148] ff ff
[   54.047531] Received 18 bytes
[   54.049733] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   54.066437] ff ff
[   54.093333] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   54.111278] Xilins SPI: cs off
[   54.140548] mmc0: starting CMD0 arg 00000000 flags 000000c0
[   54.158933] mmc_spi spi1.0:   mmc_spi: CMD0, resp R1
[   54.176873] Xilinx SPI: cs on
[   54.192659] Spi  Transfer at 0x8A000000
[   54.209382] Sending 17 bytes
[   54.211069] ff 40 00 00 00 00 95 ff ff ff ff ff ff ff ff ff
[   54.228464] ff
[   54.256364] Received 17 bytes
[   54.258571] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   54.275654] ff
[   54.302586] Xilinx SPI: cs on
[   54.317336] Spi  Transfer at 0x8A000000
[   54.332830] Sending 1 bytes
[   54.334422] ff
[   54.359834] Received 1 bytes
[   54.361977] ff
[   54.386246] Xilinx SPI: cs on
[   54.399699] Spi  Transfer at 0x8A000000
[   54.414165] Sending 1 bytes
[   54.415758] ff
[   54.439100] Received 1 bytes
[   54.441213] ff
[   54.464491] Xilinx SPI: cs on
[   54.477571] Spi  Transfer at 0x8A000000
[   54.491746] Sending 1 bytes
[   54.493754] ff
[   54.516871] Received 1 bytes
[   54.518557] ff
[   54.541114] Xilinx SPI: cs on
[   54.554112] Spi  Transfer at 0x8A000000
[   54.568070] Sending 1 bytes
[   54.570080] ff
[   54.592080] Received 1 bytes
[   54.594181] ff
[   54.616269] Xilinx SPI: cs on
[   54.628831] Spi  Transfer at 0x8A000000
[   54.642295] Sending 1 bytes
[   54.643890] ff
[   54.665424] Received 1 bytes
[   54.667113] ff
[   54.688185] Xilinx SPI: cs on
[   54.700264] Spi  Transfer at 0x8A000000
[   54.713168] Sending 1 bytes
[   54.714763] ff
[   54.734877] Received 1 bytes
[   54.736982] ff
[   54.756293] Xilinx SPI: cs on
[   54.767659] Spi  Transfer at 0x8A000000
[   54.779759] Sending 1 bytes
[   54.781760] ff
[   54.800685] Received 1 bytes
[   54.802373] ff
[   54.820845] Xilinx SPI: cs on
[   54.831765] Spi  Transfer at 0x8A000000
[   54.843523] Sending 1 bytes
[   54.845534] ff
[   54.863879] Received 1 bytes
[   54.865974] ff
[   54.884263] Xilinx SPI: cs on
[   54.895068] Spi  Transfer at 0x8A000000
[   54.906798] Sending 1 bytes
[   54.908395] ff
[   54.926629] Received 1 bytes
[   54.928318] ff
[   54.946533] Xilinx SPI: cs on
[   54.957309] Spi  Transfer at 0x8A000000
[   54.969152] Sending 1 bytes
[   54.970749] ff
[   54.988934] Received 1 bytes
[   54.990621] ff
[   55.008869] Xilinx SPI: cs on
[   55.019781] Spi  Transfer at 0x8A000000
[   55.031652] Sending 1 bytes
[   55.033656] ff
[   55.052030] Received 1 bytes
[   55.054132] ff
[   55.072395] Xilinx SPI: cs on
[   55.083339] Spi  Transfer at 0x8A000000
[   55.095103] Sending 1 bytes
[   55.097114] ff
[   55.115411] Received 1 bytes
[   55.117515] ff
[   55.135872] Xilinx SPI: cs on
[   55.146757] Spi  Transfer at 0x8A000000
[   55.158515] Sending 1 bytes
[   55.160113] ff
[   55.178455] Received 1 bytes
[   55.180147] ff
[   55.198506] Xilinx SPI: cs on
[   55.209369] Spi  Transfer at 0x8A000000
[   55.221281] Sending 1 bytes
[   55.222873] ff
[   55.241289] Received 1 bytes
[   55.242978] ff
[   55.261376] Xilinx SPI: change mode 3, 8 bits/w, 0 cs_high
[   55.274774] Xilins SPI: cs off
[   55.286183] mmc0: req done (CMD0): -110: 00000000 00000000 00000000 00000000
[   55.303059] mmc0: starting CMD8 arg 000001aa flags 000002f5
[   55.317605] mmc_spi spi1.0:   mmc_spi: CMD8, resp R3/R4/R7
[   55.332234] Xilinx SPI: cs on
[   55.344288] Spi  Transfer at 0x8A000000
[   55.357357] Sending 21 bytes
[   55.359048] ff 48 00 00 01 aa 87 ff ff ff ff ff ff ff ff ff
[   55.373268] ff ff ff ff ff
[   55.395064] Received 21 bytes
[   55.397272] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   55.411374] ff ff ff ff ff
[   55.433854] Xilinx SPI: cs on
[   55.446394] Spi  Transfer at 0x8A000000
[   55.459800] Sending 1 bytes
[   55.461818] ff
[   55.483642] Received 1 bytes
[   55.485751] ff
[   55.507455] Xilinx SPI: cs on
[   55.520004] Spi  Transfer at 0x8A000000
[   55.533515] Sending 1 bytes
[   55.535105] ff
[   55.556813] Received 1 bytes
[   55.558502] ff
[   55.580275] Xilinx SPI: cs on
[   55.592791] Spi  Transfer at 0x8A000000
[   55.606171] Sending 1 bytes
[   55.607768] ff
[   55.629567] Received 1 bytes
[   55.631260] ff
[   55.653122] Xilinx SPI: cs on
[   55.665601] Spi  Transfer at 0x8A000000
[   55.679005] Sending 1 bytes
[   55.681015] ff
[   55.702801] Received 1 bytes
[   55.704492] ff
[   55.726140] Xilinx SPI: cs on
[   55.738660] Spi  Transfer at 0x8A000000
[   55.752158] Sending 1 bytes
[   55.754162] ff
[   55.775802] Received 1 bytes
[   55.777912] ff
[   55.799564] Xilinx SPI: cs on
[   55.811801] Spi  Transfer at 0x8A000000
[   55.824923] Sending 1 bytes
[   55.826514] ff
[   55.846619] Received 1 bytes
[   55.848304] ff
[   55.867579] Xilinx SPI: cs on
[   55.878762] Spi  Transfer at 0x8A000000
[   55.890810] Sending 1 bytes
[   55.892404] ff
[   55.911203] Received 1 bytes
[   55.913311] ff
[   55.931740] Xilinx SPI: cs on
[   55.942575] Spi  Transfer at 0x8A000000
[   55.954480] Sending 1 bytes
[   55.956073] ff
[   55.974448] Received 1 bytes
[   55.976134] ff
[   55.994486] Xilinx SPI: cs on
[   56.005406] Spi  Transfer at 0x8A000000
[   56.017305] Sending 1 bytes
[   56.018894] ff
[   56.037248] Received 1 bytes
[   56.038924] ff
[   56.057282] Xilinx SPI: cs on





-- 
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
