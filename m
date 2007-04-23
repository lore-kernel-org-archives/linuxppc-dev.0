Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 6B28DDDF07
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:20:20 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] eHCA: Add "Modify Port" verb
References: <200704231823.48723.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 23 Apr 2007 12:20:14 -0700
In-Reply-To: <200704231823.48723.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Mon, 23 Apr 2007 18:23:48 +0200")
Message-ID: <ada3b2q7v9t.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > +	if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != H_SUCCESS) {
 > +		ehca_err(&shca->ib_device, "Can't query port properties");
 > +		ret = -EINVAL;
 > +		goto modify_port1;
 > +	}
 > +
 > +	cap = (rblock->capability_mask | props->set_port_cap_mask)
 > +		& ~props->clr_port_cap_mask;
 > +
 > +	hret = hipz_h_modify_port(shca->ipz_hca_handle, port,
 > +				  cap, props->init_type, port_modify_mask);

Is this thread-safe?  What if two different bits are set at the same
time from two different threads?  It seems that both calls could get
the same result from hipz_h_query_port(), and then the second call to
hipz_h_modify_port() would overwrite the first call.

You could look at the implementation in mthca to see the locking I
used there.

 - R.
