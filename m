Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g5GV6XYgzF1n5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 13:54:42 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w483s5GO043506
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 23:54:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htwgrdey7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 23:54:39 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Tue, 8 May 2018 04:54:37 +0100
Subject: Re: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU
 features are available
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
 felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com, corbet@lwn.net
Date: Tue, 08 May 2018 13:54:31 +1000
In-Reply-To: <20180508135019.3e08d57a@roar.ozlabs.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-7-alastair@au1.ibm.com>
 <eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
 <1525740115.7796.46.camel@au1.ibm.com>
 <20180508135019.3e08d57a@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525751671.7796.49.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-08 at 13:50 +1000, Nicholas Piggin wrote:
> On Tue, 08 May 2018 10:41:55 +1000
> "Alastair D'Silva" <alastair@au1.ibm.com> wrote:
> 
> > On Mon, 2018-05-07 at 20:14 +0200, Frederic Barrat wrote:
> > > 
> > > Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :  
> > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > 
> > > > In order for a userspace AFU driver to call the Power9 specific
> > > > OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can
> > > > actually
> > > > make that call.
> > > > 
> > > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > > ---
> > > >   Documentation/accelerators/ocxl.rst |  1 -
> > > >   drivers/misc/ocxl/file.c            | 25
> > > > +++++++++++++++++++++++++
> > > >   include/uapi/misc/ocxl.h            |  4 ++++
> > > >   3 files changed, 29 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/accelerators/ocxl.rst
> > > > b/Documentation/accelerators/ocxl.rst
> > > > index ddcc58d01cfb..7904adcc07fd 100644
> > > > --- a/Documentation/accelerators/ocxl.rst
> > > > +++ b/Documentation/accelerators/ocxl.rst
> > > > @@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
> > > >     Obtains configuration information from the card, such at
> > > > the
> > > > size of
> > > >     MMIO areas, the AFU version, and the PASID for the current
> > > > context.
> > > > 
> > > > -  
> > > 
> > > 
> > > Intended?
> > > 
> > > Other than that,
> > > Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> > >   
> > 
> > Nope, I'll fix that, thanks.
> > 
> 
> Just to be clear, this is for OCXL features. I would just make that
> explicit in the title (s/CPU/OCXL).
> 
> Thanks,
> Nick
> 

OK, sounds reasonable.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
