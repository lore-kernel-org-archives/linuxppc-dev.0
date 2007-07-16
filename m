Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 6E57BDDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 03:37:13 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 10/10] IB/ehca: Support large page MRs
References: <200707121745.27592.fenkes@de.ibm.com>
	<200707121754.20293.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 16 Jul 2007 10:37:09 -0700
In-Reply-To: <200707121754.20293.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Thu, 12 Jul 2007 17:54:19 +0200")
Message-ID: <adaabtww8qi.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Add support for MR pages larger than 4K on eHCA2. This reduces firmware
 > memory consumption. If enabled via the mr_largepage module parameter, the MR
 > page size will be determined based on the MR length and the hardware
 > capabilities - if the MR is >= 16M, 16M pages are used, for example.

Why the module parameter?  Is there any reason a user would want to
turn this off?  Or conversely, why is it off by default?

Also this patch seems to depend heavily on the multiple EQ patch,
which I am holding off on now.  So you may want to rebase to my
current tree, which has all the ehca patches except the EQ one.

 >  static ssize_t ehca_show_nr_eqs(struct device *dev,
 >  				struct device_attribute *attr,
 >  				char *buf)
 >  {
 >  	return sprintf(buf, "%d\n", ehca_nr_eqs);
 >  }
 > -
 >  static DEVICE_ATTR(nr_eqs, S_IRUGO, ehca_show_nr_eqs, NULL);

Although trivial, this chunk doesn't really belong in this patch --
just fix it up in the multiple EQ patch (which I haven't merged yet).

 - R.
