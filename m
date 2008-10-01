Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep24-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 21FEDDE016
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 08:14:35 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Added preliminary support for Netstal HCU4 board
Date: Thu, 2 Oct 2008 00:14:19 +0200
References: <200810011947.16543.niklaus.giger@member.fsf.org>
	<20081001180835.GA7601@yoda.jdub.homelinux.org>
In-Reply-To: <20081001180835.GA7601@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810020014.20414.niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Mittwoch 01 Oktober 2008 20.08:35 schrieb Josh Boyer:
> On Wed, Oct 01, 2008 at 07:47:16PM +0200, Niklaus Giger wrote:
> >Adds preliminary support for a HCU4 PPC405GPr based board from
> >Netstal Maschinen AG.
> >
> >For the last 3 years I have been the only user running Linux on this
> > board, but it served me well as testbed for the xenomai realtime
> > extension to the Linux kernel.
>
> Overall, really nice for a first submission.
One never has a second chance to make a first imrpession.

It was easy to make the needed changes (except changing ibm -> amcc, see 
below). The dtc does the conversion from the old to the new format dts-v1 
without a hitch. Calling "dtc -I dts -O dts hcu5.dts.old >hcu5.dts.new"l

My board is now in even better shape than before as I discovered that in my 
dts I even wrongly overwrote a the speed variable for the early boot messages.
Thanks a lot for suggestion!

> >+/ {
> >+	#address-cells = <1>;
> >+	#size-cells = <1>;
> >+	model = "ibm,hcu4";
> >+	compatible = "ibm,hcu4";
>
> These shouldn't be "ibm,hcu4".  IBM didn't make these boards.
> Instead, you should make them "<company>,<board>", where
> <company> is the company that made them (often the stock ticker
> is used), and <board> is obviously hcu4 in this case.

Can you explain this a little bit more to me. When we started to fabricate our 
boards we got the chips (or were it only the even older PPC403?) from IBM. If 
I just replace in this dts file "ibm" by "amcc" my board does not boot anymore. 
But if you give me a hint where and what I have to replace. I would volunteer 
to clean it up (if it not too much work) a little bit.

I cannot test on all boards but I have a walnut, yosemite and sequoia board at 
hand. Therefore I would be more confident to limit the cleanup to these boards.
(But only after my vacation, e.g. after the 20 of october).

Would you accept in the mean time a patch which still refers to "ibm,uic"?

Best regards

Niklaus
