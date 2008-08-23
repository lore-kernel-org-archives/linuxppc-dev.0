Return-Path: <vbendeb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id DCE49DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Aug 2008 06:22:41 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1069998rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 13:22:40 -0700 (PDT)
Message-ID: <f608b67d0808231322l239d1014ydf84f53299adc053@mail.gmail.com>
Date: Sat, 23 Aug 2008 13:22:40 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: TLB programming in powerpc tree
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 22, 2008 at 6:24 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Thu, Aug 21, 2008 at 10:14:15PM -0700, vb wrote:
>>On Thu, Aug 21, 2008 at 7:29 PM, vb <vb@vsbe.com> wrote:
>>>
>>> But the main problem is that the kernel never sets up TLBs for neither
>>> the peripheral device, nor the onboard flash. I don't seem to be able
>>> to find the place where this is supposed to happen. I assumed that
>>> ioremap_nocache would take care of that, but this is not the case.
>>>
>>
>>well, in fact the TLB is set up as soon as an attempt to access the
>>peripheral is made. The problem apparently is the fact that the TLB
>>entry uses a wrong value in the nibble specifying the internal 460GT
>>block...
>
> I'm not entirely sure what you mean here.  Can you elaborate a bit more?
>

I was referring to the top 4 MSB of the 36 bit address.

So, I finally was able to access that device after massaging the
device tree definitions for it, but the next device (in a different
branch of the tree) still can not be accessed. What I see is that the
tlb record is created when the access is attempted, but the top
address nibble is 0 instead of 4, even though the device tree now
includes 36 bit addresses with the correct top bits.

I am trying to find code which configures the MMU and to understand
how this whole subsystem works and where the wrong top 4 bits come
from. Is there a document describing 44x powerpc memory management?

/vb

> josh
>
