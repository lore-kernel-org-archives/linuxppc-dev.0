Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id E31ABB6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 11 Jul 2010 14:14:51 +1000 (EST)
Received: from [192.168.1.20] (millhouse.elkhashab.com [192.168.1.20])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	o6B4EgHg025702
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jul 2010 23:14:42 -0500
Message-ID: <4C39451A.201@elkhashab.com>
Date: Sat, 10 Jul 2010 23:14:18 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Problems mapping OCM memory from 460EX to user space
References: <20100707194846.GA724@crust.elkhashab.com>
In-Reply-To: <20100707194846.GA724@crust.elkhashab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/7/2010 2:48 PM, ayman@austin.rr.com wrote:
>   rc = io_remap_pfn_range(vma, PLB_OCM_BASE_ADDR>>PAGE_SHIFT, vma->vm_start, len, vma->vm_page_prot);
>
> I am fairly certain the physical address is correct, I've verified that the
> TLB entries in u-boot look ok.  Any tips on how to make this work?
>
>    

I found / fixed the issue.  The first problem is that start and offset 
are swapped in the io_remap_pfn_range invocation.  The 2nd was that
there were some TLB changes that were needed to map the OCM.
