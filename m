Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPBzB5Mf4zDrhy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 14:21:25 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id p64so14941364pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 21:21:25 -0700 (PDT)
Date: Tue, 30 Aug 2016 21:21:01 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Xavi Drudis Ferran <xdrudis@tinet.cat>
Cc: fabio.estevam@nxp.com, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Setting some clocks back to DUMMY fixes spdif output on imx6q
 wandboard rev B1
Message-ID: <20160831042100.GA3308@Asurada>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
 <20160829195428.GD1967@begut> <20160830111414.GA1968@begut>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160830111414.GA1968@begut>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2016 at 01:14:14PM +0200, Xavi Drudis Ferran wrote:

> linux-libre-4.7 without my patch, i.e. clocks defined like this :
> arch/arm/boot/dts/imx6qdl.dtsi:
> aips-bus@02000000 { /* AIPS1 */
> [...]
>    spba-bus@02000000 {
> [...]
>        spdif: spdif@02004000 {
>           clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
>                    <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
>                    <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
>                    <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
>                    <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
>           clock-names = "core",  "rxtx0",
>                         "rxtx1", "rxtx2",
>                         "rxtx3", "rxtx4",
>                         "rxtx5", "rxtx6",
>                         "rxtx7", "spba";
> [...]

> [    9.376398] fsl-spdif-dai 2004000.spdif: use rxtx6 as tx clock source for 44100Hz sample rate
> [    9.376404] fsl-spdif-dai 2004000.spdif: use txclk df 94 for 44100Hz sample rate
> [    9.376409] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43882Hz

Without your patch, it chose rxtx6 (MLB) as the source for 44.1KHz.

> linux-libre-4.7 with my patch, i.e. clocks defined like this :
> arch/arm/boot/dts/imx6qdl.dtsi:
> aips-bus@02000000 { /* AIPS1 */
> [...]
>    spba-bus@02000000 {
> [...]
>       spdif: spdif@02004000 {
>           clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
>                    <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_DUMMY>,
>                    <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
>                    <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
>                    <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
>           clock-names = "core",  "rxtx0",
>                         "rxtx1", "rxtx2",
>                         "rxtx3", "rxtx4",
>                         "rxtx5", "rxtx6",
>                         "rxtx7", "spba";
> [...]

> [    6.662922] fsl-spdif-dai 2004000.spdif: use rxtx1 as tx clock source for 44100Hz sample rate
> [    6.662927] fsl-spdif-dai 2004000.spdif: use txclk df 9 for 44100Hz sample rate
> [    6.662932] fsl-spdif-dai 2004000.spdif: the best rate for 44100Hz sample rate is 43859Hz

With your patch, it selects rxtx1 (the dedicated SPDIF baud clock).

> Does it mean that a 43859Hz clock is close enough to theoretical 44100Hz
> but  43882Hz is not ? 

No, the problem is not at the rate but the source -- Although the
MLB clock exists in the clock tree as a better rate provider, it
might not be correctly enabled or running at the rate it claims.

> Maybe there's something wrong with rxtx6 (IMX6QDL_CLK_MLB). This clock

Yes.

> does not seem to be used elsewhere (I mean in files, it's used in any
> board that includes imx6qdl.dtsi)
> 
> 
> include/dt-bindings/clock/imx6qdl-clock.h: 
> #define IMX6QDL_CLK_MLB						139
 
> Might it have to do with the fact I'm using (still trying in fact) to use etnaviv ?
> 
> drivers/clk/imx/clk-imx6q.c:
> 
>    if (clk_on_imx6dl())
>       /*
>        * The multiplexer and divider of the imx6q clock gpu2d get
>        * redefined/reused as mlb_sys_sel and mlb_sys_clk_podf on imx6dl.
>        */
>        clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "gpu2d_core_podf",   base + 0x74, 18);
>    else
>        clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "axi",               base + 0x74, 18);
> 
> 
> But I'm on a imx6q not imx6dl .

There are five MLB clocks sharing the same clock gate according
to CCM chapter in the Reference Manual of imx6q. But five clocks
come from three different parent clocks, and I am wondering if
the MLB clock that's connected to the S/PDIF module is really
derived from this AXI.

Hope Fabio might be able to help on the clock tree issue here:)

> --- linux-4.7-no-spdif-out/arch/arm/boot/dts/imx6qdl.dtsi	2016-07-25 00:19:43.000000000 +0200
> +++ linux-4.7/arch/arm/boot/dts/imx6qdl.dtsi	2016-08-30 12:51:37.369431791 +0200
> @@ -242,7 +242,7 @@
>  					clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
>  						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
>  						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
> -						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
> +						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_DUMMY>,

As MLB might be gated or not available at all, disabling it is a
quick work around.
 
> AFAICS it just uses rxtx5 (IMX6QDL_CLK_IPG) for 32KHz and gets a little closer to that. 
> But I haven't tried to play at 32KHz
> 
> Is there anything else I can try ? 

Another solution for you could be to change the rates of two of
those existing clocks to the perfect rates for 44.1KHz and 48KHz
respectively, 22579200Hz and 24576000Hz for example. (If you
only need one sample rate support, changing rxtx1 SPDIF clock
only then.)
