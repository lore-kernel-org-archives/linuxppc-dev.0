Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7668E2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 17:23:08 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 2 Jun 2013 12:48:32 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 34469125804F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2013 12:55:04 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r527MqZq5833124
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 12:52:53 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r527Mu3p016004
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Jun 2013 17:22:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: 3.10-rc ppc64 corrupts usermem when swapping
In-Reply-To: <1370038982.3928.147.camel@pasglop>
References: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
 <1369897236.3928.93.camel@pasglop> <87vc60na89.fsf@linux.vnet.ibm.com>
 <1369902786.3928.94.camel@pasglop>
 <alpine.LNX.2.00.1305300643150.10009@eggly.anvils>
 <alpine.LNX.2.00.1305302201200.12852@eggly.anvils>
 <1369978262.3928.111.camel@pasglop> <87ppw7mrx7.fsf@linux.vnet.ibm.com>
 <1370038982.3928.147.camel@pasglop>
Date: Sun, 02 Jun 2013 12:52:56 +0530
Message-ID: <8738t1c6y7.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Benjamin Herrenschmidt <benh@au1.ibm.com> writes:

> On Fri, 2013-05-31 at 14:45 +0530, Aneesh Kumar K.V wrote:
>
>> > The patch you are running on is what I'll send to Linus for 3.10 (+/-
>> > cosmetics). Aneesh second patch is a much larger rework which will be
>> > needed for THP but that will wait for 3.11. I'm happy for you to test it
>> > but I first want to make sure it's solid with the 3.10 fix :-)
>
> BTW. One concern I still have is that Hugh identified the bad commit
> to be:
>
> 7e74c3921ad9610c0b49f28b8fc69f7480505841
> "powerpc: Fix hpte_decode to use the correct decoding for page sizes".
>
> However, you introduce the return on HPTE not found earlier, in
>
> b1022fbd293564de91596b8775340cf41ad5214c
> "powerpc: Decode the pte-lp-encoding bits correctly."
>
> So while I'm still happy with the current band-aid for 3.10 and am
> about to send it to Linus, the above *does* seem to indicate that
> there is also something wrong with the "Fix hpte_decode..." commit,
> which might not actually get the page size right...
>
> Can you investigate ?

7e74c3921ad9610c0b49f28b8fc69f7480505841 
"powerpc: Fix hpte_decode to use the correct decoding for page sizes"
changes should only impact hpte_decode. We don't change the details
of hpte_actual_psize at all in this patch. That means we should see a
difference only with kexec right ?.

Hugh,

Will you be able to double check whether
7e74c3921ad9610c0b49f28b8fc69f7480505841 is the bad commit. The one
before that is what we changed in the patch that fixed your problem.

-aneesh
