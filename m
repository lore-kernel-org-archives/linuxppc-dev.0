Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F85067BBD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 20:25:14 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kAM9P2FP075430
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 09:25:05 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kAM9RpBC2605160
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 09:27:51 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kAM9OxxU011090
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 09:25:00 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address
	to determine pending work requests
Date: Wed, 22 Nov 2006 10:29:09 +0100
References: <200611202354.13030.hnguyen@linux.vnet.ibm.com>
	<adaslgcg30n.fsf@cisco.com>
In-Reply-To: <adaslgcg30n.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611221029.10077.hnguyen@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(2nd try, since I forgot to post this on the mailing list)
On Tuesday 21 November 2006 17:47, Roland Dreier wrote:
> Umm, it's really late to merge things for 2.6.19.  How severe is this
> bug?  Why has it not been found until now if it causing crashes?
We found this bug actually through a code review by random. Since
(un)fortunately the queue pages were layouted in order, we've not
seen it earlier. It's certainly a bug and can cause kernel panic 
if above observation is not met, probably in stress situation
of system. That means the "former" code accesses next page that 
it has not allocated.
Thanks
Nam
