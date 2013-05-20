Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC2792C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 16:28:54 +1000 (EST)
Message-ID: <1369031318.6387.1.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc: use smp_rmb when looking at deposisted
 pgtable to store hash index
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 20 May 2013 16:28:38 +1000
In-Reply-To: <87vc6e9sxx.fsf@linux.vnet.ibm.com>
References: <1368778503-23230-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <26735.1369012726@ale.ozlabs.ibm.com> <87vc6e9sxx.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 paulus@samba.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-20 at 09:57 +0530, Aneesh Kumar K.V wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
> > Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> >
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >> 
> >> We need to use smb_rmb when looking at hpte slot array. Otherwise we could
> >> reorder the hpte_slot array load bfore even we marked the pmd trans huge.
> >
> > Does this need to go back into the stable series?
> >
> 
> No the changes are not yet upstream. hpte_slot_array changes are in the
> THP series. I didn't want to post the entire series again with the 
> above two patches. 

Note that any patch that adds such a rmb should have a very clear
description of what is the corresponding wmb. It's almost never right to
have one without the other. IE. What is it that you are ordering
against.

Cheers,
Ben.
