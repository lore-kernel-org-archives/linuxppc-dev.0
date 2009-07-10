Return-Path: <amodra@bigpond.net.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4917EB707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 14:15:37 +1000 (EST)
Received: from nschwmtas05p.mx.bigpond.com (nschwmtas05p.mx.bigpond.com
	[61.9.189.149]) by ozlabs.org (Postfix) with ESMTP id 37793DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 14:15:37 +1000 (EST)
Date: Fri, 10 Jul 2009 13:45:36 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Edmar Wienskoski-RA8797 <edmar@freescale.com>
Subject: Re: binutils 2.19 issue with kernel link
Message-ID: <20090710041536.GE3181@bubble.grove.modra.org>
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
	<E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
	<AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
	<20090709044007.GB3181@bubble.grove.modra.org>
	<4B3B917C-C8B0-416B-888D-13E6C0645BF8@kernel.crashing.org>
	<4A5645A9.3080003@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A5645A9.3080003@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 09, 2009 at 02:31:53PM -0500, Edmar Wienskoski-RA8797 wrote:
> I understand your arguments, but there is something inconsistent about this.
> If I change the script to be:
>        _end3 = . ;
>        . = _end3;
>        . = ALIGN(PAGE_SIZE);
>        _end = . ;
>        PROVIDE32 (end = .);
> }
> The result is corrected:
> c067f678 A _end3
> c0680000 A _end
>
> Why the apuinfo section with zero VMA sometimes interfere with "." and  
> sometimes not ?

I said it was weird in my last email.  Not so.  The orphan gets placed
between

       _end3 = . ;
       . = _end3;

So dot is restored after the orphan section sets it.

-- 
Alan Modra
Australia Development Lab, IBM
