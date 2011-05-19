Return-Path: <h.mitake@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 349CD1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 14:08:44 +1000 (EST)
Received: by wyg36 with SMTP id 36so1874623wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 21:08:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4565AEA676113A449269C2F3A549520F80BE7F37@cosmail03.lsi.com>
References: <20110504115324.GE17855@lsi.com>
	<1305616571.6008.23.camel@mulgrave.site>
	<B2FD678A64EAAD45B089B123FDFC3ED70157F7BCE5@inbmail01.lsi.com>
	<20110518041551.GL15227@parisc-linux.org>
	<1305692584.2580.3.camel@mulgrave.site>
	<1305702010.2781.33.camel@pasglop>
	<mpt2sas-writeq-powerpc64@mdm.bga.com>
	<4565AEA676113A449269C2F3A549520F80B66280@cosmail03.lsi.com>
	<x86-32-writeq-is-broken@mdm.bga.com>
	<4565AEA676113A449269C2F3A549520F80BE7F37@cosmail03.lsi.com>
Date: Thu, 19 May 2011 13:08:38 +0900
Message-ID: <BANLkTin4w1QyL1NyTyrZARPWASai45W_4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mpt2sas: remove the use of writeq, since writeq is
	not atomic
From: Hitoshi Mitake <h.mitake@gmail.com>
To: "Moore, Eric" <Eric.Moore@lsi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch <linux-arch@vger.kernel.org>, "Prakash,
	Sathya" <Sathya.Prakash@lsi.com>, "Desai, Kashyap" <Kashyap.Desai@lsi.com>,
	linux scsi dev <linux-scsi@vger.kernel.org>,
	Matthew Wilcox <matthew@wil.cx>,
	linux powerpc dev <linuxppc-dev@lists.ozlabs.org>,
	Milton Miller <miltonm@bga.com>,
	linux kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>,
	linux pci <linux-pci@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 04:11, Moore, Eric <Eric.Moore@lsi.com> wrote:
> On Wednesday, May 18, 2011 12:31 PM Milton Miller wrote:
>> Ingo I would propose the following commits added in 2.6.29 be reverted.
>> I think the current concensus is drivers must know if the writeq is
>> not atomic so they can provide their own locking or other workaround.
>>
>
>
> Exactly.
>

The original motivation of preparing common readq/writeq is that
letting each driver
have their own readq/writeq is bad for maintenance of source code.

But if you really dislike them, there might be two solutions:

1. changing the name of readq/writeq to readq_nonatomic/writeq_nonatomic
2. adding new C file to somewhere and defining spinlock for them.
    With spin_lock_irqsave() and spin_unlock_irqrestore() on the spinlock,
    readq/writeq can be atomic.

How do you think about them? If you cannot agree with the above two solutions,
I'll agree with reverting them.

-- 
Hitoshi Mitake
h.mitake@gmail.com
