Return-Path: <cfriesen@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 23EFC67A33
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 03:20:29 +1000 (EST)
Message-ID: <42541A55.1030606@nortel.com>
Date: Wed, 06 Apr 2005 11:20:21 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <1112770418.9567.137.camel@gaston>
	<c689550a30a3129f8576f78eaa6f7af4@freescale.com>
In-Reply-To: <c689550a30a3129f8576f78eaa6f7af4@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned 
> long addr,
>                                        pte_t *ptep)
> {
>         pte_t tmp = *ptep;
>         pte_update(ptep, ~_PAGE_HASHPTE, 0);
>         return tmp;
> }

Doesn't work.  The update and storing of the old value must be atomic. 
The value of the pte can change between storing the tmp value and 
calling pte_update().

Chris
