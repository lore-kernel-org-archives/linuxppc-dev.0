Return-Path: <htejun@gmail.com>
Received: from mail-qc0-x22e.google.com (mail-qc0-x22e.google.com
 [IPv6:2607:f8b0:400d:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BA741A04B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 09:18:12 +1100 (AEDT)
Received: by qcxn11 with SMTP id n11so24335076qcx.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 14:18:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 5 Mar 2015 17:18:07 -0500
From: Tejun Heo <tj@kernel.org>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305221807.GH23912@htj.duckdns.org>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <1425592132.13327.0.camel@ellerman.id.au>
 <alpine.DEB.2.10.1503051352540.25375@chino.kir.corp.google.com>
 <20150305220804.GF23912@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150305220804.GF23912@htj.duckdns.org>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 05, 2015 at 05:08:04PM -0500, Tejun Heo wrote:
> It can be argued that we should always stick to the online masks for
> allocation and iteration; however, that usually requires more
> complexity and the only cases where this mattered have been when the
> boot code got it wrong and failed to set the possible masks correctly,
> which also seems to be the case here.  I don't see any reason to
> deviate here.

Hmm... but yeah, as you wrote, keeping the allocation local could be a
reason but let's please not do this just to reduce memory consumption.
If memory locality of the field affects performance noticeably, sure.

Thanks.

-- 
tejun
