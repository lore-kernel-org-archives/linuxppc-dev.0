Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 904EF679F2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 07:51:57 +1000 (EST)
In-Reply-To: <1147204345.3139.11.camel@excalibur.timesys.com>
References: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
	<1147204345.3139.11.camel@excalibur.timesys.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3A4FA660-AD13-4E2B-846B-B9ACD901444F@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: IMAP_ADDR on PPC 8xx
Date: Tue, 9 May 2006 17:51:08 -0400
To: Walter L. Wimer III <walt.wimer@timesys.com>
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


On May 9, 2006, at 3:52 PM, Walter L. Wimer III wrote:

> Exactly.  I think this kind of "automatic adaption" to the particular
> platform is what should be in the vanilla kernel.

This does not mean you can choose some arbitrary value.
There is a small range of high memory addresses that will
work successfully for IMMR.  You may not see any problems
right away, but depending upon drivers selected and the
software features used, some problems will crop up.
There are also MMU performance enhancements that may
be used with certain values, and guaranteed kernel crashes
at some point in the future when abused.

With Linux, the IMMR should always have a value of
0xf0000000 or 0xff000000 for best results.

> This was the second major part of our 2.6.11.7-based patch.  It
> performed a single ioremap(), stored the result in a global  
> pointer, and
> then used that pointer in all the drivers instead of using IMAP_ADDR
> directly.

This is not an acceptable practice.  We are removing all
global pointers like this, and any driver that needs access to
some or all of the IMMR space should be individually mapping
those regions it needs.  Under the covers of ioremap() we are
performing various alignment and reuse of address spaces
in order to support things like performance enhancements
and cache coherent regions.

Thanks.

	-- Dan
