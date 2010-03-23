Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9C7FB7CCD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 18:43:03 +1100 (EST)
Subject: Re: Virtio_console usage of early printk
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
Date: Tue, 23 Mar 2010 08:42:56 +0100
Message-Id: <C8492FD8-7268-4CC0-BB43-8E0B07113763@suse.de>
References: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
To: =?iso-8859-1?Q?Fran=E7ois_Diakhate?= <fdiakh@gmail.com>
Cc: amit.shah@redhat.com, linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 22.03.2010, at 18:45, Fran=E7ois Diakhate wrote:

> Hi all,
>=20
> As far as I can see, early_put_chars is not used by virtio_console
> because it checks whether there is a port available before using it.
> If I understand correctly, this makes it useless because once we have
> a port, we can use the regular virtio transport to output things to
> the console. Does the attached patch seem valid ? Feedback from s390
> and powerpc users who use this functionality would be appreciated.

On S390 we use the hypercall interface with characters instead of memory =
addresses as parameters. The hypervisor then decides if the character is =
an early printk or a real hypercall.

I'm not sure how PPC handles that - I never used virtio console there.

Either way, early printk does work for S390. So what exactly is this =
patch supposed to fix?


Alex=
