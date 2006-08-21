Return-Path: <kmannth@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id E40DB679E0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 04:52:41 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c2so2109666nfe
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 11:52:39 -0700 (PDT)
Message-ID: <a762e240608211152x5d4f11f0wd26f7e3d75d38e0a@mail.gmail.com>
Date: Mon, 21 Aug 2006 11:52:39 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Mel Gorman" <mel@csn.ul.ie>
Subject: Re: [PATCH 0/6] Sizing zones and holes in an architecture independent
	manner V9
In-Reply-To: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
Cc: akpm@osdl.org, tony.luck@intel.com, linuxppc-dev@ozlabs.org, ak@suse.de,
	bob.picco@hp.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/21/06, Mel Gorman <mel@csn.ul.ie> wrote:
> This is V9 of the patchset to size zones and memory holes in an
> architecture-independent manner. It booted successfully on 5 different
> machines (arches were x86, x86_64, ppc64 and ia64) in a number of different
> configurations and successfully built a kernel. If it fails on any machine,
> booting with loglevel=8 and the console log should tell me what went wrong.
>

I am wondering why this new api didn't cleanup the pfn_to_nid code
path as well. Arches are left to still keep another set of
nid-start-end info around. We are sending info like

add_active_range(unsigned int nid, unsigned long start_pfn, unsigned
long end_pfn)

With this info making a common pnf_to_nid seems to be of intrest so we
don't have to keep redundant information in both generic and arch
specific data structures.

Are you intending the hot-add memory code path to call add_active_range or ???

Thanks,
  Keith
