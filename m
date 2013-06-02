Return-Path: <hughd@google.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4C922C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 04:19:20 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id bg2so577758pad.25
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Jun 2013 11:19:17 -0700 (PDT)
Date: Sun, 2 Jun 2013 11:19:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: 3.10-rc ppc64 corrupts usermem when swapping
In-Reply-To: <8738t1c6y7.fsf@linux.vnet.ibm.com>
Message-ID: <alpine.LNX.2.00.1306021107290.16977@eggly.anvils>
References: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
 <1369897236.3928.93.camel@pasglop> <87vc60na89.fsf@linux.vnet.ibm.com>
 <1369902786.3928.94.camel@pasglop>
 <alpine.LNX.2.00.1305300643150.10009@eggly.anvils>
 <alpine.LNX.2.00.1305302201200.12852@eggly.anvils>
 <1369978262.3928.111.camel@pasglop> <87ppw7mrx7.fsf@linux.vnet.ibm.com>
 <1370038982.3928.147.camel@pasglop> <8738t1c6y7.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au1.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2 Jun 2013, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@au1.ibm.com> writes:
> > On Fri, 2013-05-31 at 14:45 +0530, Aneesh Kumar K.V wrote:
> >
> >> > The patch you are running on is what I'll send to Linus for 3.10 (+/-
> >> > cosmetics). Aneesh second patch is a much larger rework which will be
> >> > needed for THP but that will wait for 3.11. I'm happy for you to test it
> >> > but I first want to make sure it's solid with the 3.10 fix :-)
> >
> > BTW. One concern I still have is that Hugh identified the bad commit
> > to be:
> >
> > 7e74c3921ad9610c0b49f28b8fc69f7480505841
> > "powerpc: Fix hpte_decode to use the correct decoding for page sizes".
> >
> > However, you introduce the return on HPTE not found earlier, in
> >
> > b1022fbd293564de91596b8775340cf41ad5214c
> > "powerpc: Decode the pte-lp-encoding bits correctly."
> >
> > So while I'm still happy with the current band-aid for 3.10 and am
> > about to send it to Linus, the above *does* seem to indicate that
> > there is also something wrong with the "Fix hpte_decode..." commit,
> > which might not actually get the page size right...
> >
> > Can you investigate ?
> 
> 7e74c3921ad9610c0b49f28b8fc69f7480505841 
> "powerpc: Fix hpte_decode to use the correct decoding for page sizes"
> changes should only impact hpte_decode. We don't change the details
> of hpte_actual_psize at all in this patch. That means we should see a
> difference only with kexec right ?.
> 
> Hugh,
> 
> Will you be able to double check whether
> 7e74c3921ad9610c0b49f28b8fc69f7480505841 is the bad commit. The one
> before that is what we changed in the patch that fixed your problem.

You are absolutely right.  I just set b1022fbd29 going, expecting
to answer you tomorrow: but got a Segmentation fault in 20 minutes
(quicker than ever seen before).  It looks as if I was running some
other kernel for the last stage of my bisection: I can't see how that
came about, but it's not very interesting now - you got it right.

Prior to trying that, I had been running your second patch, 9f70fd8cfe,
and that tested out successfully for 50 hours before I stopped it.

Hugh
