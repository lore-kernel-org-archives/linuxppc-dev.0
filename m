Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE002.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 4F277DDF4C
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 00:39:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
Date: Mon, 30 Jun 2008 08:39:34 -0600
In-Reply-To: <977C41F842E66D4CB2E41332313B615019F061@XSJ-EXCHVS1.xlnx.xilinx.com>
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com><1210271125-11559-1-git-send-email-stephen.neuendorffer@xilinx.com><20080603214232.E0A8D1488061@mail55-wa4.bigfish.com><fa686aa40806060829h52c5d27fvcec8c02c2eee3c7@mail.gmail.com><20080606161932.0650C1500054@mail96-sin.bigfish.com>
	<fa686aa40806281333i5ae1833fg561622640b5d3a4e@mail.gmail.com>
	<977C41F842E66D4CB2E41332313B615019F061@XSJ-EXCHVS1.xlnx.xilinx.com>
From: John Linn <John.Linn@xilinx.com>
To: "Stephen Neuendorffer" <stephenn@xilinx.com>, <grant.likely@secretlab.ca>
Message-ID: <20080630143936.6F0CDA005F@mail196-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git <git@xilinx.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I still have bad dreams about the of_serial patch I did as a newbie
related to reg_shift and reg_offset ;)

I'm still a newbie, but we'll do whatever needs to be done. =


Any thoughts from Josh?

-- John

-----Original Message-----
From: Stephen Neuendorffer =

Sent: Sunday, June 29, 2008 9:42 PM
To: grant.likely@secretlab.ca
Cc: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com;
linuxppc-dev@ozlabs.org; git
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for
'simple-bus'.


Is there really much of a chance of that, given the differences with the
bootwrappers?
Does anyone care enough about legacy_serial for this to matter?   My
impression was that legacy serial was not preferred anyway...

Steve

-----Original Message-----
From: glikely@secretlab.ca on behalf of Grant Likely
Sent: Sat 6/28/2008 1:33 PM
To: Stephen Neuendorffer
Cc: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com;
linuxppc-dev@ozlabs.org; git
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for
'simple-bus'.
 =

On Fri, Jun 6, 2008 at 10:16 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> legacy_serial identifies a valid ns16550 on a simple-bus, but the
> legacy_serial driver doesn't understand the shift and offset flags
> necessary to get it to work, which results in no console.
>
> I think the easiest solution is to change the Kconfig so that
> PPC_UDBG_16550 is only selected based on !XILINX_VIRTEX.  I've done
this
> in my tree, but I've been swamped with other things at the moment, so
I
> haven't verified it.

This is an easy solution, but it is not a good one.  Doing so would
break UDBG on other 405 boards when building multiplatform kernels.
It would be better to teach legacy serial about the shift and offset.
Alternately, add code to add_legacy_soc_port() to skip it if the
shift/offset properties are present.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
