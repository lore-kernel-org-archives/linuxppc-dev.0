Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id 8BB48DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Oct 2007 02:42:35 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so210360nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 Oct 2007 09:42:34 -0700 (PDT)
Message-ID: <fa686aa40710040942x4d4fc871rc73afcb846ddaf93@mail.gmail.com>
Date: Thu, 4 Oct 2007 10:42:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Misbah khan" <misbah_khan@engineer.com>
Subject: Re: Is it safe to use these Linux function (test_bit(), set_bit(),
	clear_bit()) in character device driver for 2.6.10 ppc kernel.
In-Reply-To: <13039401.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12916782.post@talk.nabble.com> <46FBD483.6090403@freescale.com>
	<12934517.post@talk.nabble.com> <46FC8EFE.2000108@mock.com>
	<12937117.post@talk.nabble.com> <12966462.post@talk.nabble.com>
	<20071001042559.GA32255@lixom.net> <12973587.post@talk.nabble.com>
	<20071001135516.GA8572@lixom.net> <13039401.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/4/07, Misbah khan <misbah_khan@engineer.com> wrote:
>
> Hi ...
> I did followed you and it worked as well. I really Thank you for it.
>
> At one Place i am doing memcpy() of floating point data to the memory mapped
> registers, what could be the substitute of it like "memcpy_toio() " which is
> suggested in the Book. I am working BE architecture.
>
> I would really appreaciate if you would let me know the defineation of these
> wrapper functions (in_be32,out_be32(),ioread32(),iowrite32(),etc) so that i
> could have the clear idea of the reason for not directly dreferencing the
> Pointer.

You don't want to directly dereference pointers to device registers
because you don't want the processor or compiler to reorder your
register accesses.  The in/out_* wrappers keeps the compiler from
reordering things, and the wrappers contain the 'sync' instruction
which prevents the processor from reordering operations at runtime.

g.
-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
