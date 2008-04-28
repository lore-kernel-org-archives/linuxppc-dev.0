Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 36391DDF5A
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 08:07:57 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so2382125ywj.39
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 15:07:46 -0700 (PDT)
Message-ID: <fa686aa40804281507x65325d0es6e3791a397e0cbaa@mail.gmail.com>
Date: Mon, 28 Apr 2008 16:07:45 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <seanm@seanm.ca>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
In-Reply-To: <20080428173738.6b1a2896@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428145310.553b8271@lappy.seanm.ca>
	<fa686aa40804281256y722d8cf6pcae462d68b04e01f@mail.gmail.com>
	<20080428173738.6b1a2896@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 3:37 PM, Sean MacLennan <seanm@seanm.ca> wrote:
> On Mon, 28 Apr 2008 13:56:11 -0600
>
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
>  >
>
> > You need to add the gpio-controller and #gpio-cells properties to the
>  > GPIO nodes for the LED's gpios property to work correctly.  Search for
>  > "2) gpio-controller nodes" in
>  > Documentation/powerpc/booting-without-of.txt for details.  #gpio-cells
>  > should probably be '2' for this gpio controller; 1 cell for the gpio
>  > pin and 1 cell for flags.
>
>  I believe these gpio nodes predate that text, but I added the fields
>  anyway.
>
>
>  >
>  > These should not be children of the soc node (they are not part of the
>  > SoC internal bus).  However, I think it would be perfectly valid to
>  > make them children of the gpio node since they don't have any
>  > connections to other device on the platform.
>
>  I put them in gpio. That was where I put them initialy.
>
>
>  > Why is this information in the dts *and* the platform file?  I haven't
>  > been following the flash partition map binding conventions, but having
>  > it in both places looks wrong....
>  >
>  > oh, wait... the one in the dts is for NOR and this one is for NAND,
>  > right?  And we don't have a binding yet for NAND partitions yet,
>  > correct?
>
>  Correct. Josh originally asked me to split out the warp-nand.c file so
>  that once the NAND is in the dts, we can just delete the file. NAND is
>  much more complicated that NOR to configure.
>
>
>  > When exporting symbols for platform code you should avoid polluting
>  > the global Linux namespace and prefix the functions with your platform
>  > name.
>
>  I was hoping dtm was good enough. I prefixed them with the company name.
>  We are expecting to have a "family" of Asterisk appliances and I am
>  trying to make educated guesses as to what will be family wide
>  (prefixed with pika) and what will be warp specific.

Its just kernel code; it can be changed easily at later date.  When
the company has *2* boards supported mainline in the kernel, then make
it generic.  :-P

My experience is that educated guesses in this context are almost
always wrong (ie. the API won't be what you think it should be now).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
