Return-Path: <prashant.alange@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by ozlabs.org (Postfix) with ESMTP id 0CE4767FDE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 00:57:06 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id b11so1496510rne
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Aug 2005 07:57:05 -0700 (PDT)
Message-ID: <6d145b42050809075718c70574@mail.gmail.com>
Date: Tue, 9 Aug 2005 07:57:05 -0700
From: Prashant Alange <prashant.alange@gmail.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <5c9191bc3e15d90c966735662c28fa5e@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <6d145b42050808193058ee05b4@mail.gmail.com>
	<5c9191bc3e15d90c966735662c28fa5e@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to disable dcache on MPC82xx platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Since the existing UART/ethernet drivers are using cpm_hostalloc() so
I am also using the same function. Then can I use kmalloc() to alloc
such huge memory. If at all I have to configure BATx to just test how
it behaves. How/where to configure BATx. One more thing is that
totally I am allocating about 1MB memory in a chunk of 200K. I really
dont know whether I can do such allocation in driver. But this much is
very much required for my driver. If you have any other idea of
achieving this then please point me in that direction. I need to get
rid of this problme as early as possible to meet my schedule. please
help.

Thanks,
Prashant

On 8/9/05, Dan Malek <dan@embeddededge.com> wrote:
>=20
> On Aug 8, 2005, at 10:30 PM, Prashant Alange wrote:
>=20
> > I am using alloc_bootmem_page() function to allocate memory required
> > in my custom ethernet driver.
>=20
> Why?  Just use the normal Linux memory allocators.
>=20
> >  So I am thinking this could be because of cache since this
> > driver is working fine on non-os platform. I want to disable the
> > dcache for this memory region.
>=20
> This is a fully cache coherent processor, there is no need to
> disable caching, nor is there any easy way to do this in the
> current Linux implementation.  This would require a custom
> kernel, and you couldn't take advantage of the general
> performance gain using BATs.
>=20
> Thanks.
>=20
>        -- Dan
>=20
>
