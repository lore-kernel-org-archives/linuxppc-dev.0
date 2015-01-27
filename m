Return-Path: <benh@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F4801A0666
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 10:59:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 28 Jan 2015 09:59:42 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6FDE92BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 10:59:40 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0RNxVRw33030152
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 10:59:40 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0RNx6uI029394
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 10:59:06 +1100
Message-ID: <1422403122.4949.123.camel@au1.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if
 required
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 28 Jan 2015 10:58:42 +1100
In-Reply-To: <54C81800.6070407@linux.vnet.ibm.com>
References: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1421746096.4949.40.camel@kernel.crashing.org>
 <20150120225607.GA12174@shangw> <20150120235338.GA5280@shangw>
 <20150123035029.GA19657@shangw>
 <1422093450.4949.89.camel@kernel.crashing.org>
 <54C6CF73.7000403@linux.vnet.ibm.com>
 <1422333116.4949.100.camel@au1.ibm.com>
 <54C81800.6070407@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, wenxiong@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-27 at 16:58 -0600, Brian King wrote:
> I'd argue we are our own worst enemy here really. The new user is EEH
> code.
> I don't see a huge reason that code would need to use this exact same
> API.
> 
> > In fact, even with IPR and the existing call, how do you wait for
> the link to come
> > back for a PERST ? That can take a while...
> 
> Basically, I assert reset, delay for 1/2 second via a timer interrupt,
> deassert reset,
> delay for 2 seconds via another timer interrupt, then proceed with
> adapter initialization.

I'm surprised that even works properly... for example in the case of
PERST we need to mask various error traps before asserting and unmask
them when the link comes up (such as the surprise link down error), I
don't see an opportunity in that scheme for FW to do that latter...

Ben.
