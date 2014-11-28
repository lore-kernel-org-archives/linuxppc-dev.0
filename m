Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC9D81A0BA9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 14:22:16 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 28 Nov 2014 13:22:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EC6E22CE8071
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 14:22:11 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAS3M3Bp23003160
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 14:22:11 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAS3LcRZ021339
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 14:21:39 +1100
Message-ID: <1417144874.2852.21.camel@au1.ibm.com>
Subject: Re: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 28 Nov 2014 14:21:14 +1100
In-Reply-To: <5477E8C1.9030600@linux.vnet.ibm.com>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
 <1417136200.2852.14.camel@kernel.crashing.org>
 <5477E8C1.9030600@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rusty@rustcorp.com.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-28 at 08:45 +0530, Madhavan Srinivasan wrote:
> > Can't we just unconditionally clear at as long as we do that after we've
> > saved it ? In that case, it's just a matter for the fixup code to check
> > the saved version rather than the actual CR..
> > 
> I use CR bit setting in the interrupt return path to enter the fixup
> section search. If we unconditionally clear it, we will have to enter
> the fixup section for every kernel return nip right?

As I said above. Can't we look at the saved version ?

IE.

 - On interrupt entry:

	* Save CR to CCR(r1)
	* clear CR5

 - On exit

	* Check CCR(r1)'s CR5 field
	* restore CR

Cheers,
Ben.
