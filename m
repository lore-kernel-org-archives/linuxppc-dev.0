Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 85928B6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 02:22:43 +1000 (EST)
Received: by iwn39 with SMTP id 39so1174582iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 09:22:41 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279207159.30737.11.camel@localhost>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Jul 2010 10:22:21 -0600
Message-ID: <AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
To: Matthew McClintock <msm@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 15, 2010 at 9:19 AM, Matthew McClintock <msm@freescale.com> wro=
te:
> On Thu, 2010-07-15 at 00:21 -0600, Grant Likely wrote:
>> On Wed, Jul 14, 2010 at 9:18 AM, Matthew McClintock
>> <msm@freescale.com> wrote:
>> > To build a proper flat device tree for kexec we need to know which
>> > memreserve region was used for the device tree for the currently
>> > running kernel, so we can remove it and replace it with the new
>> > memreserve for the kexec'ed kernel
>> >
>> > Signed-off-by: Matthew McClintock <msm@freescale.com>
>>
>> Hi Matthew.
>>
>> I don't understand. =A0Why does userspace need to know about the old
>> memreserve sections? =A0Doesn't kexec tear down all of the old
>> allocations anyway? =A0How are they relevant for constructing the dtb
>> for the kexec kernel? =A0I'll need a lot more details before I consider
>> merging this.
>>
>> Also, please cc: me and Ben Herrenschmidt on powerpc related device
>> tree changes.
>>
>> Cheers,
>> g.
>
> Grant,
>
> Thanks for taking a look. My first thought was to just blow away all the
> memreserve regions and start over. But, there are reserve regions for
> other things that I might not want to blow away. For example, on mpc85xx
> SMP systems we have an additional reserve region for our boot page.

What is your starting point?  Where does the device tree (and
memreserve list) come from
that you're passing to kexec?  My first impression is that if you have
to scrub the memreserve list, then the source being used to
obtain the memreserves is either faulty or unsuitable to the task.

g.
