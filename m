Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EAC332C032F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 10:36:57 +1100 (EST)
Message-ID: <1362440204.21357.20.camel@pasglop>
Subject: Re: [PATCH -V1 06/24] powerpc: Reduce PTE table memory wastage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 05 Mar 2013 10:36:44 +1100
In-Reply-To: <874ngr2zz1.fsf@linux.vnet.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361865914-13911-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130304045853.GB27523@drongo> <874ngr2zz1.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-03-04 at 16:28 +0530, Aneesh Kumar K.V wrote:
> I added the below comment when initializing the list.
> 
> +#ifdef CONFIG_PPC_64K_PAGES
> +       /*
> +        * Used to support 4K PTE fragment. The pages are added to list,
> +        * when we have free framents in the page. We track the whether
> +        * a page frament is available using page._mapcount. A value of
> +        * zero indicate none of the fragments are used and page can be
> +        * freed. A value of FRAG_MASK indicate all the fragments are used
> +        * and hence the page will be removed from the below list.
> +        */
> +       INIT_LIST_HEAD(&init_mm.context.pgtable_list);
> +#endif
> 
> I am not sure about why you say there is no consistent rule. Can you
> elaborate on that ?

Do you really need that list ? I assume it's meant to allow you to find
free frags when allocating but my worry is that you'll end up losing
quite a bit of node locality of PTE pages....

It may or may not work but can you investigate doing things differently
here ? The idea I want you to consider is to always allocate a full
page, but make the relationship of the fragments to PTE pages fixed. IE.
the fragment in the page is a function of the VA.

Basically, the algorithm for allocation is roughly:

 - Walk the tree down to the PMD ptr (* that can be improved with a
generic change, see below)

 - Check if any of the neighbouring PMDs is populated. If yes, you have
your page and pick the appropriate fragment based on the VA

 - If not, allocate and populate

On free, similarly, you checked if all neighbouring PMDs have been
cleared, in which case you can fire off the page for RCU freeing.

(*) By changing pte_alloc_one to take the PMD ptr (which the call side
has right at hand) you can avoid the tree lookup.

Cheers,
Ben.
