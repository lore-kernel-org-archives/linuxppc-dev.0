Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B658E1A0D12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 18:51:54 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 14 Jan 2016 17:51:54 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 95E662CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 18:51:50 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0E7phEo30998740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 18:51:52 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0E7pGUp023844
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 18:51:17 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>,
 "'Michael Ellerman'" <mpe@ellerman.id.au>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Frank Haverkamp <HAVERKAM@de.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "imunsie\@au1.ibm.com" <imunsie@au1.ibm.com>, vaibhav@linux.vnet.ibm.com
Subject: RE: cxl: Fix DSI misses when the context owning task exits
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CCC4462@AcuExch.aculab.com>
References: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <20160111091403.79FBE140323@ozlabs.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CCC4462@AcuExch.aculab.com>
Date: Thu, 14 Jan 2016 13:20:55 +0530
Message-ID: <87fuy0fvkw.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi David,


David Laight <David.Laight@ACULAB.COM> writes:

> I don't even claim to understand the linux model for handling process
> address maps, nor what the cxl driver is doing, but the above looks
> more than dodgy.
>
> 	David

Thanks for reviewing the patch.

Yes, It does look dodgy but is needed to handle a very corner case wherein
the task_struct that had originally allocated the cxl context exit
without freeing it. In case of a multi threaded user-space process this
context can still be used by other threads.

A cxl_context holds pid of the task that allocated it since we need
access to the mm_struct associated with the task to handle storage
faults reported by the capi accelerator. Now in case of a MT process if
the thread that allocated the context exits the pid becomes invalid and
we are no more able to handle faults from the accelerator even though
the process is still alive.

In such a case the patch tries to use the task group leader pid to find
the next alive task in the task group which can be used to handle the
storage fault.

We could have instead used only the task group leader for handling the
faults but there is a possibility that even the task group leader has
exited in which case the mm_struct associated with it will also be NULL.

Hope this clarifies things,

Cheers,
~ Vaibhav
