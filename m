Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65FB01A03C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 18:21:47 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Fri, 27 Nov 2015 00:21:45 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1D3313E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 00:21:38 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR7LcnH28573898
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 00:21:38 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR7LbI2001336
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 00:21:37 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2] powerpc/powernv: Add a kmsg_dumper that flushes
 console output on panic
In-Reply-To: <1448604913.1291.2.camel@russell.cc>
References: <1448421962-6174-1-git-send-email-ruscur@russell.cc>
 <m3oaegm24h.fsf@oc8180480414.ibm.com> <1448604913.1291.2.camel@russell.cc>
Date: Fri, 27 Nov 2015 18:21:27 +1100
Message-ID: <m3fuzrnc08.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell Currey <ruscur@russell.cc> writes:
> On Fri, 2015-11-27 at 16:40 +1100, Stewart Smith wrote:
>> Russell Currey <ruscur@russell.cc> writes:
>> > On BMC machines, console output is controlled by the OPAL firmware and=
 is
>> > only flushed when its pollers are called.=C2=A0=C2=A0When the kernel i=
s in a panic
>> > state, it no longer calls these pollers and thus console output does n=
ot
>> > completely flush, causing some output from the panic to be lost.
>> >=20
>> > This patch adds a new kmsg_dumper which gets called at panic time to e=
nsure
>> > panic output is not lost.=C2=A0=C2=A0It accomplishes this by calling
>> > OPAL_CONSOLE_FLUSH
>> > in the OPAL API, and if that is not available, the pollers are called
>> > enough
>> > times to (hopefully) completely flush the buffer.
>>=20
>> You may want to add to commit message that this depends on:
>> https://patchwork.ozlabs.org/patch/547379/
>>=20
> It doesn't *depend* on it, it's just preferred. =C2=A0It still works with=
 older
> Skiboot versions. =C2=A0I will mention it in the actual commit message fo=
r the
> next revision, though.

More meaning that it depends on that patch being merged before, say the
PCI hotplug patches, which add a *different* OPAL call at the same ID -
and that it depends on *this* patch with *this* API rather than a
modified one being merged.

Otherwise, if, say, I merged some other new OPAL call into skiboot
first, this patch would likely cause all sorts of trouble.

It's also a handy hint to Michael to ensure the skiboot side of things
is merged and okay before merging kernel things in.
