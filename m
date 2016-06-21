Return-Path: <zhong@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYXSs5bgxzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:57:17 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L2rbmf066044
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:57:15 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23mywwmaeq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:57:15 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:57:14 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC PATCH 2/2] KVM: PPC: Don't take lock when check irq's resend
 flag
From: Li Zhong <zhong@linux.vnet.ibm.com>
In-Reply-To: <20160620052717.GC29366@fergus.ozlabs.ibm.com>
Date: Tue, 21 Jun 2016 10:57:05 +0800
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>, agraf@suse.com
References: <1463381898.19947.6.camel@TP420> <1463382133.19947.10.camel@TP420>
 <20160620052717.GC29366@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Message-Id: <F9346574-6364-43F2-ADA2-BA60E3D79E47@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On Jun 20, 2016, at 13:27, Paul Mackerras <paulus@ozlabs.org> wrote:
>=20
> On Mon, May 16, 2016 at 03:02:13PM +0800, Li Zhong wrote:
>> It seems that we don't need to take the lock before evaluating irq's
>> resend flag. What needed is to make sure when we clear the ics's bit
>> in the icp's resend_map, we don't miss the resend flag of the irqs
>> that set the bit.
>>=20
>> And seems this could be ordered through the barrier in =
test_and_clear_bit(),
>> and an newly added wmb when setting irq's resend flag, and icp's =
resend_map.
>=20
> This looks fine to me.  Is there a measurable performance improvement
> from this?  I understand it could be hard to measure.
>=20
> Also, you could make the patch description more definite - just say
> that we don't need to take the lock, there's no need for "seems=E2=80=9D=
.

OK :)

However, we may need to ignore this one for now. To implement the P/Q =
stuff, we probably need make sure the resend irqs to be resent only =
once. It=E2=80=99s easier to make sure that with the lock here, and the =
resend flag can be cleared inside the lock.=20

Thanks, Zhong
=20
>=20
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
