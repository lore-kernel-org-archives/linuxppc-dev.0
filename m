Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy6pr1CHkzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 03:55:31 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8KHs4cI021730
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 13:55:29 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3umvdfna-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 13:55:28 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Wed, 20 Sep 2017 11:55:28 -0600
Date: Wed, 20 Sep 2017 14:55:17 -0300
From: joserz@linux.vnet.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, andrew.donnellan@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc
Subject: Re: [PATCH] powerpc/eeh: Disable EEH stack dump by default
References: <1505831139-6053-1-git-send-email-joserz@linux.vnet.ibm.com>
 <87r2v2kmcz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87r2v2kmcz.fsf@concordia.ellerman.id.au>
Message-Id: <20170920175517.GA19761@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 20, 2017 at 02:47:08PM +1000, Michael Ellerman wrote:
> Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> writes:
> 
> > Today, each EEH causes a stack dump to be printed in the logs. In
> > production environment it's not quite necessary. Thus, this patch
> 
> I'm unconvinced. A production environment is exactly where you don't
> want to be getting an EEH, and so if you *do* then every bit of
> information is helpful.
> 
> > For example, instead of the following:
> >
> > [  131.778661] EEH: Frozen PHB#2-PE#fd detected
> > [  131.778672] EEH: PE location: N/A, PHB location: N/A
> > [  131.778677] CPU: 21 PID: 10098 Comm: lspci Not tainted ...
> > [  131.778680] Call Trace:
> > [  131.778686] [c0000003a140bab0] [c000000000beb58c] dump_stack+...
> > <snip ~10 lines>
> > [  131.778770] EEH: Detected PCI bus error on PHB#2-PE#fd
> > [  131.778775] EEH: This PCI device has failed 1 times in the last hour
> > ...
> >
> > we will have this by default:
> >
> > [12777.175880] EEH: Frozen PHB#2-PE#fd detected
> > [12777.175893] EEH: PE location: N/A, PHB location: N/A
> > [12777.175922] EEH: Detected PCI bus error on PHB#2-PE#fd
> > [12777.175931] EEH: This PCI device has failed 2 times in the last hour
> 
> *What* PCI device?
> 
> How am I supposed to know what device/driver just failed? If I had the
> stack trace I could probably at least work it out based on the driver
> involved.
> 
> cheers
> 

Thank you guys! More people told me it's important to keep it as is.
Please, disregard this patch.
