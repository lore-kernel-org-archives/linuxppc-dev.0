Return-Path: <ml@iridescent.org>
Received: from adsl-63-193-117-152.dsl.snfc21.pacbell.net
	(adsl-63-193-117-152.dsl.snfc21.pacbell.net [63.193.117.152])
	by ozlabs.org (Postfix) with SMTP id 0E3122BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Dec 2004 19:53:31 +1100 (EST)
Mime-Version: 1.0
Message-Id: <p06110407bde27ec7c1dd@iridescent.org>
In-Reply-To: <41B9A33A.21673.5DDD7F64@localhost>
References: <41B9A33A.21673.5DDD7F64@localhost>
Date: Mon, 13 Dec 2004 00:38:03 -0800
To: linuxppc-embedded@ozlabs.org
From: "Lawrence E. Bakst" <ml@iridescent.org>
Content-Type: text/plain; charset="us-ascii"
Subject: Re: Write Combining on PowerPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 1:23 PM -0800 12/10/04, Kendall Bennett wrote:
>Hi Guys,
>
>We are working on some PowerPC machines and noticed that the boxes don't
>appear to support the equivalent of Write Combining that we get on x86
>boxes. Copies to Video Memory on our Motorola Sandpoint box run about
>10Mb/s, which is terribly, terribly slow! 
>
>Does anyone know if it is possible to do something similar to Write
>Combining for the PowerPC architecture, to speed up CPU access to the
>linear framebuffer? Part of the problem is that for video overlay support
>(not motion compensation) you have to dump the entire YUV frame into
>video memory for the hardware overlay, and even on a 1GHz PPC box playing
>an MPEG2 stream is not possible as X takes up over 80% of the CPU just to
>copy the YUV data to video memory!


1. As a previous poster mentioned many PPCs have write combining but they usually call it store gathering. I was just reading about it in the IBM 970fx.

2. What you need are cache line reads or writes through your bridge to the video memory.

3. If your frame buffer is marked non-cachable, which is the usually case, see if you can set up a second aperture that is cached. Otherwise I don't think the store gatherin will work. I don't know your board or processor but you should experiment with cache modes to see which if any work best.

4. Assuming you can get a cachable aperture you need to remember when writing a complete image to frame buffer memory is that you waste 50% of your bandwidth reading cache lines from the frame buffer into your cache. You can use dcbz to clear a cache line and then write it. This should double your bandwidth to 20 MB/sec.

5. How good is your copy loop? if you have floating point registers you can often use these to increase your efficiency. There may be other ways to make the copy loop more efficient using processor specific instructions that generate more efficient memory loads and stores. Try loop unrolling. Also make sure you prefetch the source using a dcbt or similar instruction. You have to experiment to see how far ahead of needed the data you need to prefecth.

6. Use small test programs to get it right.

7. You don't mention your processor type/speed, bus speeds and memory speed so it's pretty hard to tell what efficiency you might be able to achieve.

8. I make no comment about the efficiency of X. It's not would I would use for video applications although I am sure there are those that have hacked it work there.

Best,

leb
> 
>
>Obviously bus mastering will help solve this problem, but it would be
>better if there was a way to enabling faster CPU access to the
>framebuffer as well. 
>
>Regards,
>
>---
>Kendall Bennett
>Chief Executive Officer
>SciTech Software, Inc.
>Phone: (530) 894 8400
>http://www.scitechsoft.com
>
>~ SciTech SNAP - The future of device driver technology! ~
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
