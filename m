Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBCD51A18A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 11:20:18 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E21714007D
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 11:20:18 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 28 Oct 2014 10:20:18 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] CXL: Fix PSL error due to duplicate segment table entries
In-reply-to: <87oasxy3v2.fsf@linux.vnet.ibm.com>
References: <1414383875-20835-1-git-send-email-imunsie@au.ibm.com>
 <87oasxy3v2.fsf@linux.vnet.ibm.com>
Date: Tue, 28 Oct 2014 11:20:20 +1100
Message-Id: <1414455469-sup-9840@delenn.ozlabs.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 greg <greg@kroah.com>, jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Aneesh Kumar K.V's message of 2014-10-28 01:38:41 +1100:
> I guess you are missing too many fixes in one patch.
> 
> 1) One cleanup
> 2) Fix for masking ea correctly
> 3) And fix for not erroring out when a slb is already in the slb cache.

ok, I'll split it up

> > +/* This finds a free SSTE and checks to see if it's already in table */
> > +static struct cxl_sste* find_free_sste(struct cxl_context *ctx,
> > +                       struct copro_slb *slb)
> 
> the name is confusing. If you want to keep the name, can you also
> specify that it return NULL, if it finds a matching entry. IIUC that
> is the real part of the fix for the problem mentioned ?

Good point.

> > -    sr = CXL_PSL_SR_An_SC;
> > +    sr = 0;
> 
> What is this change about ?

That tells the PSL not to use the secondary hash since we are no longer
filling out any entries using it. I'll clarify that in the commit
message when I split this out.

Cheers,
-Ian
