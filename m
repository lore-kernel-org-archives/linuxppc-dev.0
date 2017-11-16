Return-Path: <jesse.brandeburg@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydFZ9167jzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 09:01:18 +1100 (AEDT)
Date: Thu, 16 Nov 2017 14:01:12 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Brian King <brking@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <brking@pobox.com>, <alexander.h.duyck@intel.com>,
 <dipankar@linux.vnet.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Intel-wired-lan] [PATCH 0/7] [RESEND] [net] intel: Use smp_rmb
 rather than read_barrier_depends
Message-ID: <20171116140112.00007c89@intel.com>
In-Reply-To: <f360a8cd-518c-1df5-5ffd-91a0e9688ce2@linux.vnet.ibm.com>
References: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
 <20171116113358.00001d5a@intel.com>
 <f360a8cd-518c-1df5-5ffd-91a0e9688ce2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 16 Nov 2017 14:03:02 -0600
Brian King <brking@linux.vnet.ibm.com> wrote:
> I did think about changing the powerpc definition of read_barrier_depends,
> but after reading up on that barrier, decided it was not the correct barrier
> to be used in this context. Here is some good historical background on
> read_barrier_depends that I found, along with an example.
> 
> https://lwn.net/Articles/5159/
> 
> Since there is no data-dependency in the code in question here, I think
> the smp_rmb is the proper barrier to use.

Hey Brian, thanks for the explanation, I'll agree with you and Alex
that the smb_rmb replacement is okay.  Does your test still pass
without the ->skb NULLs?
