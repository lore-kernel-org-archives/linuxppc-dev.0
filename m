Return-Path: <xdrudis@tinet.cat>
Received: from mx2.tinet.org (mx2.tinet.org [195.77.216.147])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sPKNb5ljyzDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 19:10:23 +1000 (AEST)
Received: from smtp01.tinet.org (smtp01.tinet.org [195.77.216.131]) by
 mx2.tinet.org with ESMTP id YTYg0z6pOlfm1XqX for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 11:10:16 +0200 (CEST)
Date: Wed, 31 Aug 2016 11:10:13 +0200
From: Xavi Drudis Ferran <xdrudis@tinet.cat>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xavi Drudis Ferran <xdrudis@tinet.cat>, fabio.estevam@nxp.com,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Setting some clocks back to DUMMY fixes spdif output on imx6q
 wandboard rev B1
Message-ID: <20160831091013.GA3185@begut>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
 <20160829195428.GD1967@begut> <20160830111414.GA1968@begut>
 <20160831042100.GA3308@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160831042100.GA3308@Asurada>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

El Tue, Aug 30, 2016 at 09:21:01PM -0700, Nicolin Chen deia:
> 
> No, the problem is not at the rate but the source -- Although the
> MLB clock exists in the clock tree as a better rate provider, it
> might not be correctly enabled or running at the rate it claims.
> 

> 
> There are five MLB clocks sharing the same clock gate according
> to CCM chapter in the Reference Manual of imx6q. But five clocks
> come from three different parent clocks, and I am wondering if
> the MLB clock that's connected to the S/PDIF module is really
> derived from this AXI.
> 
> Hope Fabio might be able to help on the clock tree issue here:)
>

I hope too, it's a little over my head, to be euphemistic. 

> 
> Another solution for you could be to change the rates of two of
> those existing clocks to the perfect rates for 44.1KHz and 48KHz
> respectively, 22579200Hz and 24576000Hz for example. (If you
> only need one sample rate support, changing rxtx1 SPDIF clock
> only then.)

Thank you very much.  I'm not sure what practical problem that would
solve for me, audio sounds quite right to my ears with the workaround
(disabling MLB). I've looked page 121 of
http://cache.freescale.com/files/32bit/doc/data_sheet/IMX6DQIEC.pdf
And it seems like the the margin for the SPDIF clock would be 16 ns
and I'm like 10 times out of spec. But I can't hear the problem.  I
may try it one day to hear how it sounds.

I'll try to remember it if I ever come across some problem with my audio.
For now what I'd like is to stay as close to linux-libre mainline 
as possible, so the quick workaround is enough for me. 

Now for the general case, I'm not sure what the solution should be.
Page 4 of the pdf above says MLB is not present in industrial "parts",
only automotive, or consumer "parts". There are several versions of
IMX6Q in the market.  What version must I have ? I guess consumer
(with MLB) but I'm not sure... According to the wandboard-quad-rev-b1
manual its consumer, MCIMX6Q5EYM10AC, so I should have MLB, I guess.

$ cat /proc/cpuinfo 
processor	   : 0
model name	   : ARMv7 Processor rev 10 (v7l)
BogoMIPS	   : 7.54
Features	   : half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32 
CPU implementer	   : 0x41
CPU architecture: 7
CPU variant	  : 0x2
CPU part	  : 0xc09
CPU revision	  : 10
[...]

I can't tell what CPU part : 0xc09 means.

In the reference manual pg 796 I see the same gate seems to affect Media
Local Bus (MLB) clock and Digital Transmission Content Protection
(DTCP). I don't use DTCP but I haven't done anything to disable it.

http://www.nxp.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf?fasp=1&WT_TYPE=Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation&fileExt=.pdf


Thanks again, you've been very helpful. 
