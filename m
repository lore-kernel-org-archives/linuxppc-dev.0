Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2102A1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 21:14:24 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vaibhav Jain' <vaibhav@linux.vnet.ibm.com>, 'Michael Ellerman'
 <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Frank Haverkamp <HAVERKAM@de.ibm.com>, "Matthew R. Ochs"
 <mrochs@linux.vnet.ibm.com>, "imunsie@au1.ibm.com" <imunsie@au1.ibm.com>
Subject: RE: cxl: Fix DSI misses when the context owning task exits
Date: Thu, 14 Jan 2016 10:11:16 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CCC5B73@AcuExch.aculab.com>
References: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <20160111091403.79FBE140323@ozlabs.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CCC4462@AcuExch.aculab.com>
 <87fuy0fvkw.fsf@vajain21.in.ibm.com>
In-Reply-To: <87fuy0fvkw.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Vaibhav Jain
> Sent: 14 January 2016 07:51
> David Laight <David.Laight@ACULAB.COM> writes:
>=20
> > I don't even claim to understand the linux model for handling process
> > address maps, nor what the cxl driver is doing, but the above looks
> > more than dodgy.
> >
> > 	David
>=20
> Thanks for reviewing the patch.
>=20
> Yes, It does look dodgy but is needed to handle a very corner case wherei=
n
> the task_struct that had originally allocated the cxl context exit
> without freeing it. In case of a multi threaded user-space process this
> context can still be used by other threads.

Right, and a non-threaded process might have done a fork+exit
with the fd open (etc).

> A cxl_context holds pid of the task that allocated it since we need
> access to the mm_struct associated with the task to handle storage
> faults reported by the capi accelerator. Now in case of a MT process if
> the thread that allocated the context exits the pid becomes invalid and
> we are no more able to handle faults from the accelerator even though
> the process is still alive.
>=20
> In such a case the patch tries to use the task group leader pid to find
> the next alive task in the task group which can be used to handle the
> storage fault.

Unless you are extremely careful whatever you are using for the 'pid'
can get reallocated.
=20
> We could have instead used only the task group leader for handling the
> faults but there is a possibility that even the task group leader has
> exited in which case the mm_struct associated with it will also be NULL.

It looks like you should be using mmap() to get the user pages accessible
to the driver - then you don't have a problem.

	David
