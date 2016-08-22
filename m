Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHfQ26Kx1zDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 13:36:58 +1000 (AEST)
Date: Mon, 22 Aug 2016 11:36:43 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-ima-devel@lists.sourceforge.net,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 3/6] kexec_file: Allow skipping checksum calculation
 for some segments.
Message-ID: <20160822033643.GA30937@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <105132489.pljZvDuEBr@hactar>
 <20160822031745.GA30489@dhcp-128-65.nay.redhat.com>
 <3959832.c4ESAKX1ch@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3959832.c4ESAKX1ch@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/16 at 12:25am, Thiago Jung Bauermann wrote:
> Am Montag, 22 August 2016, 11:17:45 schrieb Dave Young:
> > On 08/18/16 at 06:09pm, Thiago Jung Bauermann wrote:
> > > Hello Dave,
> > > 
> > > Thanks for your review!
> > > 
> > > [ Trimming down Cc: list a little to try to clear the "too many
> > > recipients"> 
> > >   mailing list restriction. ]
> > 
> > I also got "too many recipients".. Thanks for the trimming.
> 
> Didn't work though. What is the maximum number of recipients?

I have no idea as well..

> 
> > > Am Donnerstag, 18 August 2016, 17:03:30 schrieb Dave Young:
> > > > On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> > > > > Adds checksum argument to kexec_add_buffer specifying whether the
> > > > > given
> > > > > segment should be part of the checksum calculation.
> > > > 
> > > > Since it is used with add buffer, could it be added to kbuf as a new
> > > > field?
> > > 
> > > I was on the fence about adding it as a new argument to kexec_add_buffer
> > > or as a new field to struct kexec_buf. Both alternatives make sense to
> > > me. I implemented your suggestion in the patch below, what do you
> > > think?> 
> > > > Like kbuf.no_checksum, default value is 0 that means checksum is
> > > > needed
> > > > if it is 1 then no need a checksum.
> > > 
> > > It's an interesting idea and I implemented it that way, though in
> > > practice all current users of struct kexec_buf put it on the stack so
> > > the field needs to be initialized explicitly.
> > 
> > No need to set it as false because it will be initialized to 0 by
> > default?
> 
> As far as I know, variables on the stack are not initialized. Only global 
> and static variables are.

But designated initializers will do it.

Thanks
Dave
