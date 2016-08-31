Return-Path: <xdrudis@tinet.cat>
Received: from mx2.tinet.org (mx2.tinet.org [195.77.216.147])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sPXw34TW0zDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 03:49:54 +1000 (AEST)
Received: from smtp01.tinet.org (smtp01.tinet.org [195.77.216.131]) by
 mx2.tinet.org with ESMTP id r0ATvLwDIpMotCrl for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 19:49:49 +0200 (CEST)
Date: Wed, 31 Aug 2016 19:49:47 +0200
From: Xavi Drudis Ferran <xdrudis@tinet.cat>
To: Fabio Estevam <festevam@gmail.com>
Cc: Xavi Drudis Ferran <xdrudis@tinet.cat>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel] Setting some clocks back to DUMMY fixes spdif
 output on imx6q wandboard rev B1
Message-ID: <20160831174947.GA2018@begut>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
 <20160829195428.GD1967@begut> <20160830111414.GA1968@begut>
 <20160831042100.GA3308@Asurada> <20160831091013.GA3185@begut>
 <CAOMZO5AoCo9Faq7oWgRQUE0Hg+Pg+i6z8eg-qeLFDvwpoEqz_g@mail.gmail.com>
 <20160831134925.GB1967@begut>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160831134925.GB1967@begut>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

El Wed, Aug 31, 2016 at 03:49:25PM +0200, Xavi Drudis Ferran deia:
> El Wed, Aug 31, 2016 at 10:11:13AM -0300, Fabio Estevam deia:
> > 2. SPDIF clock rate not accurate. Probably using PLL4 as SPDIF source
> > would help to get more accurate SPDIF clock rates.
> > 
> > Could you please try the untested change?
> > 
> > --- a/drivers/clk/imx/clk-imx6q.c
> > +++ b/drivers/clk/imx/clk-imx6q.c
> > @@ -623,7 +623,7 @@ static void __init imx6q_clocks_init(struct
> > device_node *ccm_node)
> >                 pr_warn("failed to set up CLKO: %d\n", ret);
> > 
> >         /* Audio-related clocks configuration */
> > -       clk_set_parent(clk[IMX6QDL_CLK_SPDIF_SEL],
> > clk[IMX6QDL_CLK_PLL3_PFD3_454M]);
> > +       clk_set_parent(clk[IMX6QDL_CLK_SPDIF_SEL],
> > clk[IMX6QDL_CLK_PLL4_AUDIO_DIV]);
> > 
> >         /* All existing boards with PCIe use LVDS1 */
> >         if (IS_ENABLED(CONFIG_PCI_IMX6))
> >
> 
> I'm going to try. I'll take a while. I'll report the result later.
> 
> Thank you very much.

I just tried. Spdif output still works. I can't hear any difference. 

I've summarised the tests in a table:

Nominal    
Hz               32000      44100      48000      96000     192000
ns               31250      22676      20833      10417       5208

Linux-libre-4.7 (unchanged)   (no spdif output)                                                               
Hz               32226      43882      47965      95930     196428
ns               31031      22788      20849      10424       5091
deviation(ns)      219       -113        -15         -8        117

only core (SPDIF_GCLK), rxtx0 (CLK_OSC), rxtx1(SPDIF) & spba (spdif output)
Hz               31719      43859      47368      94736     187500
ns               31527      22800      21111      10556       5333
deviation(ns)     -277       -125       -278       -139       -125
 
without MLB (the rest  unchanged)   (spdif output)                         
Hz               32226      43859      47368      94736     187500
ns               31031      22800      21111      10556       5333
deviation(ns)      219       -125       -278       -139       -125

without MLB, and PLL4 instead of PLL3 for SPDIF (spdif output)               
Hz               32226      44836      49107      93750     187500
ns               31031      22304      20364      10667       5333
deviation(ns)      219        372        470       -250       -125

I saw page 121 of
http://cache.freescale.com/files/32bit/doc/data_sheet/IMX6DQIEC.pdf
And it seems like the the margin for the SPDIF clock would be 16 ns
so I've just inverted the frequencies to compare, but I'm not convinced
it's relevant. 

Here's the extract from dmesg with your patch (and .dtsi like mainline
except MLB replaced with DUMMY).

[...]
[    7.517394] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
[    7.578089] imx_thermal 2000000.aips-bus:tempmon: Extended Commercial CPU temperature grade - max:105C critical:100C passive:95C
[    7.594443] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
[    7.594454] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0
[    7.594459] etnaviv-gpu 2204000.gpu: hw init failed: -6
[    7.653041] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    7.656319] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.704159] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 32000Hz sample rate
[    7.711719] fsl-spdif-dai 2004000.spdif: use txclk df 16 for 32000Hz sample rate
[    7.718328] fsl-spdif-dai 2004000.spdif: use sysclk df 2 for 32000Hz sample rate
[    7.724762] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 32226Hz
[    7.732679] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.760087] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 44100Hz sample rate
[    7.766536] fsl-spdif-dai 2004000.spdif: use txclk df 1 for 44100Hz sample rate
[    7.772986] fsl-spdif-dai 2004000.spdif: use sysclk df 23 for 44100Hz sample rate
[    7.780120] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 44836Hz
[    7.788952] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.825238] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 48000Hz sample rate
[    7.831515] fsl-spdif-dai 2004000.spdif: use txclk df 7 for 48000Hz sample rate
[    7.837583] fsl-spdif-dai 2004000.spdif: use sysclk df 3 for 48000Hz sample rate
[    7.843718] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 49107Hz
[    7.849672] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.878632] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 96000Hz sample rate
[    7.884550] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 96000Hz sample rate
[    7.890390] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 93750Hz
[    7.896253] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.921228] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    7.927034] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    7.932809] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    7.938616] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[    7.944791] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    7.954697] fsl-asrc 2034000.asrc: driver registered
[    7.961411] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    7.967622] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.992427] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 32000Hz sample rate
[    7.998228] fsl-spdif-dai 2004000.spdif: use txclk df 16 for 32000Hz sample rate
[    8.004122] fsl-spdif-dai 2004000.spdif: use sysclk df 2 for 32000Hz sample rate
[    8.009806] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 32226Hz
[    8.015572] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.044534] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 44100Hz sample rate
[    8.050294] fsl-spdif-dai 2004000.spdif: use txclk df 1 for 44100Hz sample rate
[    8.056069] fsl-spdif-dai 2004000.spdif: use sysclk df 23 for 44100Hz sample rate
[    8.061869] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 44836Hz
[    8.067662] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.092093] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 48000Hz sample rate
[    8.097916] fsl-spdif-dai 2004000.spdif: use txclk df 7 for 48000Hz sample rate
[    8.103769] fsl-spdif-dai 2004000.spdif: use sysclk df 3 for 48000Hz sample rate
[    8.109660] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 49107Hz
[    8.115488] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.141250] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 96000Hz sample rate
[    8.147179] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 96000Hz sample rate
[    8.153066] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 93750Hz
[    8.158900] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.185506] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    8.191441] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    8.197297] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    8.203477] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[    8.210220] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    8.653296] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    8.678782] imx-spdif sound-spdif: ASoC: CPU DAI (null) not registered
[    8.682393] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.705822] imx-spdif sound-spdif: snd_soc_register_card failed: -517
[    8.735316] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 32000Hz sample rate
[    8.741460] fsl-spdif-dai 2004000.spdif: use txclk df 16 for 32000Hz sample rate
[    8.747889] fsl-spdif-dai 2004000.spdif: use sysclk df 2 for 32000Hz sample rate
[    8.754006] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 32226Hz
[    8.755063] sgtl5000 1-000a: sgtl5000 revision 0x11
[...]
[    8.776463] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.804281] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 44100Hz sample rate
[    8.810549] fsl-spdif-dai 2004000.spdif: use txclk df 1 for 44100Hz sample rate
[    8.816670] fsl-spdif-dai 2004000.spdif: use sysclk df 23 for 44100Hz sample rate
[    8.822881] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 44836Hz
[    8.829149] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.857633] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 48000Hz sample rate
[    8.864664] fsl-spdif-dai 2004000.spdif: use txclk df 7 for 48000Hz sample rate
[    8.871299] fsl-spdif-dai 2004000.spdif: use sysclk df 3 for 48000Hz sample rate
[    8.878169] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 49107Hz
[    8.885341] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.887272] 20ec000.sdma: Missing Free firmware (non-Free firmware loading is disabled)
[    8.887325] imx-sdma 20ec000.sdma: failed to get firmware from device tree
[    8.928411] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 96000Hz sample rate
[    8.932841] imx-sdma 20ec000.sdma: Direct firmware load for /*(DEBLOBBED)*/ failed with error -2
[    8.941518] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 96000Hz sample rate
[    8.948104] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 93750Hz
[    8.954948] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.985543] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    8.992121] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    8.998731] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[...]
[    9.013319] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[    9.029511] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    9.052247] imx-spdif sound-spdif: ASoC: CPU DAI (null) not registered
[    9.061522] imx-spdif sound-spdif: snd_soc_register_card failed: -517
[    9.072088] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    9.087019] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.120952] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 32000Hz sample rate
[    9.128069] fsl-spdif-dai 2004000.spdif: use txclk df 16 for 32000Hz sample rate
[    9.135255] fsl-spdif-dai 2004000.spdif: use sysclk df 2 for 32000Hz sample rate
[    9.142316] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 32226Hz
[    9.149247] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.181927] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 44100Hz sample rate
[    9.188687] sgtl5000 1-000a: Using internal LDO instead of VDDD
[    9.196207] fsl-spdif-dai 2004000.spdif: use txclk df 1 for 44100Hz sample rate
[    9.203005] fsl-spdif-dai 2004000.spdif: use sysclk df 23 for 44100Hz sample rate
[    9.209998] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 44836Hz
[    9.216928] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.250153] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 48000Hz sample rate
[    9.256987] fsl-spdif-dai 2004000.spdif: use txclk df 7 for 48000Hz sample rate
[    9.263890] fsl-spdif-dai 2004000.spdif: use sysclk df 3 for 48000Hz sample rate
[    9.270641] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 49107Hz
[    9.277343] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.305524] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 96000Hz sample rate
[    9.312400] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 96000Hz sample rate
[    9.319041] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 93750Hz
[    9.325799] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.354693] fsl-asoc-card sound: sgtl5000 <-> 2028000.ssi mapping ok
[    9.357288] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    9.357293] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    9.357298] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    9.470268] imx-spdif sound-spdif: snd-soc-dummy-dai <-> 2004000.spdif mapping ok
[...]
[   71.548012] fsl-spdif-dai 2004000.spdif: expected clock rate = 64915200
[   71.548027] fsl-spdif-dai 2004000.spdif: actual clock rate = 66000000
[   71.548043] fsl-spdif-dai 2004000.spdif: set sample rate to 44836Hz for 44100Hz playback
[   71.548054] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[   71.548065] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000
[   71.743796] fsl-spdif-dai 2004000.spdif: expected clock rate = 64915200
[   71.743812] fsl-spdif-dai 2004000.spdif: actual clock rate = 66000000
[   71.743823] fsl-spdif-dai 2004000.spdif: set sample rate to 44836Hz for 44100Hz playback
[   71.743844] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[   71.743867] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000

And when playing sound (spdif output works ok)

[  128.778530] fsl-spdif-dai 2004000.spdif: expected clock rate = 64915200
[  128.778549] fsl-spdif-dai 2004000.spdif: actual clock rate = 66000000
[  128.778560] fsl-spdif-dai 2004000.spdif: set sample rate to 44836Hz for 44100Hz playback
[  128.778575] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[  128.778583] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000


Thank you amd feel free to suggest more tests, but it is good enough
as it is for me.
