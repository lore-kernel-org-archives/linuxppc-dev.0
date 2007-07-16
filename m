Return-Path: <FENKES@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 28E2DDDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:12:26 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6GLCMDQ122728
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 21:12:22 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6GLCJnD1949726
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 23:12:22 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6GLCDdw026961
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 23:12:13 +0200
In-Reply-To: <adaabtww8qi.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 10/10] IB/ehca: Support large page MRs
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFD7499E67.C6B5EA9B-ONC125731A.00715FED-C125731A.007484A7@de.ibm.com>
Date: Mon, 16 Jul 2007 23:11:47 +0200
Content-Type: text/plain; charset="US-ASCII"
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

Roland Dreier <rdreier@cisco.com> wrote on 16.07.2007 19:37:09:

>  > If enabled via the mr_largepage module parameter, 
> 
> Why the module parameter?  Is there any reason a user would want to
> turn this off?  Or conversely, why is it off by default?

We're pretty confident this new feature works, but as with all new and 
possibly experimental features, there are chances it might explode your 
machine when activated. So, like with the scaling code, we want the user 
to make the conscious decision of using this code instead of activating it 
by default.
 
>  >  static ssize_t ehca_show_nr_eqs(struct device *dev,
>  >              struct device_attribute *attr,
>  >              char *buf)
>  >  {
>  >     return sprintf(buf, "%d\n", ehca_nr_eqs);
>  >  }
>  > -
>  >  static DEVICE_ATTR(nr_eqs, S_IRUGO, ehca_show_nr_eqs, NULL);
> 
> Although trivial, this chunk doesn't really belong in this patch --
> just fix it up in the multiple EQ patch (which I haven't merged yet).

Sure thing.

Regards,
  Joachim
