Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 40753DE0B9
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 03:48:05 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so290969anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 10:48:04 -0700 (PDT)
Message-ID: <fa686aa40805161048s3a9d9959v205b0fabd66a751d@mail.gmail.com>
Date: Fri, 16 May 2008 11:48:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Remi Machet" <rmachet@slac.stanford.edu>
Subject: Re: [PATCH 1/5] powerpc: DTS file for the C2K
In-Reply-To: <1210958434.14306.9.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1210897371.13992.13.camel@pcds-ts102.slac.stanford.edu>
	<20080516015354.GA27188@yookeroo.seuss>
	<1210958434.14306.9.camel@pcds-ts102.slac.stanford.edu>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 11:20 AM, Remi Machet <rmachet@slac.stanford.edu> wrote:
> On Fri, 2008-05-16 at 11:53 +1000, David Gibson wrote:
>> This is a suspicious looking use of cell-index, though again this
>> could be a problem in the binding rather than your tree per se.
>> cell-index should *only* be present if it's used to index into some
>> shared resource register.
> This is actually my mistake: I use this property in
> arch/powerpc/boot/c2k.c to differentiate the 2 PCI buses. What property
> should I use instead ? I could detect the PCI bus # based on the reg
> property (memory base can change but not the registers address), what do
> you think ?

Use either the base address (a little ugly) or create a couple of
properties under the aliases node with the path to the two PCI busses
(cleaner, but a slight bit more work).

ie:

aliases {
       pci-bus1 = &pci1;
       pci-bus2 = &pci2;
};

Cheers,
g.

>
> Remi
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
