Return-Path: <mkravetz@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED94D67BA5
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 10:41:56 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6F0frkw008082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 20:41:53 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6F0fqhD279712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 20:41:53 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6F0fqai008718
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 20:41:52 -0400
Date: Fri, 14 Jul 2006 17:41:56 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060715004156.GJ6824@monkey.ibm.com>
References: <20060714233739.GA11487@monkey.ibm.com>
	<20060714234034.GC11487@monkey.ibm.com>
	<20060715001545.GK19076@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060715001545.GK19076@localdomain>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 14, 2006 at 07:15:45PM -0500, Nathan Lynch wrote:
> Hmm, isn't it possible that the stats could be corrupted if we process
> an interrupt/softirq which does an hcall while the stats are being
> updated?  Maybe it's not a show-stopper, but it seems to me that
> accuracy could suffer under some workloads.

Yes, they can become inaccurate.  Is this what you mean by 'corrupted' or
you thinking of something worse?

There is going to be a trade off between accuracy and the overhead of the
data gathering.  What really needs to happen is some good benchmarking to
measure the costs of different approaches.  I'm pretty sure I can get
someone to provide such data.

In this patch, I have minimized the overhead in data collection at the
cost of accuracy.

-- 
Mike
