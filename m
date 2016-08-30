Return-Path: <xdrudis@tinet.cat>
Received: from mx2.tinet.org (mx2.tinet.org [195.77.216.147])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sNmB515wxzDrhS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 21:14:20 +1000 (AEST)
Received: from smtp01.tinet.org (smtp01.tinet.org [195.77.216.131]) by
 mx2.tinet.org with ESMTP id MH6NqaOJRvutFvVO for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 13:14:16 +0200 (CEST)
Date: Tue, 30 Aug 2016 13:14:14 +0200
From: Xavi Drudis Ferran <xdrudis@tinet.cat>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xavi Drudis Ferran <xdrudis@tinet.cat>, fabio.estevam@nxp.com,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Setting some clocks back to DUMMY fixes spdif output on imx6q
 wandboard rev B1
Message-ID: <20160830111414.GA1968@begut>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
 <20160829195428.GD1967@begut>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160829195428.GD1967@begut>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

El Mon, Aug 29, 2016 at 09:54:28PM +0200, Xavi Drudis Ferran deia:
> El Mon, Aug 29, 2016 at 12:28:21PM -0700, Nicolin Chen deia:
> > Would you
> > please do a little debug using "#define DEBUG 1" and check printk
> > from fsl_spdif_probe_txclk() to see the difference between before
> > and after Shengjiu's commit?
> 
> Yes, but I'm compiling the kernel in the wandboard, so it'll take me some time. 
> 

Now. Sorry for the delay. 

I did a mistake and had to do it twice. I added a couple of sanity check messages:
"enter fsl_spdif_probe"
"enter fsl_spdif_probe_txclk"


linux-libre-4.7 without my patch, i.e. clocks defined like this :
arch/arm/boot/dts/imx6qdl.dtsi:
aips-bus@02000000 { /* AIPS1 */
[...]
   spba-bus@02000000 {
[...]
       spdif: spdif@02004000 {
          clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
                   <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
                   <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
                   <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
                   <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
          clock-names = "core",  "rxtx0",
                        "rxtx1", "rxtx2",
                        "rxtx3", "rxtx4",
                        "rxtx5", "rxtx6",
                        "rxtx7", "spba";
[...]

The messages at boot: 

[    8.803603] 20ec000.sdma: Missing Free firmware (non-Free firmware loading is disabled)
[    8.813737] imx-sdma 20ec000.sdma: failed to get firmware from device tree
[    8.870764] imx-sdma 20ec000.sdma: Direct firmware load for /*(DEBLOBBED)*/ failed with error -2
[...]
[    9.083301] fsl-asrc 2034000.asrc: driver registered
[    9.087050] sgtl5000 1-000a: sgtl5000 revision 0x11
[    9.107141] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    9.144839] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.225228] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 32000Hz sample rate
[    9.234058] fsl-spdif-dai 2004000.spdif: use txclk df 16 for 32000Hz sample rate
[    9.235565] imx-spdif sound-spdif: ASoC: CPU DAI (null) not registered
[    9.236007] imx-spdif sound-spdif: snd_soc_register_card failed: -517
[...]
[    9.262713] fsl-spdif-dai 2004000.spdif: use sysclk df 2 for 32000Hz sample rate
[    9.269349] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 32226Hz
[    9.276431] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    9.276438] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    9.289559] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.306991] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    9.346253] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    9.376398] fsl-spdif-dai 2004000.spdif: use rxtx6 as tx clock source for 44100Hz sample rate
[    9.376404] fsl-spdif-dai 2004000.spdif: use txclk df 94 for 44100Hz sample rate
[    9.376409] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43882Hz
[    9.376415] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.403159] fsl-spdif-dai 2004000.spdif: use rxtx6 as tx clock source for 48000Hz sample rate
[    9.403165] fsl-spdif-dai 2004000.spdif: use txclk df 86 for 48000Hz sample rate
[    9.403170] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47965Hz
[    9.403174] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.424007] fsl-spdif-dai 2004000.spdif: use rxtx6 as tx clock source for 96000Hz sample rate
[    9.424013] fsl-spdif-dai 2004000.spdif: use txclk df 43 for 96000Hz sample rate
[    9.424021] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 95930Hz
[    9.424025] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.450424] fsl-spdif-dai 2004000.spdif: use rxtx6 as tx clock source for 192000Hz sample rate
[    9.481561] fsl-spdif-dai 2004000.spdif: use txclk df 21 for 192000Hz sample rate
[    9.488400] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 196428Hz
[    9.536785] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    9.582106] imx-spdif sound-spdif: snd-soc-dummy-dai <-> 2004000.spdif mapping ok
[    9.612159] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    9.621942] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    9.638227] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    9.647247] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    9.682092] sgtl5000 1-000a: Using internal LDO instead of VDDD
[    9.776989] fsl-asoc-card sound: sgtl5000 <-> 2028000.ssi mapping ok
[...]
[   70.407805] fsl-spdif-dai 2004000.spdif: expected clock rate = 265305600
[   70.407829] fsl-spdif-dai 2004000.spdif: actual clock rate = 264000000
[   70.407857] fsl-spdif-dai 2004000.spdif: set sample rate to 43882Hz for 44100Hz playback
[   70.407867] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[   70.407875] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000
[   70.469948] fsl-spdif-dai 2004000.spdif: expected clock rate = 265305600
[   70.469965] fsl-spdif-dai 2004000.spdif: actual clock rate = 264000000
[   70.469977] fsl-spdif-dai 2004000.spdif: set sample rate to 43882Hz for 44100Hz playback
[   70.469999] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[   70.470014] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000
[...]

Then when I try to play sound through spdif:

[  140.176536] fsl-spdif-dai 2004000.spdif: expected clock rate = 265305600
[  140.176555] fsl-spdif-dai 2004000.spdif: actual clock rate = 264000000
[  140.176566] fsl-spdif-dai 2004000.spdif: set sample rate to 43882Hz for 44100Hz playback
[  140.176579] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[  140.176587] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000




linux-libre-4.7 with my patch, i.e. clocks defined like this :
arch/arm/boot/dts/imx6qdl.dtsi:
aips-bus@02000000 { /* AIPS1 */
[...]
   spba-bus@02000000 {
[...]
      spdif: spdif@02004000 {
          clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
                   <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_DUMMY>,
                   <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
                   <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
                   <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
          clock-names = "core",  "rxtx0",
                        "rxtx1", "rxtx2",
                        "rxtx3", "rxtx4",
                        "rxtx5", "rxtx6",
                        "rxtx7", "spba";
[...]


The messages at boot: 

[...]
[    6.655532] imx-spdif sound-spdif: ASoC: CPU DAI (null) not registered
[    6.655545] imx-spdif sound-spdif: snd_soc_register_card failed: -517
[    6.656895] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    6.657567] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.660895] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 32000Hz sample rate
[    6.660902] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 32000Hz sample rate
[    6.660907] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 31719Hz
[    6.660911] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.662922] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
[    6.662927] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
[    6.662932] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz
[    6.662936] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.663205] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    6.663213] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    6.676779] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 48000Hz sample rate
[    6.676785] fsl-spdif-dai 2004000.spdif: use txclk df 5 for 48000Hz sample rate
[    6.676790] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47368Hz
[    6.676795] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.687008] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    6.687016] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    6.704876] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 96000Hz sample rate
[    6.704882] fsl-spdif-dai 2004000.spdif: use txclk df 3 for 96000Hz sample rate
[    6.704888] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 94736Hz
[    6.704892] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.723554] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    6.723561] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    6.723567] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    6.723679] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[    7.626351] fsl-asrc 2034000.asrc: driver registered
[    7.642378] imx-spdif sound-spdif: ASoC: CPU DAI (null) not registered
[    7.650279] imx-spdif sound-spdif: snd_soc_register_card failed: -517
[    7.667765] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    7.676924] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    7.696535] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    7.704977] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    7.718722] sgtl5000 1-000a: sgtl5000 revision 0x11
[...]
[    7.725855] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    7.728561] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    7.738178] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.740172] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 32000Hz sample rate
[    7.740177] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 32000Hz sample rate
[    7.740183] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 31719Hz
[    7.740187] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.760659] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
[    7.760665] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
[    7.760672] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz
[    7.760676] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.765495] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 48000Hz sample rate
[    7.765501] fsl-spdif-dai 2004000.spdif: use txclk df 5 for 48000Hz sample rate
[    7.765506] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47368Hz
[    7.765510] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.774373] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 96000Hz sample rate
[    7.774378] fsl-spdif-dai 2004000.spdif: use txclk df 3 for 96000Hz sample rate
[    7.774384] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 94736Hz
[    7.774388] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.778530] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    7.778536] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    7.778541] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    7.783897] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[    7.828163] imx-spdif sound-spdif: ASoC: CPU DAI (null) not registered
[    7.828174] imx-spdif sound-spdif: snd_soc_register_card failed: -517
[    7.828703] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    7.828712] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    7.828825] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    7.828832] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    7.829908] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    7.834312] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    7.837686] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.842472] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 32000Hz sample rate
[    7.842478] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 32000Hz sample rate
[    7.842485] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 31719Hz
[    7.842490] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.844695] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
[    7.844700] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
[    7.844705] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz
[    7.844708] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.848458] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 48000Hz sample rate
[    7.848464] fsl-spdif-dai 2004000.spdif: use txclk df 5 for 48000Hz sample rate
[    7.848470] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47368Hz
[    7.848474] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.858907] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 96000Hz sample rate
[    7.858912] fsl-spdif-dai 2004000.spdif: use txclk df 3 for 96000Hz sample rate
[    7.858917] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 94736Hz
[    7.858921] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.868189] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    7.868195] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    7.868200] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    7.868555] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[    8.094960] imx-spdif sound-spdif: ASoC: CPU DAI (null) not registered
[    8.094994] imx-spdif sound-spdif: snd_soc_register_card failed: -517
[    8.095669] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    8.095808] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    8.098338] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    8.098347] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    8.099067] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    8.109691] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    8.113038] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.117534] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 32000Hz sample rate
[    8.117539] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 32000Hz sample rate
[    8.117544] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 31719Hz
[    8.117548] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.120341] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
[    8.120347] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
[    8.120352] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz
[    8.120356] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.134938] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 48000Hz sample rate
[    8.134944] fsl-spdif-dai 2004000.spdif: use txclk df 5 for 48000Hz sample rate
[    8.134949] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47368Hz
[    8.134953] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.139127] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 96000Hz sample rate
[    8.139133] fsl-spdif-dai 2004000.spdif: use txclk df 3 for 96000Hz sample rate
[    8.139139] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 94736Hz
[    8.139143] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    8.147727] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    8.147734] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    8.147740] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    8.147822] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[...]
[    8.831797] 20ec000.sdma: Missing Free firmware (non-Free firmware loading is disabled)
[    8.880684] imx-sdma 20ec000.sdma: failed to get firmware from device tree
[    8.910258] imx-sdma 20ec000.sdma: Direct firmware load for /*(DEBLOBBED)*/ failed with error -2
[    9.073968] imx-spdif sound-spdif: ASoC: CPU DAI (null) not registered
[    9.081645] imx-spdif sound-spdif: snd_soc_register_card failed: -517
[    9.095074] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    9.110834] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    9.121216] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    9.130267] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    9.153016] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    9.165177] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    9.195832] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.211198] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 32000Hz sample rate
[    9.217917] fsl-spdif-dai 2004000.spdif: use txclk df 4 for 32000Hz sample rate
[    9.224900] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 31719Hz
[    9.231164] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.241790] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
[    9.248073] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
[    9.254457] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz
[    9.260822] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.279536] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 48000Hz sample rate
[    9.285950] fsl-spdif-dai 2004000.spdif: use txclk df 5 for 48000Hz sample rate
[    9.292236] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47368Hz
[    9.298648] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.313550] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 96000Hz sample rate
[...]
[    9.328117] fsl-spdif-dai 2004000.spdif: use txclk df 3 for 96000Hz sample rate
[    9.334526] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 94736Hz
[    9.340888] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    9.351639] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    9.358052] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    9.364471] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    9.417677] imx-spdif sound-spdif: snd-soc-dummy-dai <-> 2004000.spdif mapping ok
[    9.461316] sgtl5000 1-000a: Using internal LDO instead of VDDD
[    9.592189] fsl-asoc-card sound: sgtl5000 <-> 2028000.ssi mapping ok
[...]
[   69.198853] fsl-spdif-dai 2004000.spdif: expected clock rate = 25401600
[   69.198874] fsl-spdif-dai 2004000.spdif: actual clock rate = 25263158
[   69.198892] fsl-spdif-dai 2004000.spdif: set sample rate to 43859Hz for 44100Hz playback
[   69.198902] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[   69.198910] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000
[   69.349763] fsl-spdif-dai 2004000.spdif: expected clock rate = 25401600
[   69.349776] fsl-spdif-dai 2004000.spdif: actual clock rate = 25263158
[   69.349793] fsl-spdif-dai 2004000.spdif: set sample rate to 43859Hz for 44100Hz playback
[   69.349812] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[   69.349820] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000
[...]

Then when I try (successfully) to play sound through spdif:

[  113.186850] fsl-spdif-dai 2004000.spdif: expected clock rate = 25401600
[  113.186863] fsl-spdif-dai 2004000.spdif: actual clock rate = 25263158
[  113.186872] fsl-spdif-dai 2004000.spdif: set sample rate to 43859Hz for 44100Hz playback
[  113.186882] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[  113.186889] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000


Does it mean that a 43859Hz clock is close enough to theoretical 44100Hz
but  43882Hz is not ? 

The clock that doesn't work seems closer to the desired value.
I don't understand. 

Maybe there's something wrong with rxtx6 (IMX6QDL_CLK_MLB). This clock
does not seem to be used elsewhere (I mean in files, it's used in any
board that includes imx6qdl.dtsi)


include/dt-bindings/clock/imx6qdl-clock.h: 
#define IMX6QDL_CLK_MLB						139



Might it have to do with the fact I'm using (still trying in fact) to use etnaviv ?

drivers/clk/imx/clk-imx6q.c:

   if (clk_on_imx6dl())
      /*
       * The multiplexer and divider of the imx6q clock gpu2d get
       * redefined/reused as mlb_sys_sel and mlb_sys_clk_podf on imx6dl.
       */
       clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "gpu2d_core_podf",   base + 0x74, 18);
   else
       clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "axi",               base + 0x74, 18);


But I'm on a imx6q not imx6dl .

It seems I've found a similar case, just more ancient. I've tried the
patch in the last message there instead of the one I sent, and it
works for me (gives me sound on the spdif output) but I still don't
understand.

https://community.nxp.com/thread/387131

The patch is 

--- linux-4.7-no-spdif-out/arch/arm/boot/dts/imx6qdl.dtsi	2016-07-25 00:19:43.000000000 +0200
+++ linux-4.7/arch/arm/boot/dts/imx6qdl.dtsi	2016-08-30 12:51:37.369431791 +0200
@@ -242,7 +242,7 @@
 					clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
 						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
 						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
-						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
+						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_DUMMY>,
 						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
 					clock-names = "core",  "rxtx0",
 						      "rxtx1", "rxtx2",

And the dmesg is: 

[...]
[    6.757672] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    6.757680] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    6.767863] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    6.767874] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    6.771927] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    6.782230] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    6.795682] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.851089] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 32000Hz sample rate
[    6.857631] fsl-spdif-dai 2004000.spdif: use txclk df 16 for 32000Hz sample rate
[    6.864477] fsl-spdif-dai 2004000.spdif: use sysclk df 2 for 32000Hz sample rate
[    6.864484] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 32226Hz
[    6.864489] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.909089] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
[    6.909096] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
[    6.909101] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz
[    6.909105] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.981874] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 48000Hz sample rate
[    6.992935] fsl-spdif-dai 2004000.spdif: use txclk df 5 for 48000Hz sample rate
[    6.992943] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47368Hz
[    6.992948] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    6.993678] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    6.993688] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    6.993809] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    6.993816] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    6.994121] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    7.024546] 20ec000.sdma: Missing Free firmware (non-Free firmware loading is disabled)
[    7.024577] imx-sdma 20ec000.sdma: failed to get firmware from device tree
[    7.025416] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 96000Hz sample rate
[    7.025422] fsl-spdif-dai 2004000.spdif: use txclk df 3 for 96000Hz sample rate
[    7.025426] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 94736Hz
[    7.025430] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.040198] imx-sdma 20ec000.sdma: Direct firmware load for /*(DEBLOBBED)*/ failed with error -2
[    7.052490] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    7.052497] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    7.052503] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    7.052601] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[    7.053550] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    7.053560] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    7.054022] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    7.054295] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    7.056803] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    7.060206] fsl-asrc 2034000.asrc: driver registered
[    7.063842] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    7.064485] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.096570] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 32000Hz sample rate
[    7.096579] fsl-spdif-dai 2004000.spdif: use txclk df 16 for 32000Hz sample rate
[    7.096584] fsl-spdif-dai 2004000.spdif: use sysclk df 2 for 32000Hz sample rate
[    7.096589] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 32226Hz
[    7.096593] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.123283] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
[    7.123289] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
[    7.123295] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz
[    7.123299] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.144167] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 48000Hz sample rate
[    7.144173] fsl-spdif-dai 2004000.spdif: use txclk df 5 for 48000Hz sample rate
[    7.144180] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47368Hz
[    7.144185] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.169620] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 96000Hz sample rate
[    7.169626] fsl-spdif-dai 2004000.spdif: use txclk df 3 for 96000Hz sample rate
[    7.169634] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 94736Hz
[    7.169637] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.190745] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    7.190753] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    7.190758] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    7.190883] fsl-spdif-dai 2004000.spdif: imx_pcm_dma_init failed: -517
[    7.191660] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    7.191671] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    7.191777] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    7.191784] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    7.192106] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    7.220888] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe
[    7.221677] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.246497] fsl-spdif-dai 2004000.spdif: use rxtx5 as tx clock source for 32000Hz sample rate
[    7.246504] fsl-spdif-dai 2004000.spdif: use txclk df 16 for 32000Hz sample rate
[    7.246510] fsl-spdif-dai 2004000.spdif: use sysclk df 2 for 32000Hz sample rate
[    7.246515] fsl-spdif-dai 2004000.spdif: the best rate for 32000Hz sample rate is 32226Hz
[    7.246520] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.266974] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
[    7.266980] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
[    7.266985] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz
[    7.266989] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.288040] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 48000Hz sample rate
[    7.288046] fsl-spdif-dai 2004000.spdif: use txclk df 5 for 48000Hz sample rate
[    7.288051] fsl-spdif-dai 2004000.spdif: the best rate for 48000Hz sample rate is 47368Hz
[    7.288055] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.320893] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 96000Hz sample rate
[    7.320901] fsl-spdif-dai 2004000.spdif: use txclk df 3 for 96000Hz sample rate
[    7.320909] fsl-spdif-dai 2004000.spdif: the best rate for 96000Hz sample rate is 94736Hz
[    7.320915] fsl-spdif-dai 2004000.spdif: enter fsl_spdif_probe_txclk
[    7.342352] fsl-spdif-dai 2004000.spdif: use rxtx0 as tx clock source for 192000Hz sample rate
[    7.342363] fsl-spdif-dai 2004000.spdif: use txclk df 2 for 192000Hz sample rate
[    7.342370] fsl-spdif-dai 2004000.spdif: the best rate for 192000Hz sample rate is 187500Hz
[    7.369879] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    7.369889] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    7.370024] imx-sgtl5000 sound: ASoC: CPU DAI (null) not registered
[    7.370033] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    7.391119] fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
[    7.422777] fsl-asoc-card sound: ASoC: CODEC DAI sgtl5000 not registered
[    7.422789] fsl-asoc-card sound: snd_soc_register_card failed (-517)
[    7.423120] imx-sgtl5000 sound: ASoC: CODEC DAI sgtl5000 not registered
[    7.423133] imx-sgtl5000 sound: snd_soc_register_card failed (-517)
[    7.454462] sgtl5000 1-000a: sgtl5000 revision 0x11
[...]
[    7.658346] sgtl5000 1-000a: Using internal LDO instead of VDDD
[    7.766216] fsl-asoc-card sound: sgtl5000 <-> 2028000.ssi mapping ok
[...]
[    8.496784] imx-spdif sound-spdif: snd-soc-dummy-dai <-> 2004000.spdif mapping ok
[...]
[  110.494306] fsl-spdif-dai 2004000.spdif: expected clock rate = 25401600
[  110.494321] fsl-spdif-dai 2004000.spdif: actual clock rate = 25263158
[  110.494343] fsl-spdif-dai 2004000.spdif: set sample rate to 43859Hz for 44100Hz playback
[  110.494352] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[  110.494359] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000
[  110.549945] fsl-spdif-dai 2004000.spdif: expected clock rate = 25401600
[  110.549959] fsl-spdif-dai 2004000.spdif: actual clock rate = 25263158
[  110.549973] fsl-spdif-dai 2004000.spdif: set sample rate to 43859Hz for 44100Hz playback
[  110.549988] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[  110.549996] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000

Then, when I play music: 

[  178.269300] fsl-spdif-dai 2004000.spdif: expected clock rate = 25401600
[  178.269311] fsl-spdif-dai 2004000.spdif: actual clock rate = 25263158
[  178.269321] fsl-spdif-dai 2004000.spdif: set sample rate to 43859Hz for 44100Hz playback
[  178.269332] fsl-spdif-dai 2004000.spdif: STCSCH: 0x304000
[  178.269339] fsl-spdif-dai 2004000.spdif: STCSCL: 0x000000


AFAICS it just uses rxtx5 (IMX6QDL_CLK_IPG) for 32KHz and gets a little closer to that. 
But I haven't tried to play at 32KHz

Is there anything else I can try ? 

Thanks. 
