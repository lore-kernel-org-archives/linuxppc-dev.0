Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.240])
	by ozlabs.org (Postfix) with ESMTP id 22271DDF35
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 23:34:24 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so13039368agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 06:34:23 -0700 (PDT)
Message-ID: <fa686aa40807070634t6e9047d1k7d8ca2b443d1ae68@mail.gmail.com>
Date: Mon, 7 Jul 2008 07:34:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH] powerpc/bootwrapper: Allow user to specify additional
	default targets
In-Reply-To: <20080707091818.72d584fe@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701175852.32575.39707.stgit@trillian.secretlab.ca>
	<fa686aa40807032351l631febe2h8d38a9eed1053b6b@mail.gmail.com>
	<20080707091818.72d584fe@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 7, 2008 at 7:18 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Fri, 4 Jul 2008 00:51:44 -0600
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
>> Anyone had a chance to look at this?  I think this could be used to
>> eliminate a lot of the platform specific default targets in
>> arch/powerpc/boot/Makefile by moving them into the defconfigs.  Josh,
>> Kumar, what are your thoughts?
>
> So for cases like Kilauea/Haleakala or Bamboo/Yosemite, you would
> specify Yosemite in the bamboo defconfig?  Or?

If they share a defconfig, then yes, that is what I'm thinking about...

> I actually sort of prefer having a separate defconfig/CONFIG_YOSEMITE
> (as an example) because it's much easier for an end user to figure out
> if the board is supported or not.

...however, these don't have to disappear if you prefer them.

> I could be totally misunderstanding the intention of this patch though,
> so I'll stop rambling and wait to see what the use case is.

Specifically the case I'm thinking of is when a user of a Xilinx FPGA
drops a new .dts file into arch/powerpc/boot/dts (say
'super-sexy-platform.dts').  However, instead of modifying the
Makefile or always typing 'make simpleImage.super-sexy-platform', then
can add 'simpleImage.super-sexy-platform' to their defconfig which I
can see being easier for someone to get their head around.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
