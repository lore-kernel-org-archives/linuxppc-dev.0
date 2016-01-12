Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D6AE1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 09:59:42 +1100 (AEDT)
Message-ID: <1452639582.14097.2.camel@ellerman.id.au>
Subject: Re: cxl: Fix DSI misses when the context owning task exits
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>, Vaibhav Jain
 <vaibhav@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Cc: Frank Haverkamp <HAVERKAM@de.ibm.com>, "Matthew R. Ochs"
 <mrochs@linux.vnet.ibm.com>, "imunsie@au1.ibm.com" <imunsie@au1.ibm.com>
Date: Wed, 13 Jan 2016 09:59:42 +1100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CCC4462@AcuExch.aculab.com>
References: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <20160111091403.79FBE140323@ozlabs.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CCC4462@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-12 at 13:29 +0000, David Laight wrote:
> From: Michael Ellerman
> > Sent: 11 January 2016 09:14
> > On Tue, 2015-24-11 at 10:56:18 UTC, Vaibhav Jain wrote:
> > > Presently when a user-space process issues CXL_IOCTL_START_WORK ioctl we
> > > store the pid of the current task_struct and use it to get pointer to
> > > the mm_struct of the process, while processing page or segment faults
> > > from the capi card. However this causes issues when the thread that had
> > > originally issued the start-work ioctl exits in which case the stored
> > > pid is no more valid and the cxl driver is unable to handle faults as
> > > the mm_struct corresponding to process is no more accessible.
> > > 
> > > This patch fixes this issue by using the mm_struct of the next alive
> > > task in the thread group. This is done by iterating over all the tasks
> > > in the thread group starting from thread group leader and calling
> > > get_task_mm on each one of them. When a valid mm_struct is obtained the
> > > pid of the associated task is stored in the context replacing the
> > > exiting one for handling future faults.
> 
> I don't even claim to understand the linux model for handling process
> address maps, nor what the cxl driver is doing, but the above looks
> more than dodgy.

Thanks for reviewing it!

cheers
