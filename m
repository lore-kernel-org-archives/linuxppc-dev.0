Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g0yV2lBFzF1f3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 10:40:33 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w480csJp096838
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 20:40:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htw750x9u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 20:40:30 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Tue, 8 May 2018 01:40:28 +0100
Subject: Re: [PATCH v2 3/7] powerpc: use task_pid_nr() for TID allocation
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com, corbet@lwn.net
Date: Tue, 08 May 2018 10:40:21 +1000
In-Reply-To: <b8aa28c4-9171-cb7f-9a43-22f2f15657b0@linux.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-4-alastair@au1.ibm.com>
 <b8aa28c4-9171-cb7f-9a43-22f2f15657b0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525740021.7796.45.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-07 at 19:37 +0200, Frederic Barrat wrote:
> 
> Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > The current implementation of TID allocation, using a global IDR,
> > may
> > result in an errant process starving the system of available TIDs.
> > Instead, use task_pid_nr(), as mentioned by the original author.
> > The
> > scenario described which prevented it's use is not applicable, as
> > set_thread_tidr can only be called after the task struct has been
> > populated.
> 
> 
> Here is how I understand what's going to happen if 2 threads are
> using 
> the same TIDR value, which is possible with this patch (if unlikely):
> 
> 1. waking up the wrong thread is not really a problem, as threads
> have 
> to handle spurious wake up from the 'wait' instruction anyway, and
> must 
> be using some other condition to know when to loop around the 'wait' 
> instruction.
> 
> 2. missing the right thread: if the wrong thread is on a CPU, and a 
> wake_host_thread/as_notify is sent, the core will see a matching
> thread 
> and will accept the command. The (open)capi adapter won't send an 
> interrupt. The wrong thread is awaken, which is not a problem as 
> discussed above. As the right thread to notify is not running, no
> harm 
> is done either: as soon as the thread runs, it's supposed to check
> its 
> condition (which will be met) or call 'wait', but 'wait' immediately 
> returns when called the first time after a thread is scheduled.
> 
> So I believe we are ok. But I think it requires a huge comment with
> the 
> above (at the minimum) :-)
> 
> With a comment:
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> 
>    Fred
> 

Good point, I'll add this in the next revision.


-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australiamob: 0423 762 819
