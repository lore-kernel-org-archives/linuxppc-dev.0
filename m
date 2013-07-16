Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 2B4812C0159
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 18:29:36 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 20617-09 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 16 Jul 2013 09:29:29 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] powerpc/fsl-booke: Work around erratum A-006958
Date: Tue, 16 Jul 2013 09:28:06 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72E2@saturn3.aculab.com>
In-Reply-To: <1373926558.8183.317@snotra>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B72E1@saturn3.aculab.com><1373907234.8183.297@snotra>
 <1373926558.8183.317@snotra>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On 07/15/2013 11:53:54 AM, Scott Wood wrote:
> > On 07/15/2013 03:45:36 AM, David Laight wrote:
> >> Also, if the high word changes, there is no need to loop.
> >> Just return the second value with a low word of zero
> >> (the returned count happened while the function was active).
> >
> > That would be more complicated than looping.

I'm not that familiar with the ppc instructions set, but on x86
the equivalent instructions are synchronising ones - so can have
performance penalties, so a few extra 'normal' instructions to
avoid re-reading the timebase counter may be worth while.

The branch for the loop might also be statically predicted 'taken'
leading to a branch misprediction penalty as well.

> That said, it's since been confirmed internally that the low word
> should always be zero when this happens, so we could share the Cell
> workaround code -- as long as we do something special in the timebase
> sync code so that we don't get stuck if the timebase happens to be
> frozen with TBL=3D=3D0.  This would avoid the need for scratch =
registers
> (other than CR0).

Yes - if the actual errata is that the low word is read one clock
later then the high word then the only illegal value is one where
the low word is zero.
In that case it is sufficient to reread the counter - it can't be
wrong again!
Indeed it is only necessary to read the high part (even if the
code pre-empted for over 2^32 counts, the returned value will
have happened during the designated period).

	David
