Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjXcR2V9czDrPp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 04:31:49 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QISHAp023550
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 14:31:47 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25q57dkfuv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 14:31:46 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 15:31:44 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id AD1CC352006C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 14:31:17 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QIVfbQ36831324
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 15:31:41 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QIVf9G011617
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 15:31:41 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
Date: Mon, 26 Sep 2016 15:31:38 -0300
In-Reply-To: <87y42mk11a.fsf@x220.int.ebiederm.org>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <15061913.JRHEL97DN3@hactar> <87y42mk11a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1743059.2ZOQaNILxh@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Eric,

Am Dienstag, 20 September 2016, 11:07:29 schrieb Eric W. Biederman:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > Am Samstag, 17 September 2016, 00:17:37 schrieb Eric W. Biederman:
> >> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > Is this what you had in mind?
> 
> Sort of.
> 
> I was just thinking that instead of having the boot path verify your ima
> list matches what is in the tpm and halting the boot there, we could
> test that on reboot.  Which would give a clean failure without the nasty
> poking into a prepared image.  The downside is that we have already run
> the shutdown scripts so it wouldn't be much cleaner, than triggering a
> machine reboot from elsewhere.
> 
> But I don't think we should spend too much time on that.  It was a
> passing thought.  We should focus on getting a non-poked ima buffer
> cleanly into kexec and we can worry about the rest later.

I was thinking of this as something orthogonal to the ima buffer feature.
But you're right, it's better not to discuss this now. I'll post a separate 
patch for this later.

> >> So from 10,000 feet I think that is correct.
> >> 
> >> I am not quite certain why a new mechanism is being invented.  We have
> >> other information that is already passed (much of it architecture
> >> specific) like the flattened device tree.  If you remove the need to
> >> update the information can you just append this information to the
> >> flattened device tree without a new special mechanism to pass the data?
> >> 
> >> I am just reluctant to invent a new mechanism when there is an existing
> >> mechanism that looks like it should work without problems.
> > 
> > Michael Ellerman suggested putting the buffer contents inside the device
> > tree itself, but the s390 people are also planning to implement this
> > feature. That architecture doesn't use device trees, so a solution that
> > depends on DTs won't help them.
> > 
> > With this mechanism each architecture will still need its own way of
> > communicating to the next kernel where the buffer is, but I think it's
> > easier to pass a base address and length than to pass a whole buffer.
> 
> A base address and length pair is fine.  There are several other pieces
> of data that we pass that way.
> 
> > I suppose we could piggyback the ima measurements buffer at the end of
> > one of the other segments such as the kernel or, in the case of
> > powerpc, the dtb but it looks hackish to me. I think it's cleaner to
> > put it in its own segment.
> 
> The boot protocol unfortunately is different on different architectures,
> and for each one we will have to implement and document the change.
> Because when you get into boot protocol issues you can't assume the
> kernel you are booting is the same version as the kernel that is booting
> it.
> 
> Where I run into a problem is you added a semi-generic concept a
> hand-over buffer.  Not a ima data buffer but a hand-over buffer.
> 
> The data falling in it's own dedicated area of memory and being added
> with kexec_add_buffer is completely fine.  I can see a dedicated pointer
> in struct kimage if necessary.
> 
> A semi-generic concept called a hand-over buffer seems to be a
> construction of infrustructure for no actual reason that will just
> result in confusion.  There are lots of things that are handed over, the
> flattend device tree, ramdisks, bootparams on x86, etc, etc.  ima is not
> special in this execpt for being perhaps the first addition that we are
> going to want the option of including on most architectures.

Ok, I understand. I decided to implement a generic concept because I thought 
that proposing a feature that is more useful than what I need it for would  
increase its chance of being accepted. It's interesting to see that it had 
the opposite effect.

I reworked and simplified the code and folded the hand-over buffer patches 
into Mimi's patch series to carry the measurement list across kexec. The 
kexec buffer code is in the following patches now:

[PATCH v5 01/10] powerpc: ima: Get the kexec buffer passed by the previous 
kernel
[PATCH v5 05/10] powerpc: ima: Send the kexec buffer to the next kernel

Each patch has a changelog listing what I changed to make it specific to 
IMA.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
