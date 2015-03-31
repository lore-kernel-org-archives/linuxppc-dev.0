Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A138C1A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 02:25:29 +1100 (AEDT)
Date: Tue, 31 Mar 2015 11:25:11 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
Message-ID: <20150331152511.GB20062@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB118E4@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB118E4@AcuExch.aculab.com>
Cc: "aik@au1.ibm.com" <aik@au1.ibm.com>,
 "anton@au1.ibm.com" <anton@au1.ibm.com>, "paulus@samba.org" <paulus@samba.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (03/31/15 15:15), David Laight wrote:
> 
> I've wondered whether the iommu setup for ethernet receive (in particular)
> could be made much more efficient if there were a function that
> would unmap one buffer and map a second buffer?
> My thought is that iommu pte entry used by the old buffer could just
> be modified to reference the new one.
> In effect each ring entry would end up using a fixed iommu pte.

There are a number of interesting things to investigate in
this space, and the above is just one of them, ways to avoid
the overhead of a full-blown map/unmap on each call. See 
  http://www.spinics.net/lists/sparclinux/msg13613.html

But the scope of this patchset is actually very rigidly defined:
to refactor the iommu pool/arena allocator into a common library,
and avoid code duplication (today even the single sparc arch
duplicates it for sun4[u,v] and ldc, and that's not even counting
the duplication across other archs/pci-drivers).

Investigating ways to provide a generalized infra that can
avoid a dma map/unmp for every packet would be a good follow-on.

> The other question is how much data can be copied in 26us ?
> On iommu systems 'copybreak' limits on receive and transmit
> may need to be quite high.

where does the "26us" number come from? I may be missing that context?

--Sowmini
