Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0218.hostedemail.com
 [216.40.44.218])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PBVw1vr8zDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 14:02:32 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id DC8CE18045C03
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 03:52:50 +0000 (UTC)
Message-ID: <75bfb54e1292e31830aafb8329e3cc81d1412ff5.camel@perches.com>
Subject: Re: [PATCH v3 1/2] powerpc: Detect the presence of big-cores via
 "ibm, thread-groups"
From: Joe Perches <joe@perches.com>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, "Gautham R. Shenoy"
 <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Jul 2018 20:52:39 -0700
In-Reply-To: <20180708160334.GA6947@kermit-br-ibm-com>
References: <cover.1530867876.git.ego@linux.vnet.ibm.com>
 <abaea3bd2aa89c7c9f284e3a7beabb865d8e1050.1530867876.git.ego@linux.vnet.ibm.com>
 <20180708160334.GA6947@kermit-br-ibm-com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-07-08 at 13:03 -0300, Murilo Opsfelder Araujo wrote:
> On Fri, Jul 06, 2018 at 02:35:48PM +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > On IBM POWER9, the device tree exposes a property array identifed by
> > "ibm,thread-groups" which will indicate which groups of threads share a
> > particular set of resources.
[]
> > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
[]
> > @@ -1025,6 +1026,33 @@ static ssize_t show_physical_id(struct device *dev,
> >  }
> >  static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> >  
> > +static ssize_t show_small_core_siblings(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> 
> Interesting enough, checkpatch.pl warned about this function name:
> 
>     WARNING: Consider renaming function(s) 'show_small_core_siblings' to 'small_core_siblings_show'
>     #354: FILE: arch/powerpc/kernel/sysfs.c:1053:
>     +}

It's to allow the DEVICE_ATTR below to be renamed to DEVICE_ATTR_RO 

> > +static DEVICE_ATTR(small_core_siblings, 0444, show_small_core_siblings, NULL);

So this becomes 

DEVICE_ATTR_RO(small_core_siblings)
