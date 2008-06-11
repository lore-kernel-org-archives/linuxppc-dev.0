Return-Path: <vbendeb@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id E3F21DE000
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 01:34:09 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1885994ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 08:33:57 -0700 (PDT)
Message-ID: <f608b67d0806110833h3675232pbaee901ea2664568@mail.gmail.com>
Date: Wed, 11 Jun 2008 08:33:57 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: "Jon Loeliger" <jdl@freescale.com>
Subject: Re: PPC to PowerPC Migration
In-Reply-To: <484FDB3D.4040101@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
	<484FDB3D.4040101@freescale.com>
Cc: Mike Timmons <mike_timmons@trimble.com>,
	Andy Schmidt <andrewgschmidt@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2008 at 7:03 AM, Jon Loeliger <jdl@freescale.com> wrote:
> vb wrote:
>>
>> I recently ported two platforms (8245 and 8541) from ppc tree in
>> earlier 2.6 versions into powerpc tree in 2.6.25. It is amazing how
>> little the device tree contents are described, a lot of things
>> required reverse engineering of the kernel code to understand the
>> meaning of some numbers in the  tree.
>>
>> I am also willing to contribute into a document describing this
>> transition, please keep me in the loop,
>>
>> regards,
>> Vadim
>
>
> Well, perhaps as a starting point you could tell us
> which things required reverse engineering or what you
> were not able to find in a document?
>


wow, where do I begin here :-)

my favorite was interrupt-map in PCI section:  A typical value would
look like this:

                interrupt-map = <

                        /* IDSEL 0x10 */
                        08000 0 0 1 &mpic 0 1
                        08000 0 0 2 &mpic 1 1
                        08000 0 0 3 &mpic 2 1
                        08000 0 0 4 &mpic 3 1


                        [ repeated per IDSEL ]

               >

I don't see 'interrupt-map' mentioned anywhere in the ./Documentation
tree - it took me a while to find out what these numbers actually
meant.

cheers,
Vadim



> Thanks,
> jdl
>
