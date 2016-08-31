Return-Path: <festevam@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPQkY1nw9zDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 23:11:17 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id 2so3622395uax.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 06:11:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160831091013.GA3185@begut>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
 <20160829195428.GD1967@begut> <20160830111414.GA1968@begut>
 <20160831042100.GA3308@Asurada> <20160831091013.GA3185@begut>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 31 Aug 2016 10:11:13 -0300
Message-ID: <CAOMZO5AoCo9Faq7oWgRQUE0Hg+Pg+i6z8eg-qeLFDvwpoEqz_g@mail.gmail.com>
Subject: Re: [alsa-devel] Setting some clocks back to DUMMY fixes spdif output
 on imx6q wandboard rev B1
To: Xavi Drudis Ferran <xdrudis@tinet.cat>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 Timur Tabi <timur@tabi.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Xavi/Nicolin,

On Wed, Aug 31, 2016 at 6:10 AM, Xavi Drudis Ferran <xdrudis@tinet.cat> wrote:
> El Tue, Aug 30, 2016 at 09:21:01PM -0700, Nicolin Chen deia:
>>
>> No, the problem is not at the rate but the source -- Although the
>> MLB clock exists in the clock tree as a better rate provider, it
>> might not be correctly enabled or running at the rate it claims.
>>
>
>>
>> There are five MLB clocks sharing the same clock gate according
>> to CCM chapter in the Reference Manual of imx6q. But five clocks
>> come from three different parent clocks, and I am wondering if
>> the MLB clock that's connected to the S/PDIF module is really
>> derived from this AXI.
>>
>> Hope Fabio might be able to help on the clock tree issue here:)
>>
>
> I hope too, it's a little over my head, to be euphemistic.
>
>>
>> Another solution for you could be to change the rates of two of
>> those existing clocks to the perfect rates for 44.1KHz and 48KHz
>> respectively, 22579200Hz and 24576000Hz for example. (If you
>> only need one sample rate support, changing rxtx1 SPDIF clock
>> only then.)
>
> Thank you very much.  I'm not sure what practical problem that would
> solve for me, audio sounds quite right to my ears with the workaround
> (disabling MLB). I've looked page 121 of
> http://cache.freescale.com/files/32bit/doc/data_sheet/IMX6DQIEC.pdf
> And it seems like the the margin for the SPDIF clock would be 16 ns
> and I'm like 10 times out of spec. But I can't hear the problem.  I
> may try it one day to hear how it sounds.
>
> I'll try to remember it if I ever come across some problem with my audio.
> For now what I'd like is to stay as close to linux-libre mainline
> as possible, so the quick workaround is enough for me.
>
> Now for the general case, I'm not sure what the solution should be.
> Page 4 of the pdf above says MLB is not present in industrial "parts",
> only automotive, or consumer "parts". There are several versions of
> IMX6Q in the market.  What version must I have ? I guess consumer
> (with MLB) but I'm not sure... According to the wandboard-quad-rev-b1
> manual its consumer, MCIMX6Q5EYM10AC, so I should have MLB, I guess.
>
> $ cat /proc/cpuinfo
> processor          : 0
> model name         : ARMv7 Processor rev 10 (v7l)
> BogoMIPS           : 7.54
> Features           : half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32
> CPU implementer    : 0x41
> CPU architecture: 7
> CPU variant       : 0x2
> CPU part          : 0xc09
> CPU revision      : 10
> [...]
>
> I can't tell what CPU part : 0xc09 means.
>
> In the reference manual pg 796 I see the same gate seems to affect Media
> Local Bus (MLB) clock and Digital Transmission Content Protection
> (DTCP). I don't use DTCP but I haven't done anything to disable it.
>
> http://www.nxp.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf?fasp=1&WT_TYPE=Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation&fileExt=.pdf

Sorry for the delay.

As far as I can see, there are two current issues:

1. Regression caused by: 833f2cbf7091099bae ("ARM: dts: imx6: change
the core clock of spdif").

Looks like that this commit did much more than just changing the core
clock of spdif.

It does not mention why MLB clock has been added. Looking at MX6Q RM I
do not see the connection between MLB and SPDIF.

So I agree with Xavi's suggestion of using the dummy_clk instead of mlb clock.

Xavi,

Care to send a formal patch with your change?

2. SPDIF clock rate not accurate. Probably using PLL4 as SPDIF source
would help to get more accurate SPDIF clock rates.

Could you please try the untested change?

--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -623,7 +623,7 @@ static void __init imx6q_clocks_init(struct
device_node *ccm_node)
                pr_warn("failed to set up CLKO: %d\n", ret);

        /* Audio-related clocks configuration */
-       clk_set_parent(clk[IMX6QDL_CLK_SPDIF_SEL],
clk[IMX6QDL_CLK_PLL3_PFD3_454M]);
+       clk_set_parent(clk[IMX6QDL_CLK_SPDIF_SEL],
clk[IMX6QDL_CLK_PLL4_AUDIO_DIV]);

        /* All existing boards with PCIe use LVDS1 */
        if (IS_ENABLED(CONFIG_PCI_IMX6))

Regards,

Fabio Estevam
