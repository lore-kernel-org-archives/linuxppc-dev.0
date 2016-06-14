Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTXZB6VLczDqdy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 00:48:02 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EEhpA6092993
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:48:00 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jch48e6g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:48:00 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 10:47:59 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [v5,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <201605250723.u4P7IYhH011389@mx0a-001b2d01.pphosted.com>
Date: Tue, 14 Jun 2016 09:47:51 -0500
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>
References: <1464007742-1941-1-git-send-email-felix@linux.vnet.ibm.com>
 <87mvngx7oq.fsf@vajain21.in.ibm.com>
 <324850BE-6213-41ED-87B1-33A726D56AD8@linux.vnet.ibm.com>
 <201605250723.u4P7IYhH011389@mx0a-001b2d01.pphosted.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Message-Id: <3A7B845C-450D-469C-A547-8DB420CE1CCD@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav/Philippe,

Finally getting back around to looking at this.


-matt

> On May 25, 2016, at 2:22 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> =
wrote:
>=20
> Hi Matt,
>=20
> "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:
>> The purpose for the count is so the AFU driver is only called when it
>> has something to send. Otherwise we don't want to be called.
>=20
> Agreed, but this opens up a possible boundary condition where in we =
have
> non-zero event count and deliver_event callback returns a NULL/empty
> struct (This isn't handled correctly at the moment). Imo the condition
> event-count =3D=3D number-of-calls-to-deliver_events is bit too rigid.
>=20
> Instead a more relaxed condition can be =
number-of-calls-to-deliver_event =3D=3D
> count-until-deliver_event-returns-NULL. This could be implemented as
> boolean flag inside the context to indicate that afu-driver has some
> events queued. This flag can be set when cxl_context_events_pending =
gets
> called. The cxl code can simply call deliver_event on each read call
> until it returns NULL in which case this boolean flag is reset.

We're fine with being called until we return NULL. We just don't want to
always be called. =3D)

I believe the earlier discussions we had with Ian indicated that us =
returning
NULL (effectively 'failing') could be problematic for the read handler. =
Perhaps
this is no longer the case with the updated patch.

Regardless of your internal implementation, we would still like for the =
API
we call to indicate the number of events we've enqueued and desire to =
send
to the user. This will allow for flexibility in the future should your =
internal
implementation change.

>=20
> This should slightly simplify the code flow at the afu-driver end as
> enquing to an event need not be paired by a call to
> cxl_context_events_pending. It can quite possibly enqueue bunch of
> events and then do a single call to cxl_context_events_pending. In =
this
> case the function cxl_context_events_pending essentially works more =
like
> a function named as cxl_context_events_flush.
>=20
> ~ Vaibhav
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
