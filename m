Return-Path: <cl@linux.com>
Received: from qmta13.emeryville.ca.mail.comcast.net
 (qmta13.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:44:76:96:27:243])
 by ozlabs.org (Postfix) with ESMTP id 397F22C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 04:25:34 +1100 (EST)
Date: Thu, 6 Feb 2014 11:25:29 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] slub: Don't throw away partial remote slabs if there is
 no local memory
In-Reply-To: <20140206020833.GD5433@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1402061124540.5348@nuc>
References: <alpine.DEB.2.02.1401241618500.20466@chino.kir.corp.google.com>
 <20140125011041.GB25344@linux.vnet.ibm.com> <20140127055805.GA2471@lge.com>
 <20140128182947.GA1591@linux.vnet.ibm.com>
 <20140203230026.GA15383@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402032138070.17997@nuc>
 <20140204072630.GB10101@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402041436150.11222@nuc>
 <20140205001352.GC10101@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402051312430.21661@nuc>
 <20140206020833.GD5433@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 David Rientjes <rientjes@google.com>, penberg@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, Anton Blanchard <anton@samba.org>, mpm@selenic.com,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Feb 2014, Nishanth Aravamudan wrote:

> > Right so if we are ignoring the node then the simplest thing to do is to
> > not deactivate the current cpu slab but to take an object from it.
>
> Ok, that's what Anton's patch does, I believe. Are you ok with that
> patch as it is?

No. Again his patch only works if the node is memoryless not if there are
other issues that prevent allocation from that node.
