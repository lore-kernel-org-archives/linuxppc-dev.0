Return-Path: <mst@dev.mellanox.co.il>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 3D688DDEC7
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 07:32:23 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so297884anc
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:32:23 -0700 (PDT)
Date: Wed, 18 Jul 2007 00:32:15 +0300
From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
Message-ID: <20070717213215.GC17168@mellanox.co.il>
References: <OF2377E85C.B05BDE94-ONC125731A.006E64A7-C125731A.00714F9E@de.ibm.com>
	<ada1wf7vgfb.fsf@cisco.com> <20070717043740.GB8527@mellanox.co.il>
	<adalkdesyrs.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adalkdesyrs.fsf@cisco.com>
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Quoting Roland Dreier <rdreier@cisco.com>:
> Subject: Re: [PATCH 01/10] IB/ehca: Support for multiple event queues
> 
>  > Here's some anecdotal evidence :)
>  > http://lists.openfabrics.org/pipermail/general/2007-May/035758.html
> 
> Right, but then we went on to say that we probably want to use
> multiple vectors to separate out multiple HCA ports rather than
> send/sreceive on the same port.  And the current IPoIB implementation
> of having that second CQ seems suboptimal anyway, since it seems to
> leave us susceptible to the interrupt overload that NAPI was supposed
> to solve.

Sure, the ipoib patch is just a proof of concept anyway.
And I'm actually working on merging send/recv CQs now,
to address the livelocks.

> At a higher level, I'm left wondering why nobody talked about multiple
> EQs during the last months of the 2.6.22 process and now all of a
> sudden it becomes urgent in the last few days of the 2.6.23 merge
> window.

I don't see any emergency in merging the IPoIB hack either.

I just hoped that once we merge the core changes people will start
experimenting with multiple vectors. This did not seem to have happened.
Could this be because there's no low level driver support upstream yet?

So I wonder whether merging the mthca patch [that was patch 2 of the series]
in 2.6.23 will finally get the
ball rolling, get people to experiment with multiple vectors
in userspace, and that will hopefully teach us something.

> That's not really how I like to merge features....

If you look just at the mthca patch in isolation,
do you still see a problem?

-- 
MST
