Return-Path: <madhvesh.s@ap.sony.com>
Received: from VA3EHSOBE006.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 76CD1DDF02
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 00:11:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [RFC] Kprobes for book-e
Date: Mon, 9 Jun 2008 19:40:59 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D28F224@insardxms01.ap.sony.com>
From: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote on Tuesday, June 03, 2008 9:16 PM
> To: Sulibhavi, Madhvesh
> Cc: rsmadhvesh@vsnl.net; ananth@in.ibm.com;=20
> linuxppc-dev@ozlabs.org; Paul Mackerras
> Subject: Re: [RFC] Kprobes for book-e

..<snip>
>=20
> >
> > I think the block code under CONFIG_BOOKE may not
> > be required now if exception cleanup fixes address the stack
> > problem which i had explained in my port. I have to look into
> > exception fix patches and confirm about these changes. Can
> > you please provide me the thread where exception cleanup
> > is posted as i haven't tracked the list from long time.
>=20
> http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056457.html
>=20
> What was the original thinking about why you had to enable=20
> MSR_EE and =20
> MSR_CE?

I found that this code is redundant and it was added while debugging
the flags status during my port. This is a bug since it modifies the MSR

status and enables the critical and external bits which is not supposed
to.
The interrupts status should be kept back to original state without
enabling
interrupt bits after executing the post_handler. So this change is not
valid
and it can be taken out.

The code within the "prepare_single_step()" is already doing the job=20
of disabling interrupts and setting bits required for single step and
hence
no additional changes are required for Book-e version of kprobes.

I confirmed the above changes in my local tree and found no issues
for kprobes, jprobes and kretprobes. But this testing is done using
2.6.22.y+ppc arch.

Once after fixing the binutils-2.17 issue i am facing for latest kernel,

i will retest and inform if any problems to new patches.=20

-madhvesh



-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
