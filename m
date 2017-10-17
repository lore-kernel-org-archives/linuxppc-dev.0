Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGZqC19bgzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:52:54 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HCp60h070643
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 08:52:52 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dneyv9dka-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 08:52:52 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 13:52:50 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9HCqkXE27459818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 12:52:47 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9HCqjVa020535
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:52:46 +1100
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Alexander.Steffen@infineon.com
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 andriy.shevchenko@linux.intel.com, elfring@users.sourceforge.net,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, clabbe.montjoie@gmail.com,
 jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com,
 jsnitsel@redhat.com, kgold@linux.vnet.ibm.com, mpe@ellerman.id.au,
 nayna@linux.vnet.ibm.com, paulus@samba.org, PeterHuewe@gmx.de, Stefan
 Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 08:52:37 -0400
In-Reply-To: <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508244757.4234.60.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-17 at 11:50 +0000, Alexander.Steffen@infineon.com
wrote:
> > > Replace the specification of data structures by pointer dereferences
> > > as the parameter for the operator "sizeof" to make the corresponding
> > > size
> > > determination a bit safer according to the Linux coding style
> > > convention.
> > 
> > 
> > This patch does one style in favor of the other.
> 
> I actually prefer that style, so I'd welcome this change :)

Style changes should be reviewed and documented, like any other code
change, and added to Documentation/process/coding-style.rst or an
equivalent file.

> > At the end it's Jarkko's call, though I would NAK this as I think some
> > one already told this to you for some other similar patch(es).
> > 
> > 
> > I even would suggest to stop doing this noisy stuff, which keeps people
> > busy for nothing.
> 
> Cleaning up old code is also worth something, even if does not
> change one bit in the assembly output in the end...

Wow, you're opening the door really wide for all sorts of trivial
changes!  Hope you have the time and inclination to review and comment
on all of them.  I certainly don't.

There is a major difference between adding these sorts of checks to
the tools in the scripts directory or even to the zero day bots that
catch different sorts of errors, BEFORE code is upstreamed, and
patches like these, after the fact.

After the code has been upstreamed, it is a lot more difficult to
justify changes like this.  It impacts both code that is being
developed AND backporting bug fixes.

Mimi
