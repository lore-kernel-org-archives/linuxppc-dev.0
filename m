Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 600B92C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 05:15:29 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Fri, 20 Dec 2013 11:15:27 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2BF701FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 11:15:00 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBKIFOMf10355102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 19:15:24 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rBKIIU4l001799
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 11:18:30 -0700
Received: from oc3347516403.ibm.com ([9.80.82.166])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 rBKIIR9o001671
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 11:18:29 -0700
Date: Fri, 20 Dec 2013 12:15:21 -0600
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv: eeh: fix possible buffer overrun in
 ioda_eeh_phb_diag()
Message-ID: <20131220181520.GA5480@oc3347516403.ibm.com>
References: <20131219231407.GA22418@oc3347516403.ibm.com>
 <20131220013539.GA10795@shangw.(null)>
 <20131220015937.GA13868@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131220015937.GA13868@shangw.(null)>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 20, 2013 at 09:59:37AM +0800, Gavin Shan wrote:
> On Fri, Dec 20, 2013 at 09:35:39AM +0800, Gavin Shan wrote:
> >On Thu, Dec 19, 2013 at 05:14:07PM -0600, Brian W Hart wrote:
> >>PHB diagnostic buffer may be smaller than PAGE_SIZE, especially when
> >>PAGE_SIZE > 4KB.
> >>
> >
> >I think you're talking about that PAGE_SIZE could be configured
> >to have variable size (e.g. 4KB). So it's not safe to pass PAGE_SIZE
> >to OPAL API opal_pci_get_phb_diag_data2(). Instead, we should pass
> >PNV_PCI_DIAG_BUF_SIZE and it makes sense to me :-)

Yeah, I noticed the problem because our test machine has PAGE_SIZE of
64K with the buffer only being 8K.

[...]
> Sorry, Brian. It has been fixed as part of the following commit, which
> has been put into Ben's powerpc-next branch :-)

Thank you!
