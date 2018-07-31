Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fvCV09NDzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 21:21:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, ray.jui@broadcom.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Sam Bobroff  <sbobroff@linux.ibm.com>
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
In-Reply-To: <20180727222540.GH173328@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
 <20180718232904.GJ128988@bhelgaas-glaptop.roam.corp.google.com>
 <65dd986d0b8b2ebe5132b365dabb2dbaaed9177f.camel@kernel.crashing.org>
 <20180727222540.GH173328@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 31 Jul 2018 21:21:37 +1000
Message-ID: <87a7q7hcqm.fsf@concordia.ellerman.id.au>
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

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Thu, Jul 19, 2018 at 02:18:09PM +1000, Benjamin Herrenschmidt wrote:
>> On Wed, 2018-07-18 at 18:29 -0500, Bjorn Helgaas wrote:
>> > [+cc Paul, Michael, linuxppc-dev]
>> > 
>> 
>>    ..../...
>> 
>> > > Debugging revealed a race condition between pcie core driver
>> > > enabling is_added bit(pci_bus_add_device()) and nvme driver
>> > > reset work-queue enabling is_busmaster bit (by pci_set_master()).
>> > > As both fields are not handled in atomic manner and that clears
>> > > is_added bit.
>> > > 
>> > > Fix moves device addition is_added bit to separate private flag
>> > > variable and use different atomic functions to set and retrieve
>> > > device addition state. As is_added shares different memory
>> > > location so race condition is avoided.
>> > 
>> > Really nice bit of debugging!
>> 
>> Indeed. However I'm not fan of the solution. Shouldn't we instead have
>> some locking for the content of pci_dev ? I've always been wary of us
>> having other similar races in there.
>> 
>> As for the powerpc bits, I'm probably the one who wrote them, however,
>> I'm on vacation this week and right now, no bandwidth to context switch
>> all that back in :-) So give me a few days and/or ping me next week.
>
> OK, here's a ping :)
>
> Some powerpc cleanup would be ideal, but I'd like to fix the race for
> v4.19, so I'm fine with this patch as-is.  But I'd definitely want
> your ack before inserting the ugly #include path in the powerpc code.

Sorry, the patch didn't hit linuxppc so I forgot about it.

I'm OK with the patch, the include is a bit gross, but I guess it's
fine.

I have a change to pseries/setup.c queued that might collide, though
it's just an addition of another include so it's a trivial fixup.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


In terms of longer term clean up, do you have a sketch of what you'd
like to see?

cheers
