Return-Path: <david.kanceruk@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 3405DDDF16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 01:04:00 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so559132ana
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 08:03:59 -0700 (PDT)
Message-ID: <5b525e390705150803l516a5d9x9c214e2b4b00ea0e@mail.gmail.com>
Date: Tue, 15 May 2007 10:03:58 -0500
From: "David Kanceruk" <david.kanceruk@gmail.com>
To: "Hans Thielemans" <hans.thielemans@metris.com>
Subject: Re: MPC5200 ethernet communication stops unexpected
In-Reply-To: <1179234357.1668.10.camel@pc-hans>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1179234357.1668.10.camel@pc-hans>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Hans,

     Our problem was with the FEC sending data with one or two
incorrect bytes when we switched from the MPC5200 to the MPC5200B. The
byte positions were always the same. The socket buffer has the correct
data before and after the DMA engine runs but the FEC TxFIFO does not
always match.

One solution to our problem was to make the following call prior to
starting the DMA:

flush_dcache_range((unsigned long)skb->data, (unsigned long)skb->data
+ skb->len);

The other solution was to set the BSDIS bit in the XLB config register
during initialization as follows:

  xlb = (struct mpc52xx_xlb *)MPC5xxx_XLB;
  out_be32(&xlb->config,  in_be32(&xlb->config) | MPC52xx_XLB_CFG_BSDIS);

Either solution works for us. The BSDIS bit is a new feature in the
MPC5200B. The MPC5200 did not have this bit.

According to the Freescale documentation, (Application note AN3045,
for instance) setting this bit is supposed to "disable" BestComm bus
snooping. However, I have reason to believe the documentation is in
error. Everything I have observed seems to indicate that in the
MPC5200 BestComm bus snooping was always enabled or enabled via some
other means. In the MPC5200B it appears to be "disabled" at reset (not
"enabled" as the documentation states). This is why flushing the cache
manually is one solution. Since setting the BSDIS bit also fixes the
problem, it suggests that this actually "enables" BestComm bus
snooping instead of disabling it. In my mind, it could all boil down
to a simple documentation error.

Perhaps you are also experiencing a caching problem.

Best regards,

David Kanceruk

On 5/15/07, Hans Thielemans <hans.thielemans@metris.com> wrote:
> Hi David,
>
> I have a similar problem. I use the PSC for communication to a DSP.
> With the MPC5200 this has always worked. Now we got boards with the
> MCP5200B in place.
>
> The bestcomm dma seems to miss bits, bytes in the last word (32bit) of a
> dma block. Mostly it is one byte which becomes 0. The blocks are 256
> bytes and written/read by 32 bits.
> The behavior is influenced by cpu activity, bus priorities. So far I
> found no settings which have never errors.
>
> Did you have any further progress?
>
> Regards
>
> Hans Thielemans
>



-- 
David Kanceruk

"The generation of random numbers is far too important to be left to chance."
