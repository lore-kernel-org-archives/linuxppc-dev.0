Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta7.messagelabs.com (mail1.bemta7.messagelabs.com
 [216.82.254.101])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 83D722C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 10:38:43 +1100 (EST)
In-Reply-To: <52FAA97F.4060600@gmail.com>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
 <20140210110342.GA15806@visitor2.iram.es>
 <alpine.LRH.2.00.1402101056410.10318@ra8135-ec1.am.freescale.net>
 <20140211072606.GA26514@visitor2.iram.es>
 <OF6F6A0029.3B20EF5B-ONCA257C7C.0071BFDA-CA257C7C.00732AD3@csc.com>
 <63AEBD99-AA87-4FD7-BBDA-0CE419959F14@kernel.crashing.org>
 <52FAA97F.4060600@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Subject: Re: Linux-3.14-rc2: Order of serial node compatibles in DTS files.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFB203CA90.B048F8AA-ONCA257C7C.0081A816-CA257C7C.0081DCE3@csc.com>
Date: Wed, 12 Feb 2014 09:38:26 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>, Arnd Bergmann <arnd@arndb.de>,
 devicetree <devicetree@vger.kernel.org>,
 Stephen N Chivers <schivers@csc.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote on 
02/12/2014 09:51:43 AM:

> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> To: Kumar Gala <galak@kernel.crashing.org>, Stephen N Chivers 
> <schivers@csc.com.au>
> Cc: linuxppc-dev@lists.ozlabs.org, Chris Proctor 
> <cproctor@csc.com.au>, devicetree <devicetree@vger.kernel.org>, Arnd
> Bergmann <arnd@arndb.de>
> Date: 02/12/2014 09:51 AM
> Subject: Re: Linux-3.14-rc2: Order of serial node compatibles in DTS 
files.
> 
> On 02/11/2014 11:33 PM, Kumar Gala wrote:
> >
> > On Feb 11, 2014, at 2:57 PM, Stephen N Chivers <schivers@csc.com.au> 
wrote:
> >
> >> I have been trial booting a 3.14-rc2 kernel for a 85xx platform
> >> (dtbImage).
> >>
> >> After mounting the root filesystem there are no messages from the 
init
> >> scripts
> >> and the serial console is not available for login.
> >>
> >> In the kernel log messages there is:
> >>
> >> of_serial f1004500.serial: Unknown serial port found, ignored.
> >>
> >> The serial nodes in boards dts file are specified as:
> >>
> >>         serial0: serial@4500 {
> >>                         cell-index = <0>;
> >>                         device_type = "serial";
> >>                         compatible = "fsl,ns16550", "ns16550";
> >>                         reg = <0x4500 0x100>;
> >>                         clock-frequency = <0>;
> >>                         interrupts = <0x2a 0x2>;
> >>                         interrupt-parent = <&mpic>;
> >>                 };
> >>
> >> Reversing the order of the compatible:
> >>
> >>         compatible = "ns16550", "fsl,ns16550";
> >>
> >> restores the serial console.
> >>
> >> Linux-3.13 does not have this behaviour.
> >>
> >> There are 49 dts files in Linux-3.14-rc2 that have the fsl,ns16550
> >> compatible first.
> >
> > Hmm,
> >
> > Wondering if this caused the issue:
> >
> > commit 105353145eafb3ea919f5cdeb652a9d8f270228e
> > Author: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Date:   Tue Dec 3 14:52:00 2013 +0100
> >
> >      OF: base: match each node compatible against all given matches 
first
> 
> [adding Arnd on Cc]
> 
> Could be. I checked tty/serial/of_serial.c and it does not provide a
> compatible for "fsl,ns16550". Does reverting the patch fix the issue
> observed?
> 
> I don't think the missing compatible is causing it, but of_serial
> provides a DT match for .type = "serial" just to fail later on
> with the error seen above.
> 
> The commit in question reorders of_match_device in a way that match
> table order is not relevant anymore. This can cause it to match
> .type = "serial" first here.
> 
> Rather than touching the commit, I suggest to remove the problematic
> .type = "serial" from the match table. It is of no use anyway.
Deleting the "serial" line from the match table fixes the problem.
I tested it for both orderings of compatible.
> 
> Sebastian

Thanks,
Stephen Chivers,
CSC Australia Pty. Ltd.
