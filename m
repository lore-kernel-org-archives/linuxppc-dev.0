Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8H4R0X7LzDqhH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 13:41:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
In-Reply-To: <3544655.o5QPxko4Ba@hactar>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
Date: Wed, 10 Aug 2016 13:41:08 +1000
Message-ID: <87r39xthnv.fsf@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
>> On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
>> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> > > diff --git a/security/integrity/ima/ima.h
>> > > b/security/integrity/ima/ima.h
>> > > index b5728da..84e8d36 100644
>> > > --- a/security/integrity/ima/ima.h
>> > > +++ b/security/integrity/ima/ima.h
>> > > @@ -102,6 +102,13 @@ struct ima_queue_entry {
>> > > 
>> > >  };
>> > >  extern struct list_head ima_measurements;	/* list of all 
> measurements
>> > >  */
>> > > 
>> > > +/* Some details preceding the binary serialized measurement list */
>> > > +struct ima_kexec_hdr {
>> > > +	unsigned short version;
>> > > +	unsigned long buffer_size;
>> > > +	unsigned long count;
>> > > +} __packed;
>> > > +
>> > 
>> > Am I understanding it correctly that this structure is passed between
>> > kernels?
>> Yes, the header prefixes the measurement list, which is being passed on
>> the same computer to the next kernel.  Could the architecture (eg.
>> LE/BE) change between soft re-boots?
>
> Yes. I am able to boot a BE kernel from an LE kernel with my patches. 
> Whether we want to support that or not is another question...

Yes you must support that. BE -> LE and vice versa.

You should also consider the possibility that the next kernel is not
Linux.

cheers
