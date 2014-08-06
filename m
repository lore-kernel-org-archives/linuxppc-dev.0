Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05A6A1A021C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 06:30:55 +1000 (EST)
Message-ID: <1407357040.3073.93.camel@pasglop>
Subject: Re: [PATCH] powerpc: thp: Use tlbiel wherever possible
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 07 Aug 2014 06:30:40 +1000
In-Reply-To: <8738d965hf.fsf@linux.vnet.ibm.com>
References: <1407221289-19390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <8738d965hf.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-06 at 20:16 +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > If we know that user address space has never executed on other cpus
> > we could use tlbiel.
> >
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> Now checking against flush_hash_page, I am wondering whether I need to handle
> transcational memory in case of tlbiel ? Michael, can you let me know if
> this is needed ?

Also, beware that we have code that sets "tlbiel" in the page definition
array to 0 on all but 4k and 64k pages...

Cheers,
Ben.
