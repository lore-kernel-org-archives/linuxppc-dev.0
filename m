Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B3601A09C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 16:41:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 20 Nov 2014 15:41:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2F9BF2BB0061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 16:41:01 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAK5grJB29491412
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 16:42:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAK5f0EM003275
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 16:41:00 +1100
Date: Thu, 20 Nov 2014 13:40:58 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size()
 interface
Message-ID: <20141120054058.GB8562@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141119011243.GA23467@google.com>
 <1416363332.5704.18.camel@au1.ibm.com>
 <20141119032100.GA7105@richard> <20141119042601.GB23467@google.com>
 <20141119092740.GA12872@richard>
 <20141119172350.GC23467@google.com>
 <1416430300.5704.35.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416430300.5704.35.camel@au1.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Myron Stowe <myron.stowe@redhat.com>,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 Donald Dutile <ddutile@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2014 at 07:51:40AM +1100, Benjamin Herrenschmidt wrote:
>On Wed, 2014-11-19 at 10:23 -0700, Bjorn Helgaas wrote:
>> 
>> Yes, I've read that many times.  What's missing is the connection between a
>> PE and the things in the PCI specs (buses, devices, functions, MMIO address
>> space, DMA, MSI, etc.)  Presumably the PE structure imposes constraints on
>> how the core uses the standard PCI elements, but we don't really have a
>> clear description of those constraints yet.
>
>Right, a "PE" is a HW concept in fact in our bridges, that essentially is
>a shared isolation state between DMA, MMIO, MSIs, PCIe error messages,...
>for a given "domain" or set of PCI functions.
>
>The techniques of how the HW resources are mapped to PE and associated
>constraints are slightly different from one generation of our chips to
>the next. In general, P7 follows an architecture known as "IODA" and P8
>"IODA2". I'm trying to get that spec made available via OpenPower but
>that hasn't happened yet.
>
>In this case we mostly care about IODA2 (P8), so I'll give a quick
>description here. Wei, feel free to copy/paste that into a bit of doco
>to throw into Documentation/powerpc/ along with your next spin of the patch.
>

Got it.

I will add more description in powerpc directory.


-- 
Richard Yang
Help you, Help me
