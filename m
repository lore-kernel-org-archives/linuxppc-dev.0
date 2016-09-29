Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slSlw5KW1zDsj2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 07:45:00 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <15061913.JRHEL97DN3@hactar> <87y42mk11a.fsf@x220.int.ebiederm.org>
 <1743059.2ZOQaNILxh@hactar>
Date: Thu, 29 Sep 2016 16:43:08 -0500
In-Reply-To: <1743059.2ZOQaNILxh@hactar> (Thiago Jung Bauermann's message of
 "Mon, 26 Sep 2016 15:31:38 -0300")
Message-ID: <87eg42xtzn.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATHC v2 0/9] ima: carry the measurement list across kexec
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Hello Eric,
>
> Am Dienstag, 20 September 2016, 11:07:29 schrieb Eric W. Biederman:
>> A semi-generic concept called a hand-over buffer seems to be a
>> construction of infrustructure for no actual reason that will just
>> result in confusion.  There are lots of things that are handed over, the
>> flattend device tree, ramdisks, bootparams on x86, etc, etc.  ima is not
>> special in this execpt for being perhaps the first addition that we are
>> going to want the option of including on most architectures.
>
> Ok, I understand. I decided to implement a generic concept because I thought 
> that proposing a feature that is more useful than what I need it for would  
> increase its chance of being accepted. It's interesting to see that it had 
> the opposite effect.

Yes.  In this case it was not clear that anyone else could use it, and
being less generic you can tweak the needs of the code to ima without
anyone having to worry about it.

So thank you very much for making the code more specific to the circumstances.

> I reworked and simplified the code and folded the hand-over buffer patches 
> into Mimi's patch series to carry the measurement list across kexec. The 
> kexec buffer code is in the following patches now:
>
> [PATCH v5 01/10] powerpc: ima: Get the kexec buffer passed by the previous 
> kernel
> [PATCH v5 05/10] powerpc: ima: Send the kexec buffer to the next
> kernel

That plus  [PATCH v5 06/10] ima: on soft reboot, save the measurement list

> Each patch has a changelog listing what I changed to make it specific to 
> IMA.

I am a little sad to see you needed to modify kexec_file.c to get where
you were going, but that isn't a huge issue either way.

Eric
