Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 4EC55DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 15:58:23 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so720524wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 Jul 2008 22:58:21 -0700 (PDT)
Date: Wed, 2 Jul 2008 23:58:19 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Thomas Maenner <tmaenner@aehr.com>
Subject: Re: Need stable 2.6 kernel for TQM823L
Message-ID: <20080703055819.GB643@secretlab.ca>
References: <200807021418.13596.tmaenner@aehr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200807021418.13596.tmaenner@aehr.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 02:18:13PM -0700, Thomas Maenner wrote:
> Hi Guys,
> 
> I have used the 2.4 kernel successfully on the TQM823L and 855s, and wanted to 
> try out a 2.6 version. So I downloaded the latest from Wolfgang @ git.denx.de 
> but I'm getting all sorts of compile errors....
> 
> Before I continue to dive in, I wanted to ask the group some questions:
> - Is 2.6 ported to the TQM8xx modules?

$ ls arch/powerpc/boot/dts/tqm*
arch/powerpc/boot/dts/tqm5200.dts  arch/powerpc/boot/dts/tqm8555.dts
arch/powerpc/boot/dts/tqm8540.dts  arch/powerpc/boot/dts/tqm8560.dts
arch/powerpc/boot/dts/tqm8541.dts

Unfortunately, it doesn't look like any of the tqm8xx boards have been
added to the device tree directory, so the answer is probably, 'no'.

> - If so, is it stable?

I believe 8xx support is stable in arch/powerpc, but you'll need to
write a device tree file for the board.  Look for a similar board in
arch/powerpc/boot/dts/ to use as a starting point.

You'll probably also need to add a platform file to arch/powerpc/platforms/8xx
that matches against your new device tree file.

g.
