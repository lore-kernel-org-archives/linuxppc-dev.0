Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E15E2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 08:23:09 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 1 Jun 2013 19:20:11 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 028A52BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 08:23:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4VM8ZlR27656274
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 1 Jun 2013 08:08:35 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4VMN36I016819
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 1 Jun 2013 08:23:03 +1000
Message-ID: <1370038982.3928.147.camel@pasglop>
Subject: Re: 3.10-rc ppc64 corrupts usermem when swapping
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 08:23:02 +1000
In-Reply-To: <87ppw7mrx7.fsf@linux.vnet.ibm.com>
References: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
 <1369897236.3928.93.camel@pasglop> <87vc60na89.fsf@linux.vnet.ibm.com>
 <1369902786.3928.94.camel@pasglop>
 <alpine.LNX.2.00.1305300643150.10009@eggly.anvils>
 <alpine.LNX.2.00.1305302201200.12852@eggly.anvils>
 <1369978262.3928.111.camel@pasglop> <87ppw7mrx7.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au1.ibm.com>,
 Hugh Dickins <hughd@google.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-31 at 14:45 +0530, Aneesh Kumar K.V wrote:

> > The patch you are running on is what I'll send to Linus for 3.10 (+/-
> > cosmetics). Aneesh second patch is a much larger rework which will be
> > needed for THP but that will wait for 3.11. I'm happy for you to test it
> > but I first want to make sure it's solid with the 3.10 fix :-)

BTW. One concern I still have is that Hugh identified the bad commit
to be:

7e74c3921ad9610c0b49f28b8fc69f7480505841
"powerpc: Fix hpte_decode to use the correct decoding for page sizes".

However, you introduce the return on HPTE not found earlier, in

b1022fbd293564de91596b8775340cf41ad5214c
"powerpc: Decode the pte-lp-encoding bits correctly."

So while I'm still happy with the current band-aid for 3.10 and am
about to send it to Linus, the above *does* seem to indicate that
there is also something wrong with the "Fix hpte_decode..." commit,
which might not actually get the page size right...

Can you investigate ?

Cheers,
Ben.
